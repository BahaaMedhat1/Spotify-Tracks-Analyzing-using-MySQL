# EDA 
use spotify_schema;
Select * from spotify
limit 10;


-- Checking the Duration Min column
select
	Max(duration_min),
    min(duration_min)
from
	spotify;
    

select * from spotify
where duration_min = 0;

-- Deleting rows that contains 0 mins
Delete from spotify
where duration_min = 0;


select * from spotify
where duration_min = 0;



-- 1. Retrieve the names of all tracks that have more than 1 billion streams.
select 
	track , 
    format(stream, 0) as stream,
    concat(round(stream/1000000000, 2), " B") as stream
from
	spotify
where
	stream >= 1000000000
order by 2 desc;


-- 2. List all albums along with their respective artists.
select 
	artist,
    album
from
	spotify
order by 1 asc;


-- Get the total number of comments for tracks where licensed = TRUE.
select
	licensed,
    format(sum(comments), 0) as num_comments
from
	spotify
where
	Licensed = "True"
group by 
	 licensed
order by 
	1 desc;
    
    
-- 4. Find all tracks that belong to the album type single.

select 
	track,
    album_type
from
	spotify
where
	album_type = "single";



-- 5. Count the total number of tracks by each artist.
select 
	artist,
    count(album) as num_album
from
	spotify
group by 
	artist
order by 2 desc;



-- 6. Calculate the average danceability of tracks in each album.

select 
	Album,
    round(avg(danceability),2)
from
	spotify
group by 
	album
order by 2 desc;


-- 7. Find the top 5 tracks with the highest energy values.

select
	track,
    round(sum(energy), 2) as energy
from
	spotify 
group by	
	track
order by 2 desc
limit 5;


-- 8. List all tracks along with their views and likes where official_video = TRUE.
select
	track,
    format(views, 0 ) as total_views,
    format(likes, 0 ) as total_likes
from
	spotify
where
	official_video = "TRUe"
order by views desc , likes desc;


-- 9. For each album, calculate the total views of all associated tracks.

select
	album,
    format(sum(views),0) as total_views
from
	spotify 
group by 
	album
order by sum(views) desc;



-- 10. Retrieve the track names that have been streamed on Spotify more than YouTube.
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
    
    

    
-- 11. Find the top 3 most-viewed tracks for each artist using window functions.
select * 
from(
select
	artist,
	track,
    format(views,0 ) as total_views,
    row_number() over (PARTITION BY artist order by views  desc) as row_num
from
	spotify
order by 1 asc, views desc) as View_rank
where
	row_num <= 3;
	


-- 12. Write a query to find tracks where the liveness score is above the average.

select
	Artist,
    track,
    album,
    liveness
from
	spotify
where
	liveness > (select avg(liveness) from spotify)
order by 4 desc;



-- 13. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
with energy_album as(
Select distinct
	album, track, energy,
    max(energy) over (PARTITION BY album) as max_energy,
    min(energy) over (PARTITION BY album) as min_energy
from
	spotify
order by 
	1 desc, 2 desc)
select
	*, round(max_energy - min_energy ,2) as diff_energy
from
	energy_album















































