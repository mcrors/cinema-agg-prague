package main

import (
	"log/slog"
	"os"

	"github.com/mcrors/cinema-agg/go-scraper/scraper"
)

func main() {
	logger := slog.New(slog.NewJSONHandler(os.Stdout, nil))
	logger.Info("starting scraper")

	cinames := scraper.CinemaWebsiteFactory(logger)

}
