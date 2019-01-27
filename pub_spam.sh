NAME=spam
[ -z "$(docker ps -q -f name=${NAME})" ] || docker stop ${NAME}
[ -z "$(docker ps -a -q -f name=${NAME})" ] || docker rm ${NAME}

DOCKERHOST=$(ip route get 8.8.8.8 | cut -d' ' -f7)

docker run -d --name ${NAME}\
	--add-host dockerhost:${DOCKERHOST} \
	-e SPAM_URLS="http://equibit:equibit@dockerhost:18331" \
	-e SPAM_FAKE=0 \
	darvs/eqb-spam:v01.00

#docker exec -it spam sh
docker logs -f spam
