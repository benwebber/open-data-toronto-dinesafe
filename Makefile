DATA := $(shell find data -type f)
DB := dinesafe.db

.DEFAULT_GOAL := dist

$(DB): data.db sql/dinesafe.sql
	sqlite3 -cmd "ATTACH '$<' AS data" $@ <sql/dinesafe.sql

data.db: $(DATA) sql/data.sql
	sqlite3 -csv $@ <sql/data.sql

%.gz: $(DB)
	gzip --force --keep --stdout $< >$@

requirements.txt:
	uv pip compile pyproject.toml >requirements.txt

.PHONY: clean
clean:
	$(RM) -r $(DB) dist/

.PHONY: dist
dist:
	mkdir -p dist
	make dist/$(DB).gz
	cd dist && sha256sum *.gz >SHA256SUMS

.PHONY: fetch
fetch:
	./bin/fetch
