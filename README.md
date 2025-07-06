# DineSafe

This is a [Git scraping](https://simonwillison.net/series/git-scraping/) mirror of Toronto's [DineSafe](https://open.toronto.ca/dataset/dinesafe/) data.

> DineSafe is Toronto Public Health’s food safety program that inspects all establishments serving and preparing food.
> Each inspection results in a pass, a conditional pass or a closed notice.

## Database

This project builds an SQLite database of the data, as well as a [Datasette](https://datasette.io/) image to explore the data.
Download the [latest version](https://github.com/benwebber/open-data-toronto-dinesafe/releases/latest) of database from the [releases](https://github.com/benwebber/open-data-toronto-dinesafe/releases) page.

Run the latest published image with Docker:

```
docker run -p 8000:8000 ghcr.io/benwebber/open-data-toronto-dinesafe:latest
```

Or build the database locally and run the image with Docker Compose:

```
make dinesafe.db
docker compose up
```


## Licence

The City of Toronto makes this data available under the terms of [Open Government Licence – Toronto](https://open.toronto.ca/open-data-licence/).
