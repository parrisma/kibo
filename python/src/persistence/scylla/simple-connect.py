from cassandra.cluster import Cluster


# Connect to the ScyllaDB cluster
# Replace with your ScyllaDB cluster IP address
#cluster = Cluster(['127.0.0.1:5000'])
cluster = Cluster()
session = cluster.connect()

# Create a keyspace
session.execute(
    "CREATE KEYSPACE IF NOT EXISTS my_keyspace WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'}")

# Use the keyspace
session.set_keyspace('my_keyspace')

# Create a table
session.execute(
    "CREATE TABLE IF NOT EXISTS my_table (id UUID PRIMARY KEY, message TEXT)")

# Insert a row
session.execute(
    "INSERT INTO my_table (id, message) VALUES (uuid(), 'Hello, World!')")

# Retrieve the row
result = session.execute(
    "SELECT * FROM my_table WHERE id = ?", [result.one().id])
for row in result:
    print(row.message)

# Close the connection
session.shutdown()
cluster.shutdown()
