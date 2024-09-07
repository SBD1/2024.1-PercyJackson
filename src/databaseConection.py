import psycopg2

# Configuração da conexão
connection_string = "dbname='percyJacksonMUD' user='postgres' host='db' password='postgres'"

def connect_to_db():
    print("Connecting to the database...")
    conn = psycopg2.connect(connection_string)
    cursor = conn.cursor()
    print("Connected to the database.")
    return conn, cursor

def close_connection(conn, cursor):
    if cursor:
        cursor.close()
    if conn:
        conn.close()
    print("Connection closed.")
