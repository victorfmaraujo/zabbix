url="https://apiintegracao.milvus.com.br/api/chamado/criar"
token="P1npPSy48aDWzRICRCRkDAfOLIhbKY3TcJ9eRJKXAALJKOFQye9LXKG9epqxxknzbPg9BojAo9VWJSkRqucEVPoR9GcYm3GZwBVhv"
email="teste@teste.com.br"
contato="ZABBIX"
subject="ERRO TESTE #CLIENTE TESTE |928JWL|#"
message="TESTE ZABBIX"


#echo "${url}" "${token}" "${email}" "${contato}" "${subject}" "${message}"

./milvus.sh "${url}" "${token}" "${email}" "${contato}" "${subject}" "${message}"

echo "$?"