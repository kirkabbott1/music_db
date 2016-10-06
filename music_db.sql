-- -- Creates database
-- CREATE DATABASE music_db;
--
-- -- Connects to just created database
-- \connect music_db;

CREATE TABLE artist (
  id serial PRIMARY KEY,
  name varchar NOT NULL
);

CREATE TABLE album (
  id serial PRIMARY KEY,
  name varchar NOT NULL,
  released date NOT NULL,
  lead_artist_id integer REFERENCES artist (id)
);

CREATE TABLE participation (
  id serial PRIMARY KEY,
  artist_id integer REFERENCES artist (id),
  album_id integer REFERENCES album (id)
);

CREATE TABLE instrument (
  id serial PRIMARY KEY,
  name varchar NOT NULL UNIQUE
);

CREATE TABLE song (
  id serial PRIMARY KEY,
  name varchar
);

CREATE TABLE song_writer (
  id serial PRIMARY KEY,
  name varchar NOT NULL
);

-- joins artist and instrument tables
CREATE TABLE play (
  id serial PRIMARY KEY,
  instrument_id integer REFERENCES instrument (id),
  artist_id integer REFERENCES artist (id)
);

-- joins album, song and artist tables
CREATE TABLE track (
  id serial PRIMARY KEY,
  duration time NOT NULL,
  album_id integer REFERENCES album (id),
  song_id integer REFERENCES song (id)
);

-- joins song and song_writer tables
CREATE TABLE written (
  id serial PRIMARY KEY,
  song_id integer REFERENCES song (id),
  song_writer_id integer REFERENCES song_writer (id)
);
