.PHONY: build run clean

build:
	mix deps.get
	mix compile

run:
	./run.sh

clean:
	mix clean
	rm -f map_reduce
