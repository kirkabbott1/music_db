-- what are the tracks for an album

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
	artist.name = 'Radiohead';

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
			artist.name = 'Radiohead')
;
