select
    EmployeeID as 'Уникальный номер сотрудника',
    LastName as 'Фамилия',
    Profession as 'Профессия',
    DateOfBirth as 'Дата рождения',
    Address as 'Адрес',
    HireDate as 'Дата зачисления на работу'
from Employees
where LastName = "$LastName"