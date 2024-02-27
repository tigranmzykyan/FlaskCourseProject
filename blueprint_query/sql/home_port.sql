SELECT
    ShipID as 'Уникальный номер корабля',
    ShipName as 'Название корабля',
    ShipType as 'Тип корабля',
    ShipTonnage as 'Тоннаж корабля' ,
    HomePort as 'Порт прописки'
FROM SHIPS
WHERE HomePort='$HomePort';