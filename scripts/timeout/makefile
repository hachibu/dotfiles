default:
	@mkdir -p bin
	@rm -rf bin/*
	crystal build src/timeout.cr -o bin/timeout --release
	@rm -rf bin/timeout.dwarf

start: default
	nohup ./bin/timeout > tmp/timeout.log &

stop:
	pgrep timeout | xargs kill
