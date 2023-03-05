DROP TABLE IF EXISTS delay_flights;

CREATE EXTERNAL TABLE delay_flights (Index int, Year int,Month int,DayofMonth int,DayOfWeek int,DepTime int,CRSDepTime int,	ArrTime int,CRSArrTime int,	UniqueCarrier string,FlightNum int,TailNum string, ActualElapsedTime int, CRSElapsedTime int, AirTime int, ArrDelay int,DepDelay int, Origin string,	 Dest string,  Distance int, TaxiIn int, TaxiOut int, Cancelled int, CancellationCode string, Diverted int, CarrierDelay int, WeatherDelay int, NASDelay int, SecurityDelay int, LateAircraftDelay int) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' STORED AS TEXTFILE LOCATION "${INPUT}";


INSERT OVERWRITE DIRECTORY "${OUTPUT}"
 
SELECT Year, avg((CarrierDelay /ArrDelay)*100) as AvgCarrierDelay from delay_flights GROUP BY Year ORDER BY Year;

SELECT Year, avg((NASDelay /ArrDelay)*100) as AvgNASrDelay from delay_flights GROUP BY Year ORDER BY Year;

SELECT Year, avg((WeatherDelay /ArrDelay)*100) as AvgWeatherDelay from delay_flights GROUP BY Year ORDER BY Year;

SELECT Year, avg((LateAircraftDelay /ArrDelay)*100) as AvgLateAircraftDelay from delay_flights GROUP BY Year ORDER BY Year;

SELECT Year, avg((SecurityDelay /ArrDelay)*100) as AvgSecurityDelay from delay_flights GROUP BY Year ORDER BY Year;