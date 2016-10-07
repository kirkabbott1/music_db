-- Questions
-- What are tracks for a given album? v1
select
	track.id,
	album.name as "Album Name",
	song.name as "Song Name",
	track.duration as "Song Duration"
from
	track
inner join
	album
	on track.album_id = album.id
inner join
	song
	on track.song_id = song.id
where
	album.name = 'Help'
;
-- v2
select
	album.name as "Album Name",
	song.name as "Song Name",
	track.duration as "Song Duration"
from
	track,
	song,
	album
where
	track.album_id = album.id
	and track.song_id = song.id
	and album.name = 'Help'
;

-- What instruments does each artist play?
-- V1
select
  artist.name as "Artist Name",
  instrument.name as "Instrument Name"
from
	play
inner join
	instrument
	on play.instrument_id = instrument.id
inner join
	artist
	on play.artist_id = artist.id;

-- V2
select
	artist.name as "Artist Name",
	instrument.name as "Instrument Name"
from
	play, instrument, artist
where play.instrument_id = instrument.id
	and play.artist_id = artist.id;

-- What is the track with the longest duration?
select song.name as "song name", track.duration
	from track, song
where track.song_id = song.id order by track.duration DESC LIMIT 1;
--v2
select song.name as "song name", track.duration
	from track
Inner join
	song
on track.song_id = song.id order by track.duration DESC LIMIT 1;

--What are the albums released in the 60's 70's etc?
select
	album.name, released
from
	album
where
	released between '1960-01-01' and '1969-12-31' or
	released between '1970-01-01' and '1979-12-31' or
	released between '1980-01-01' and '1989-12-31'
group by
	album.name, released
;

--How many albums did a given artist produce in the 60s?
-- V1
select
	artist.name as "Artist Name",
	count(album.id) as "Number of Albums"
from
	album,
	artist
where
	album.lead_artist_id = artist.id
	and artist.name = 'The Beatles'
	and released between '1960-01-01' and '1969-12-31'
group by
	artist.name;

-- V2
select
	artist.name as "Artist Name",
	count(album.id) as "Number of Albums"
from
	album
inner join
	artist
	on album.lead_artist_id = artist.id
where
	artist.name = 'The Beatles'
	and released between '1960-01-01' and '1969-12-31'
group by
	artist.name;

-- What is the total run time of each album (based on the duration of its tracks)?
