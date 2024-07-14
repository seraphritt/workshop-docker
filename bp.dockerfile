# Use a imagem base do Botpress
FROM botpress/server:v12_26_7

# Defina o diretório de trabalho
WORKDIR /botpress

# Crie o diretório NLU
RUN mkdir -p /botpress/NLU
RUN cd NLU/
# Baixe os arquivos necessários para a pasta NLU
# Substitua os URLs pelos URLs reais dos arquivos que você precisa
RUN apt-get update && apt-get install -y wget && \
    wget --progress=bar http://botpress-public.nyc3.digitaloceanspaces.com/embeddings/bp.pt.bpe.model && \
    wget --progress=bar http://botpress-public.nyc3.digitaloceanspaces.com/embeddings/bp.pt.100.bin && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN cd ..
# Copie os arquivos de configuração para o contêiner
COPY ./data /botpress/data

# Defina as variáveis de ambiente
ARG POSTGRES_USER
ARG POSTGRES_PASSWORD
ARG POSTGRES_DB
ARG POSTGRES_IP_PORT
ENV BP_PRODUCTION=true
ENV BP_HTTP_PORT=3000
ENV DATABASE_URL=postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres:5432/${POSTGRES_DB}


# Exponha as portas necessárias
EXPOSE 3000
EXPOSE 3100
EXPOSE 8000

# Comando para iniciar o Botpress com Duckling e o serviço de linguagem
CMD ["bash", "-c", "./duckling & ./bp lang --offline --dim 100 --langDir /botpress & ./bp"]