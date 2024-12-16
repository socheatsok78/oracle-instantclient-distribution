it:
	docker buildx bake --print
build:
	docker buildx bake --print dev
	docker buildx bake --load dev
run:
	docker run --rm -it soramitsukhmer/oracle-instant-client:dev
