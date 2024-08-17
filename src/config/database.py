from sqlalchemy import create_engine, text

class Database:
    def __init__(self, connection_string):
        self.connection_string = connection_string
        self.engine = None
        self.conn = None

    def connect(self):
        try:
            print("Connecting to the database...")
            self.engine = create_engine(self.connection_string)
            self.conn = self.engine.connect()
            print("Connected to the database.")
        except Exception as e:
            print(f"An error occurred while connecting to the database: {e}")
            raise

    def execute_query(self, query):
        try:
            print("Executing the query...")
            self.conn.execute(query)
            self.conn.commit()
            print("Data inserted successfully.")
        except Exception as e:
            print(f"An error occurred while executing the query: {e}")
            raise

    def close_connection(self):
        if self.conn:
            try:
                self.conn.close()
                print("Connection closed.")
            except Exception as e:
                print(f"An error occurred while closing the connection: {e}")
                raise
