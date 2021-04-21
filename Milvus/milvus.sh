#!/bin/bash

url="$1"
token="$2"
email="$3"
contato="$4"
subject="$5"
message="$6"

auth="Authorization: ${token}"
ct="Content-Type: application/json"

clienteId=$(echo $subject| cut -d'|' -f 2)

subject=$(echo $subject| cut -d'#' -f 1)

if [ ${#url} == 0 ] || [ ${#token} == 0 ] || [ ${#email} == 0 ] || [ ${#contato} == 0 ] || [ ${#clienteId} == 0 ] ; then
        exit 0
fi

subject=${subject//\"/\\\"}
message=${message//\"/\\\"}
message=${message//$'\r'/ }
message=${message//$'\n'/ }
message=${message//\\r/ }
message=${message//\\n/ }

data="{ \"cliente_id\": \"${clienteId}\", \"chamado_assunto\": \"${subject}\", \"chamado_descricao\": \"${message}\", \"chamado_email\": \"${email}\", \"chamado_contato\": \"${contato}\" }"

curl -m 5 --location --request POST "${url}" --header "${auth}" --header "${ct}" --data-raw "${data}"