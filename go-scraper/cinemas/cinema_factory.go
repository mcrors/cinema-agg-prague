package cinemas

import (
	"log/slog"
	"time"

	"github.com/mcrors/cinema-agg/go-scraper/scraper"
)

type CinemaDataGetter interface {
	GetData() []scraper.MovieData
}

func CinemaWebsiteFactory(logger *slog.Logger) []CinemaDataGetter {
	timeout := 10 * time.Second
	cinemaCity := NewCinemaCity(logger, timeout)
	result := []CinemaDataGetter{
		cinemaCity,
	}
	return result
}
