## Vars for ys.
YS=YSPATH=${PWD}/lib ys
CURL=curl --silent

## Rules for managers

.PHONY: all fetch clean cleanFetch cleanAll

all: data/countryInfo.yml data/cities500.yml

fetch: data/cities500.txt

clean:
	rm -f data/*.yml

cleanFetch:
	rm -f data/*.zip data/*.txt

cleanAll: clean cleanFetch

## Rules for converting from whatever to .yml
data/cities500.yml: data/cities500.txt bin/convert-cities.ys
	${YS} bin/convert-cities.ys $< > data/.tmp && mv data/.tmp $@

data/countryInfo.yml: data/countryInfo.txt bin/convert-countryInfo.ys
	${YS} bin/convert-countryInfo.ys $< > data/.tmp && mv data/.tmp $@

## Rules for fetching original data files from geonames

data/readme.txt:
	${CURL} -o $@ https://download.geonames.org/export/dump/readme.txt

data/countryInfo.txt:
	${CURL} -o $@ https://download.geonames.org/export/dump/countryInfo.txt

data/cities500.txt: data/cities500.zip
	(cd data; unzip -Du cities500.zip)

data/cities500.zip:
	${CURL} -o $@ https://download.geonames.org/export/dump/cities500.zip
