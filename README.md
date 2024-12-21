# Spotify Analysis Project

## Project Overview
This project involves analyzing Spotify data using MySQL. The aim is to explore and derive insights about tracks, artists, and albums by creating a structured database schema, performing exploratory data analysis (EDA), and running advanced SQL queries.

## Features
- **Database Creation**: A robust schema for managing Spotify data.
- **Data Loading**: Efficiently importing a large dataset into MySQL.
- **EDA Queries**: Initial data exploration to understand the structure and clean the dataset.
- **Advanced SQL Analysis**: Queries to uncover trends and insights in the Spotify data.

## Files in Repository
1. **Creating & Loading Data.sql**  
   Script for creating the database schema and loading the dataset.
   
2. **Queries.sql**  
   Includes EDA and advanced SQL queries used in the analysis.
3. **Spotify_dataset.csv**: Contains the data about tracks and their artist in form of .csv file



## Creating Tables & Loading Data into tables

### 1. Creating Database and Tables 
```sql
CREATE DATABASE Spotify_Schema;
USE Spotify_Schema;


-- Creating the structure of our table.
DROP TABlE if EXISTS Spotify;
CREATE TABlE Spotify(
    Artist VARHCAR(255),
    Track VARHCAR(255),
    Album VARHCAR(255),
    Album_type VARHCAR(255),
    Danceability DOUBLE, 
    Energy DOUBLE,	
    Loudness DOUBLE,	
    Speechiness DOUBLE,	
    Acousticness DOUBLE,	
    Instrumentalness DOUBLE,	
    Liveness DOUBLE,	
    Valence DOUBLE,	
    Tempo DOUBLE,	
    Duration_min DOUBLE,
    Title VARHCAR(255),	
    Channel VARHCAR(255),	
    Views BIGINT,	
    Likes BIGINT,	
    Comments BIGINT,	
    Licensed TEXT,	
    official_video TEXT,	
    Stream BIGINT,	
    EnergyLiveness DOUBLE,	
    most_playedon VARCHAR(100));
```

### 2. Loading Data from csv file into Tables 
```sql
-- to Set Loading data enable.
SET GLOBAL local_infile=ON;

-- Loading data set into spotify table
LOAD DATA LOCAL INFILE "D:/Projects/MySQL/7- Spotify/Spotify_dataset.csv"
INTO TABLE Spotify
Fields TERMINATED BY ","
Enclosed by '"'
LINES TERMINATED BY "\r\n"
IGNORE 1 ROWS;
```

## Most Advanced Exploratory Data Analysis (EDA) Queries
### 1.  Retrieve the track names that have been streamed on Spotify more than YouTube
```sql
WITH stream_spotify AS (
SELECT
	track,
    COALESCE(SUM(CASE WHEN most_playedON = "Spotify" THEN stream END), 0) AS stream_spotify,
    IFNULL(SUM(CASE WHEN most_playedON = "Youtube" THEN stream END), 0) AS stream_Youtube
FROM 
	spotify
GROUP BY
	track
)
SELECT
	track,
    FORMAT(stream_spotify, 0) AS spotify,
    FORMAT(stream_youtube, 0) AS youtube
FROM
	stream_spotify
WHERE
	stream_spotify > stream_Youtube
    AND stream_Youtube != 0
ORDER BY 
	stream_spotify DESC;
```

### 2. calculate the difference between the highest and lowest energy values for tracks in each album.
```sql
WITH energy_album AS (
SELECT DISTINCT
	album, track, energy,
    MAX(energy) OVER (PARTITION BY album) AS max_energy,
    MIN(energy) OVER (PARTITION BY album) AS min_energy
FROM
	spotify
ORDER BY 
	1 DESC, 2 DESC
)
SELECT
	*, ROUND(max_energy - min_energy, 2) AS diff_energy
FROM
	energy_album;
```

### 3. Find the top 3 most-viewed tracks for each artist using window functions.
```sql
SELECT * 
FROM (
    SELECT
        artist,
        track,
        FORMAT(views, 0) AS total_views,
        ROW_NUMBER() OVER (PARTITION BY artist ORDER BY views DESC) AS row_num
    FROM
        spotify
    ORDER BY 1 ASC, views DESC
) AS View_rank
WHERE
    row_num <= 3;
```
---

## Tools Used

- **Database**: MySQL  
- **Data Files**: CSV files containing sample library data  

---

## Usage Instructions

1. Run `Creating & Loading Data.sql` to create the database and load data.  
2. Execute `EDa Queries.sql` to perform operations and queries.  

---

## Contact

For any queries or suggestions, feel free to reach out:  
**Bahaa Medhat Wanas**  
- LinkedIn: [Bahaa Wanas](https://www.linkedin.com/in/bahaa-wanas-9797b923a)  
- Email: [bahaawanas427@gmail.com](mailto:bahaawanas427@gmail.com)
