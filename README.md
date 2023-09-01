# The open Open Banking Brasil project - Agregate CRL's
Agrega a lista de CRL's das CA's do Open Finance para ser utilizado no Nginx

## CA's suportadas
A lista de entidades suportadas no Open Finance pode ser vista [neste endereço](https://openfinancebrasil.atlassian.net/wiki/spaces/OF/pages/82313425/PT+Padr+o+de+Certificados+Open+Finance+Brasil+2.0#Autoridades-Certificadoras-Participantes-%7B%23AutoridadesCertificadorasParticipantes%7D)

## Lista de CRL's
A lista de url's foi obtida através de pesquisa nos sites das CA's.

### Soluti
http://ccd2.acsoluti.com.br/#/home

### Serpro
https://repositorio.serpro.gov.br/lcr/index.html

### Serasa
https://serasa.certificadodigital.com.br/repositorio/

### Certisign
http://icp-brasil.certisign.com.br/repositorio/

## Como utilizar
Faça download dos arquivos *crl_urls.txt* e *create_crl.sh* para o mesmo diretório.
Execute o script create_crl.sh.

```
./create_crl.sh
```

O comando acima irá produzir o arquivo *revoked.pem*

### Utilizando no nginx
Para utilizar o arquivo revoked.crl no nginx, copie o arquivo para um diretório que o nginx possua acesso e use o atributo abaixo para indicar a utilização do arquivo
```
ssl_crl /mypath/revoked.pem
```

Obs: Cada vez que o arquivo for atualizado é necessário realizar o reload no nginx para que a nova versão do arquivo seja aplicada.
```
service nginx reload
```
