default: npm-deps purs-build parcel-build

start:
	yarn parcel src/index.html

npm-deps:
	yarn

purs-build:
	yarn spago build

purs-watch:
	yarn spago build -w

parcel-build:
	yarn parcel build src/index.html

parcel-serve:
	yarn parcel serve src/index.html  output/

build:
	make purs-build
	make parcle-build

dev-server:
	yarn concurrently "make purs-watch" "make parcel-serve"