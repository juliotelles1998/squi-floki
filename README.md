# Squid Proxy Container

Este container é baseado no **Squid**, um servidor proxy altamente configurável utilizado para cache, controle de acesso e otimização de tráfego. Ele foi configurado para atender a requisitos específicos, como permitir acesso apenas a determinados domínios ou implementar um proxy transparente.

## Funcionalidades

- Proxy HTTP/HTTPS utilizando o **Squid**.
- Configuração personalizada com controle de acesso por ACL.
- Suporte para fuso horário configurável via variável de ambiente `TZ`.

## Requisitos

- **Docker** instalado na máquina local.
- **Git** para clonar o repositório.
- Porta `3128` disponível para o serviço proxy.

## Como executar localmente

### 1. **Clonar o repositório**

Primeiro, clone o repositório que contém o Dockerfile e as configurações necessárias para o Squid.

```bash
git clone https://github.com/juliotelles1998/squid-docker.git
cd squid-docker
2. Construir a imagem Docker
Depois de clonar o repositório, construa a imagem Docker localmente com o seguinte comando:

bash
Copiar código
docker build -t squid-floki .
-t squid-floki: Define o nome da imagem como squid-floki.
3. Executar o container
Agora, execute o container utilizando o comando abaixo. O parâmetro TZ define o fuso horário do container, que pode ser alterado conforme necessário.

bash
Copiar código
docker run -d \
  --name squid-container \
  -e TZ=UTC \
  -p 3128:3128 \
  squid-floki
Parâmetros explicados:
--name squid-container: Define o nome do container como squid-container.
-e TZ=UTC: Configura o fuso horário do container para UTC. Substitua UTC por outro fuso horário, se necessário (ex.: America/Sao_Paulo).
-p 3128:3128: Mapeia a porta do Squid no container para a porta 3128 na máquina host.
squid-floki: Nome da imagem construída localmente.
Acessando o Proxy
Após o container estar em execução, configure seu navegador ou aplicativo para utilizar o proxy com o IP ou hostname da máquina host e porta 3128.

Exemplo de configuração de proxy:

Servidor Proxy: http://<seu-host>:3128
Porta: 3128
Logs e Depuração
Visualizar logs do Squid no container:
bash
Copiar código
docker logs squid-container
Reiniciar o container:
bash
Copiar código
docker restart squid-container
Encerrando o container
Para parar e remover o container:

bash
Copiar código
docker stop squid-container && docker rm squid-container
