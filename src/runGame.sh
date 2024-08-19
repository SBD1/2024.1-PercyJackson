sudo docker compose down
sudo docker volume rm src_db_data
sudo docker compose up --build  # Executa em modo detached (em segundo plano)

# Aguarda alguns segundos para garantir que o banco de dados esteja pronto
sleep 10

# Executa um terminal interativo no container do serviço `api`
sudo docker exec -it $(sudo docker ps -qf "name=api") /bin/bash -c "python3 main.py"
