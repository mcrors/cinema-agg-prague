package scraper

import "time"

type CinemaData struct {
	CinemaWebsiteName string
	CinemaSelfId      int
	CinemaName        string
	CinemaAddress     string
}

type MovieData struct {
	Cinema          CinemaData
	MovieName       string
	RunningTime     int
	ReleaseYear     int
	dubbed          bool
	BookingURL      string
	ListingDateTime time.Time
}
