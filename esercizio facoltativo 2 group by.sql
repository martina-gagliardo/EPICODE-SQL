
use chinook

-- Recuperate tutte le tracce che abbiano come genere “Pop” o “Rock”.

select tr.name as nome_traccia , g.name as nome_genere
from track as tr
inner join genre as g
on g.genreid = tr.genreid
where g.name in ('pop', 'rock')
order by g.name desc

-- oppure 

select tr.name as nome_traccia , g.name as nome_genere
from track as tr
inner join genre as g
on g.genreid = tr.genreid
where g.name = 'Pop'
or g.name = 'Rock'



-- Elencate tutti gli artisti e/o gli album che inizino con la lettera “A”.

select al.title as titolo, ar.name as nome 
from album as al
inner join artist as ar
on al.artistid = ar.artistid 
where (ar.name like 'A%'
and al.title like 'A%')

-- Elencate tutte le tracce che hanno come genere “Jazz” o che durano meno di 3 minuti.
select tr.name , 
		tr.milliseconds,
        g.name
from genre as g
inner join track as tr
on g.genreid = tr.genreid
where g.name = 'jazz' 
and  tr.milliseconds <= 3*60*1000;

-- Recuperate tutte le tracce più lunghe della durata media.
select tr.name,
avg(milliseconds)
from track as tr
group by tr.name
having avg(milliseconds) >=
							(select avg(tr.Milliseconds)
							from track as tr)


-- Individuate i generi che hanno tracce con una durata media maggiore di 4 minuti.

select tr.name,
avg(milliseconds)
from track as tr
group by tr.name
having avg(milliseconds) >= (4*60*1000)


-- Individuate gli artisti che hanno rilasciato più di un album.

SELECT *
from artist AS ar
inner join album AS al ON al.artistid = ar.artistid 
where ar.name IN (
    select ar.name
    from artist AS ar
    inner join album AS al ON al.artistid = ar.artistid
   group by ar.name
    having COUNT(al.title) > 1
    order by ar.name asc
);

-- Trovate la traccia più lunga in ogni album.

select al.title,
max(tr.milliseconds)
from track as tr
inner join album as al
on tr.albumid = al.albumid
group by al.title


-- Individuate la durata media delle tracce per ogni album.


select tr.name, al.title,
avg(milliseconds)
from track as tr
inner join album as al
on tr.albumid = al.albumid
group by tr.name, al.title


-- Individuate gli album che hanno più di 20 tracce e mostrate il nome dell’album e il numero di tracce in esso contenute.

select al.title,
count(tr.trackid)
from album as al
inner join track as tr
on al.albumid = tr.albumid
group by al.title
having count(tr.trackid) >20







