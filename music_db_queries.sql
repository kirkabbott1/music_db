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

--What is the total run time of each album (based on the duration of its tracks)?
select album.name, sum(track.duration) as "album run time"
from album, track
where album.id = track.album_id group by album.nameORDER BY "album run time" DESC;
--v2
select album.name, sum(track.duration) as "album run time"
from album
inner join track
on album.id = track.album_id group by album.name ORDER BY "album run time" DESC;


select
	*
from
	album,
	track
where
	track.album_id = album.id and album.name = 'Now'
	;

-- what instruments does artist play?
select
	artist.name as artist,
	instrument.name as instrument
from
	artist,
	artist_plays_instrument,
	instrument
where
	artist.id = artist_plays_instrument.artist_id and
	instrument.id = artist_plays_instrument.instrument_id;

	-- join style

select
	artist.name as artist,
	instrument.name as instrument
from
	artist
inner join artist_plays_instrument
	on artist.id = artist_plays_instrument.artist_id
inner join instrument
	on instrument.id = artist_plays_instrument.instrument_id;


-- the longest track

select name, duration from track order by duration desc limit 1;

-- albums in the 60s
select
	*
from
	album
where
	year between '1960-01-01' and '1969-12-31';

-- How many albums did a given artist produce in the 90s?

select
	count(album.id)
from
	album
inner join artist
	on album.lead_artist_id = artist.id
where
	year between '1990-01-01' and '1999-12-31' and
	artist.name = 'The Beatles';

-- What are the albums recorded by only one solo artist?

select
	*
from
	(select
		album.id, album.name, count(artist.id) as artist_count
	from
		album
	inner join productions
		on productions.album_id = album.id
	inner join artist
		on productions.artist_id = artist.id
	group by album.id) artist_counts
where
	artist_count = 1
;

-- top 5 most prolific artists by album count

select
	count(album.id), artist.name
from
	album
inner join productions
	on productions.album_id = album.id
inner join artist
	on productions.artist_id = artist.id
group by
	artist.id
order by
	count desc
limit 5;

-- what are back street boys' albums
select artist.name as lead_artist, album.name as album_name from artist inner join album on artist.id = album.lead_artist_id where artist.name = 'Backstreet Boys';

-- 17 Who are a given artist's collaborators?

select
	artist.id, artist.name
from
	artist,
	productions,
	album
where
	artist.id = productions.artist_id and
	productions.album_id = album.id and
	album.id in (select
		distinct album.id
		from
			artist,
			productions,
			album
		where
			artist.id = productions.artist_id and
			productions.album_id = album.id and
			artist.name = 'The Beatles')
;
