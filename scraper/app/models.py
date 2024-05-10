from dataclasses import dataclass
import datetime


@dataclass
class CinemaData():
    cinema_website_name: str
    cinema_self_id: int
    cinema_name: str
    cinema_address: str


@dataclass
class MovieData():
    cinema_data: CinemaData
    movie_name: str
    running_time: int
    release_year: int
    dubbed: bool
    booking_url: str
    listing_date: datetime.date
    listing_time: datetime.time

