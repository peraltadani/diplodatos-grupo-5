-- 1) Listado de canciones del artista 'Iron Maiden'
SELECT *
FROM tracks t
INNER JOIN albums a on t.AlbumId = a.AlbumId
WHERE a.ArtistId = (SELECT ArtistId from artists where Name = 'Iron Maiden')

-- 2) Listado de las 20 canciones más populares
select name, Total 
FROM
(SELECT t.TrackId, count(*) as total
from playlist_track pt
inner join tracks t on pt.TrackId = t.TrackId
GROUP by t.TrackId) as TotalPorCancion
inner join tracks on TotalPorCancion.TrackId = tracks.TrackId
order by Total desc
LIMIT 20 OFFSET 1

-- 3) Álbumes con más de 25 canciones
SELECT a.Title
from 
(select AlbumId, count(*) 
from tracks 
GROUP by AlbumId 
HAVING count(*) > 25) as Mas25
inner join albums a on Mas25.AlbumId = a.AlbumId