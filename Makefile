up-all:
	echo "\n############################ RUNNING: runner ############################\n" && cd ./runner/dev && ./run-docker.sh && cd ../../ \
	&& echo "\n############################ RUNNING: test ############################\n" && cd ./tests/dev && ./run-docker.sh && cd ../../

kill-all:
	cd ./runner/dev && docker-compose kill && cd ../../ \
	&& cd ./tests/dev && docker-compose kill && cd ../../