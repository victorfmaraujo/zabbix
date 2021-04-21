url="https://apiintegracao.milvus.com.br/api/chamado/criar"
token="TOKEN AQUI"
email="teste@teste.com.br"
contato="ZABBIX"
subject="ERRO TESTE #CLIENTE TESTE |CODIGO CLIENTE AQUI|#"
message="TESTE ZABBIX"


#echo "${url}" "${token}" "${email}" "${contato}" "${subject}" "${message}"

./milvus.sh "${url}" "${token}" "${email}" "${contato}" "${subject}" "${message}"

echo "$?"