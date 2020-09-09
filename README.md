# Comandos e Comentários - Camalearning SQL

# Setup

## Iniciando o Servidor

- Criar conta e entrar na Hetzner Cloud
- Criar novo servidor - Ubuntu 20.04
- Comando para conectar no servidor: `ssh root@IP.DO.SERVIDOR`

## Instalando utilitários

- Atualizar Servidor: `sudo apt update && sudo apt upgrade`
- Baixar Docker: `sudo apt install docker.io`
- Instalando a biblioteca do PostgreSQL para Linux: `sudo apt install libpq-dev`

## Iniciando a Base de dados

- Vamos rodar o PostgreSQL

```bash
sudo docker run --name tutorial -p 5433:5432 \
                -e POSTGRES_PASSWORD=senha123 \
                -d postgres

# OBSERVAÇÃO
# Se precisar entrar na Shell do Postgres, usar o comando:
sudo docker exec -it tutorial psql -U postgres

# Pra sair é "Ctrl + D"
```

# Setup da API - PostgREST

- Baixar o executável PostgREST: `wget https://github.com/PostgREST/postgrest/releases/download/v7.0.1/postgrest-v7.0.1-linux-x64-static.tar.xz`
- Extraindo o PostgREST: `tar -xJf postgrest-v7.0.1-linux-x64-static.tar.xz`
- Criar arquivo de configuração: `nano postgrest.conf`

```bash
db-uri = "postgres://postgres:senha123@localhost:5433/postgres"
db-schema = "public"
db-anon-role = "postgres":
```

## Usando o Azure Data Studio

- Baixar Azure Data Studio
- Baixar a extensão "PostgreSQL"
- Ir em New Connection

![Comandos%20e%20Comenta%CC%81rios%20-%20Camalearning%20SQL%20944598d29f9f425db8513163ab20acb6/Untitled.png](Comandos%20e%20Comenta%CC%81rios%20-%20Camalearning%20SQL%20944598d29f9f425db8513163ab20acb6/Untitled.png)

A senha é a mesma que usamos pra criar a base de dados no docker, no nosso caso "senha123"

### OBS: Se não usou um servidor, IP é o padrão [localhost](http://localhost) (127.0.0.1)

### OBS 2: Porta do PostgreSQL (5432 OU 5433)

![Comandos%20e%20Comenta%CC%81rios%20-%20Camalearning%20SQL%20944598d29f9f425db8513163ab20acb6/Untitled%201.png](Comandos%20e%20Comenta%CC%81rios%20-%20Camalearning%20SQL%20944598d29f9f425db8513163ab20acb6/Untitled%201.png)

# Queries

## Criando tabelas

```sql
DROP TABLE IF EXISTS modalidades;
CREATE TABLE modalidades (
    id INTEGER PRIMARY KEY,
    descricao TEXT
);

DROP TABLE IF EXISTS cursos;
CREATE TABLE cursos (
    id INTEGER PRIMARY KEY,
    nome TEXT,
    tipo TEXT,
    periodo TEXT,
    vagas INTEGER,
    campus TEXT,
    cidade TEXT,
    estado TEXT,
    universidade TEXT,
    sigla TEXT
);

DROP TABLE IF EXISTS resultados;
CREATE TABLE resultados (
    id_curso INTEGER,
    nome_curso TEXT,
    id_modalidade INTEGER,
    vagas INTEGER,
    nota_minima DOUBLE PRECISION,
    bonus DOUBLE PRECISION,
    data_informacao TEXT
    PRIMARY KEY (id_curso, id_modalidade)
);
```

## Importando dados pras tabelas

- Usar dados do GitHub do Camalearning
- Dentro do computador onde o PostgreSQL estiver instalado, execute os seguintes comandos

```bash
# Criando diretório para os dados
mkdir /tmp/csv 
cd /tmp/csv

# Baixando os dados
wget https://raw.githubusercontent.com/jj-marinho/camalearning-databases/master/dados/resultados.csv

wget https://raw.githubusercontent.com/jj-marinho/camalearning-databases/master/dados/modalidades.csv

wget https://raw.githubusercontent.com/jj-marinho/camalearning-databases/master/dados/cursos.csv

# Copiando arquivos pro container docker
docker cp . tutorial:/data/
# Voltando para o diretório base
cd ~

```

## Voltando para o Azure Data Studio

- Executar a seguinte Query para importar os dados

```sql
COPY modalidades 
FROM '/data/modalidades.csv' 
DELIMITER ';' 
CSV HEADER;

COPY cursos 
FROM '/data/cursos.csv' 
DELIMITER ';' 
CSV HEADER;

COPY resultados 
FROM '/data/resultados.csv' 
DELIMITER ';' 
CSV HEADER;
```

# Agora nossa API esta pronta!

- É só ir na pasta onde está o PostgREST e o postgrest.conf e executar!
- `./postgrest postgrest.conf`
- A partir daqui, as queries que a gente fez estão disponíveis na pasta `queries` do repositório!