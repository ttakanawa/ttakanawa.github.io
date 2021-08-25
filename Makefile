install:
	docker-compose up -d
	docker-compose logs -f
	docker-compose stop
up:
	docker-compose up --abort-on-container-exit