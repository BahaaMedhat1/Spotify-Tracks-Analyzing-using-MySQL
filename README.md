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



## Exploratory Data Analysis (EDA) Queries
Here are some key EDA queries performed on the data:

### 1. Creating Database and Tables 
```sql
CREATE DATABASE Spotify_Schema;
use Spotify_Schema;


-- Creating the structure of our table.
DROP TABlE if EXISTS Spotify;
CREATE TABlE Spotify(
	Artist Varchar(255),
    Track Varchar(255),
    Album Varchar(255),
    Album_type Varchar(255),
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
	Title Varchar(255),	
    Channel Varchar(255),	
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

## Most Advanced Queries in This project 
### 1.  Retrieve the track names that have been streamed on Spotify more than YouTube
```sql
with stream_spotify as(
select
	track,
    coalesce(sum(case when most_playedON = "Spotify" then stream end ), 0) as stream_spotify,
    ifnull(sum(case when most_playedON = "Youtube" then stream end ), 0) as stream_Youtube
from 
	spotify
group by
	track)
select
	track,
    format(stream_spotify, 0) as spotify,
    format(stream_youtube, 0) as youtube
from
	stream_spotify
where
	stream_spotify> stream_Youtube
    and stream_Youtube != 0
order by 
	stream_spotify desc;
```
