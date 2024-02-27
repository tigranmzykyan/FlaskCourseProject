SELECT S.ShipID as 'Уникальный номер корабля',
        S.ShipName 'Название корабля',
        PE.ArrivalDate as 'Дата прибытия',
        PE.DepartureDate as 'Дата отбытия',
        D.DockID as 'Уникальный номер причала'
FROM Ships AS S
JOIN Registration AS PE ON S.ShipID = PE.ShipID
JOIN Docks AS D ON PE.DockID = D.DockID
WHERE PE.ArrivalDate >='$ArrivalDate' and PE.ArrivalDate <= '$ArrivalDate1';
