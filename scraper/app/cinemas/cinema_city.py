import datetime
import logging
import requests
from typing import List

from models import CinemaData, MovieData

class CinemaCity:

    def __init__(self, logger: logging.Logger):
        self._logger = logger
        self._cinema_list_url = "https://www.cinemacity.cz/cz/data-api-service/v1/quickbook/10101/cinemas/with-event/until/{date}?attr=&lang=en_GB"
        self._cinema_listings_url = "https://www.cinemacity.cz/cz/data-api-service/v1/quickbook/10101/film-events/in-cinema/{cinema_id}/at-date/{date}?attr=&lang=en_GB"
        self._to_date = datetime.date.today() + datetime.timedelta(days=14)
        self._logger.info(f"to_date: {self._to_date}")

    @property
    def name(self):
        return "Cinema City"

    def get_data(self) -> List[MovieData]:
        processing_date = datetime.date.today()
        data = []
        while processing_date <= self._to_date:
            data.extend(self._process_date(processing_date))
            processing_date += datetime.timedelta(days=1)
        return data

    def _process_date(self, date) -> List[MovieData]:
        cinemas = self._get_cinema_list(date)
        movies = []
        for cinema in cinemas:
            self._logger.info(f"processing: {date} : {self.name} : {cinema.cinema_name}")
            movie_listing_data = self._get_movie_listings(cinema.cinema_self_id, date)
            for movie in movie_listing_data["films"]:
                for event in movie_listing_data["events"]:
                    if event["filmId"] == movie["id"]:
                        m = MovieData(
                            cinema_data=cinema,
                            movie_name=movie["name"],
                            running_time=movie["length"],
                            release_year=movie["releaseYear"],
                            dubbed=True if "dubbed" in event["attributeIds"] else False,
                            booking_url=event["bookingLink"],
                            listing_date= datetime.datetime.strptime(event["eventDateTime"], "%Y-%m-%dT%H:%M:%S").date(),
                            listing_time=datetime.datetime.strptime(event["eventDateTime"], "%Y-%m-%dT%H:%M:%S").time(),
                        )
                        movies.append(m)
        return movies

    def _get_cinema_list(self, date) -> List[CinemaData]:
        response = requests.get(self._cinema_list_url.format(date=date))
        data = response.json()
        cinemas = []
        for cinema in data["body"]["cinemas"]:
            if cinema["groupId"] == "prague":
                c = CinemaData(
                    cinema_website_name=self.name,
                    cinema_self_id=cinema["id"],
                    cinema_name=cinema["displayName"],
                    cinema_address=cinema["address"]
                )
                cinemas.append(c)
        return cinemas

    def _get_movie_listings(self, cinema_id, date):
        response = requests.get(self._cinema_listings_url.format(cinema_id=cinema_id, date=date))
        data = response.json()
        return {
            "films": data["body"]["films"],
            "events": data["body"]["events"],
        }

