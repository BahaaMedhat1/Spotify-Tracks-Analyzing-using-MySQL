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

### 1. Previewing Data
```sql
SELECT * FROM Spotify
LIMIT 10;
```
