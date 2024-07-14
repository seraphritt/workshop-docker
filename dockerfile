# Imagem base
FROM python:3.8-slim

# Diretório de trabalho
WORKDIR /api

# Copia os arquivos para o contêiner
COPY . /api

# Instala as dependências
RUN pip install --no-cache-dir Flask
RUN pip install --no-cache-dir python-dotenv

# Argumento de build
ARG API_PORT

# Variável de ambiente
ENV API_PORT=${API_PORT}

# Expõe a porta que a aplicação vai usar
EXPOSE ${API_PORT}

# Comando para rodar a aplicação
CMD ["python", "my_api.py"]
