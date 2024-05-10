from cinema_factory import CinemaFactory
from scraper_logger import get_logger


def main():
    logger = get_logger()
    logger.info("starting scraper")

    cinemas = CinemaFactory(logger).get_cinemas()

    for cinema in cinemas:
        logger.info(f"processing {cinema.name}")
        data = cinema.get_data()
        logger.info(data)


if __name__ == "__main__":
    main()
