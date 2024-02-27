SELECT RegID as 'Уникальный номер регистрации',
       ShipID as 'Уникальный номер корабля',
       ArrivalDate as 'Дата прибытия',
       DepartureDate as 'Дата отбытия'
from Registration
WHERE ArrivalDate='$ArrivalDate'