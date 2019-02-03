docker build -t darvs/eqb-spam:v02.01 -t darvs/eqb-spam:latest .

NAME=${1:-spam}

[ -z "$(docker ps -q -f name=${NAME})" ] || docker stop ${NAME}
[ -z "$(docker ps -a -q -f name=${NAME})" ] || docker rm ${NAME}

DOCKERHOST=$(ip route get 8.8.8.8 | cut -d' ' -f7)

docker run -d --name ${NAME}\
	-u $(id -u):$(id -g) \
	-v $(pwd)/testnet-alpha/contrib/eqb-spam:/spam \
	--add-host dockerhost:${DOCKERHOST} \
	-e SPAM_URLS="http://equibit:equibit@192.168.0.175:18331; http://equibit:equibit@dockerhost:18331" \
	-e SPAM_FAKE="0" \
	-e SPAM_ROUNDS="20" \
	-e SPAM_INTERVAL="1" \
	-e SPAM_LOG="1" \
	darvs/eqb-spam:latest

#docker exec -it spam sh
docker logs -f ${NAME}
