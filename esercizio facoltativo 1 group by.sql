use chinook

-- Cominciate facendo un’analisi esplorativa del database, ad esempio: 
-- Fate un elenco di tutte le tabelle. Visualizzate le prime 10 righe della tabella Album.

select * from album;
select * from artist;
select * from playlist;
select * from track;
select * from invoice;

-- Visualizzate le prime 10 righe della tabella Album.
select *
from album 
limit 10

-- Trovate il numero totale di canzoni della tabella Tracks.
select distinct count(*)
from track 

oppure 
select count(*)
from track;

-- Trovate i diversi generi presenti nella tabella Genre

select distinct g.name
from genre as g 
 
 oppure
 select distinct g.name, count(genreid)
from genre as g 
group by g.name 
having count(genreid) >=1

-- Recuperate il nome di tutte le tracce e del genere associato.

select t.name as nome_traccia, g.name as nome_genre
from genre as g
inner join track as t
on g.genreid = t.genreid


-- Recuperate il nome di tutti gli artisti che hanno almeno un album nel database. Esistono artisti senza album nel database?

select title as titolo , name as nome_artista
from artist as ar
inner join album as al
on ar.artistid = al.artistid

-- Esistono artisti senza album nel database?
select * 
from artist as ar
left join album as al 
ON ar.artistid = al.artistid
where al.artistid is null 

-- Recuperate il nome di tutte le tracce, del genere associato e della tipologia di media. 
-- Esiste un modo per recuperare il nome della tipologia di media?

select g.name as genere,
	t.name as traccia,
    mt.name as tipologia_media
from track as t
inner join genre as g
on t.genreid = g.genreid
inner join mediatype as mt
on t.mediatypeid = mt.mediatypeid


-- Elencate i nomi di tutti gli artisti e dei loro album

select ar.name, al.title
from artist as ar
inner join album as al
on al.artistid = ar.artistid










 