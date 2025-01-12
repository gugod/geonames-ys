all: data/countryInfo.yaml

data/countryInfo.yaml: data/countryInfo.txt bin/convert-countryInfo.ys
	bin/convert-countryInfo.ys $< > $@

data/countryInfo.txt:
	curl -o $@ https://download.geonames.org/export/dump/countryInfo.txt
