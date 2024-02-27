select
    WorkDate as 'Дата работы',
    WorkHours as 'Часы работы',
    DockType as 'Тип причала',
    ShipName as 'Название корабля'
from UnloadingReport
where Year(WorkDate)="$year_" and Month(WorkDate)="$month_"

-- Отчет о разгрузке кораблей в порту по дате --