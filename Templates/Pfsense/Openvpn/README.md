# Monitoramento de Túnel Openvpn - Pfsense (Lado CLiente)


<h3>Pré Requisitos - Parte 1:</h3>

1 - Zabbix-Agent já instalado


2 - Instalar o pacote sudo no pfsense


3 - Dar permissão pro grupo wheel "NO PASSWORD" System -> Sudo


4 - Adicionar os parâmetros contidos no arquivo UserParameters.openvpn.clients

<h3>Baixar arquvios e scripts - Parte 2:</h3>

Diagnostics > command Prompt


executar o comando abaixo


fetch -q -o - https://raw.githubusercontent.com/victorfmaraujo/zabbix/master/Templates/Pfsense/Openvpn/Client/auto-config.sh | sh

<h3>Recomendações:</h3>

1 - Sugiro colocar Timeout=30

2 - Não coloque na descrição do túnel Caracteres especiais pois irá quebrar o LLD, utilize apenas caracteres alfanuméricos.
