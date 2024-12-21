-- Creating & using the Database 
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



-- to Set Loading data enable.
SET GLOBAL local_infile=ON;



-- Loading data set into spotify table
LOAD DATA LOCAL INFILE "D:/Projects/MySQL/7- Spotify/Spotify_dataset.csv"
INTO TABLE Spotify
Fields TERMINATED BY ","
Enclosed by '"'
LINES TERMINATED BY "\r\n"
IGNORE 1 ROWS;



update spotify
set most_playedon = trim(both "\r\n" from most_playedon)
-- modifing Values for both Licensed & official_video
-- update spotify
-- set 
-- 	Licensed = True,
--     official_video = True
-- where 
-- 	Licensed = "TRUE" 
--     or official_video = "TRUE";


-- update spotify
-- set 
-- 	Licensed = False,
--     official_video = False
-- where 
-- 	Licensed = "FALSE" 
--     or official_video = "FALSE" ;


-- Modifing the data type for both columns
-- ALTER TABLE Spotify
-- MODIFY Column Licensed Bool,
-- MODIFY Column official_video Bool