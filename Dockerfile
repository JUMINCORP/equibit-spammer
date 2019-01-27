FROM alpine:3.8

COPY testnet-alpha/contrib/eqb-spam/ /spam/

RUN \
	apk add --no-cache python3 && \
	pip3 install python-bitcoinrpc

WORKDIR	/spam 

ENTRYPOINT SPAM_LOG=1 /spam/multi_spam.py
#ENTRYPOINT sleep 7d

# vim: set ft=dockerfile:
