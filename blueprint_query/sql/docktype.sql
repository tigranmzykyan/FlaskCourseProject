SELECT
    DockID as 'Уникальный номер причала',
    DockType as 'Тип причала',
    DockLength as 'Длина причала',
    DockDepth as 'Глубина причала'
FROM Docks
WHERE DockType='$DockType';