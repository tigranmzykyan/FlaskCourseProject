select
    EmployeeID as 'Номер сотрудника',
    EmployeeName as 'Имя сотрудника',
    TotalHours as 'Общее количество отработанных часов',
    WorkDate as 'Дата работы'
from EmployeeHoursReport
where Year(WorkDate)='$year_' and Month(WorkDate)='$month_';