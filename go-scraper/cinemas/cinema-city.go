package cinemas

import (
	"fmt"
	"log/slog"
	"net/http"
	"time"

	"github.com/mcrors/cinema-agg/go-scraper/scraper"
)

type CinemaCity struct {
	logger            *slog.Logger
	cinemaListURL     string
	cinemaListingsURL string
	toDate            time.Time
	httpClient        http.Client
}

func NewCinemaCity(logger *slog.Logger, timeout time.Duration) CinemaCity {
	now := time.Now()
	client := http.Client{
		Timeout: timeout,
	}

	return CinemaCity{
		logger:            logger,
		cinemaListURL:     "https://www.cinemacity.cz/cz/data-api-service/v1/quickbook/10101/cinemas/with-event/until/{date}?attr=&lang=en_GB",
		cinemaListingsURL: "https://www.cinemacity.cz/cz/data-api-service/v1/quickbook/10101/film-events/in-cinema/{cinema_id}/at-date/{date}?attr=&lang=en_GB",
		toDate:            now.Add(14 * 24 * time.Hour),
		httpClient:        client,
	}
}

func (c CinemaCity) GetData() []scraper.MovieData {
	return nil
}

func (c CinemaCity) getCinemaList() ([]scraper.CinemaData, error) {
	resp, err := c.httpClient.Get(c.cinemaListURL)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
zsh:1: no such file or directory: ATXfne1F1nncinemas/cinema-city.go
		return nil, fmt.Errorf("error: recieved status code %d", resp.StatusCode)
	}
	return nil, nil
}

// response = requests.get(self._cinema_list_url.format(date=date))
// data = response.json()
// cinemas = []
// for cinema in data["body"]["cinemas"]:
// if cinema["groupId"] == "prague":
// c = CinemaData(
// cinema_website_name=self.name,
// cinema_self_id=cinema["id"],
// cinema_name=cinema["displayName"],
// cinema_address=cinema["address"]
// )
// cinemas.append(c)
// return cinemas

