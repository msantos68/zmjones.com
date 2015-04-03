all: build clean upload

BUILD_PATH=/Users/zmjones/Sites/zmjones.com/build/

build:
	python app.py build
	mv ./build/static/robots.txt ./build/

upload:
	aws s3 sync --delete --exact-timestamps $(BUILD_PATH) s3://zmjones.com/

analytics:
	aws s3 sync --quiet s3://zmjones-logs/ ./logs/
	python static/analytics/parse.py
	Rscript static/analytics/analyze.R

clean:
	find . | egrep ".*((\.(aux|log|out|DS_Store|Rhistory)))$$" | xargs rm
	rm -rf auto
