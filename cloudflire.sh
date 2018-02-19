#!/bin/bash

APIKEY="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" #apikey из акаунта CF
DOMAIN="domain.ru" #Имя домена второго уровня
USERNAME="username@emailserver.ru" #Username он же email от акаунта CF
IP=$(curl -s http://ipv4.icanhazip.com)
#echo $IP

CASH_FILE="cash.txt"

if [ ! -f $CASH_FILE ]; then touch $CASH_FILE; fi
CURRENT=$(<$CASH_FILE)

if [ "$IP" == "$CURRENT" ]; then exit 0; fi
echo $IP > $CASH_FILE

#Получаем ID зоны
ZID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$DOMAIN&status=active&page=1&per_page=20&order=status&direction=desc&match=all" -H "X-Auth-Email: $USERNAME" -H "X-Auth-Key: $APIKEY" -H "Content-Type: application/json" | grep -Po '(?<="result":\[{"id":")[^"]*') 
#echo $ZID


#Получаем иднтификатор домена
IDENTIFER=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZID/dns_records?name=$DOMAIN" -H "X-Auth-Email: $USERNAME" -H "X-Auth-Key: $APIKEY" -H "Content-Type: application/json" | grep -Po '(?<="id":")[^"]*')
#echo $IDENTIFER


#Толкаем наш ip на сервер CF
curl -X PUT "https://api.cloudflare.com/client/v4/zones/$ZID/dns_records/$IDENTIFER" \
	-H "X-Auth-Email: $USERNAME" \
	-H "X-Auth-Key: $APIKEY" \
	-H "Content-Type: application/json" \
	--data "{\"type\":\"A\",\"name\":\"$DOMAIN\",\"content\":\"$IP\",\"ttl\":1,\"proxied\":false}"

# Толкаем уведомление на телефон через PushALL