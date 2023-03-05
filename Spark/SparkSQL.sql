import sys
from datetime import datetime
from pyspark.sql import SparkSession
from pyspark.sql.functions import *



df = spark.read.option("inferSchema", "true").option("header", "true").csv('s3://cs5229assignment/dataset/DelayedFlights-updated.csv')

df.show()

df.printSchema()

# Create View
df.createOrReplaceTempView('delay_flights')
spark.sql("select * from delay_flights").show(5)

---------------------------------------------------------------------

import time
start_time = time.time()
spark.sql("SELECT Year, avg((CarrierDelay /ArrDelay)*100) as AvgCarrierDelay from delay_flights GROUP BY Year ORDER BY Year").show()
print(f"Execution time: {time.time() - start_time}")


start_time = time.time()
spark.sql("SELECT Year, avg((NASDelay /ArrDelay)*100) as AvgNASrDelay from delay_flights GROUP BY Year ORDER BY Year").show()
print(f"Execution time: {time.time() - start_time}")


start_time = time.time()
spark.sql("SELECT Year, avg((WeatherDelay /ArrDelay)*100) as AvgWeatherDelay from delay_flights GROUP BY Year ORDER BY Year").show()
print(f"Execution time: {time.time() - start_time}")


start_time = time.time()
spark.sql("SELECT Year, avg((LateAircraftDelay /ArrDelay)*100) as AvgLateAircraftDelay from delay_flights GROUP BY Year ORDER BY Year").show()
print(f"Execution time: {time.time() - start_time}")


start_time = time.time()
spark.sql("SELECT Year, avg((SecurityDelay /ArrDelay)*100) as AvgSecurityDelay from delay_flights GROUP BY Year ORDER BY Year").show()
print(f"Execution time: {time.time() - start_time}")