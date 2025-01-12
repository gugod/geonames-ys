## Vars for ys.
YS=YSPATH=${PWD}/lib ys

## Rules for managers

.PHONY: all fetch clean cleanFetch cleanAll

all: data/countryInfo.yml

fetch: data/cities500.txt

clean:
	rm -f data/*.yml

cleanFetch:
	rm -f data/cities500.zip data/cities500.txt

cleanAll: clean cleanFetch

## Rules for converting from whatever to .yml
data/countryInfo.yml: data/countryInfo.txt bin/convert-countryInfo.ys
	${YS} bin/convert-countryInfo.ys $< > $@

## Rules for fetching original data files from geonames

data/countryInfo.txt:
	curl -o $@ https://download.geonames.org/export/dump/countryInfo.txt

data/cities500.txt: data/cities500.zip
	(cd data; unzip cities500.zip)

data/cities500.zip:
	curl -o $@ https://download.geonames.org/export/dump/cities500.zip
