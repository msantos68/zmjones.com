all: build clean upload

BUILD_PATH=/Users/zmjones/Sites/zmjones.com/build/

build:
	python app.py build
	mv ./build/static/robots.txt ./build/

upload:
	aws s3 sync --recursive --delete --size-only $(BUILD_PATH) s3://zmjones.com/
	rm -rf build

analytics:
	cd static/analytics && python parse.py && Rscript analyze.R && zip traffic.zip *

clean:
	find . | egrep ".*((\.(aux|log|out|DS_Store|Rhistory)))$$" | xargs rm
	rm -rf auto


