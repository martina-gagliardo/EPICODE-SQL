-- Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce.

use chinook 

select g.name,
count(tr.trackid)
from track as tr
inner join genre as g
on g.genreid = tr.genreid 
group by g.name
having count(tr.trackid) >=10
order by count(tr.trackid) desc


-- Trovate le tre canzoni più costose.

select *
from track as tr
order by tr.unitprice desc
limit 3 


-- Elencate gli artisti che hanno canzoni più lunghe di 6 minuti.

select *
from track as tr
inner join album as al
on tr.albumid = al.albumid
where tr.milliseconds > 6*60*1000
and tr.name in (select tr.name
				from album as al
                inner join artist as ar
                on al.artistid = ar.artistid)
                


-- Individuate la durata media delle tracce per ogni genere

select  g.name, 
avg(t.milliseconds) as mediatracce
from genre as g
inner join track as t
on t.genreid = g.genreid 
group by g.name

-- Elencate tutte le canzoni con la parola “Love” nel titolo, ordinandole alfabeticamente prima per genere e poi per nome

select t.name, g.name
from track as t
inner join genre as g
on t.genreid = g.genreid 
where t.name like '%love'
order by g.name, t.name ASC


-- Trovate il costo medio per ogni tipologia di media 

select m.name,
avg(t.unitprice) as averagecost
from mediatype as m 
inner join track as t 
on m.mediatypeid = t.mediatypeid 
group by m.name

-- Individuate il genere con più tracce

select g.name,
count(tr.trackid)
from track as tr
inner join genre as g
on g.genreid = tr.genreid 
group by g.name
having count(tr.trackid) 
order by count(tr.trackid) desc
limit 1

-- Trovate gli artisti che hanno lo stesso numero di album dei Rolling Stones.

select ar.name,
count(al.albumid)
from album as al 
inner join artist as ar
on al.artistid = ar.artistid
group by ar.name
having count(al.albumid) = 3
order by count(al.albumid) desc



 -- Trovate l’artista con l’album più costoso
 
 select ar.name, al.title,
 max(tr.unitprice)
 from artist as ar
 inner join album as al
 on ar.artistid = al.artistid
 inner join track as tr
 on al.albumid = tr.albumid 
 group by ar.name, al.title
order by max(tr.unitprice) DESC
limit 1 

 
 
 
 
 

























