SELECT RegID as 'Номер зарегистрированного корабля',
EmployeeID as 'Сотрудник',
WorkHours as 'Количество отработанных часов',
DateUnload as 'Дата разгрузки'
FROM Unload
WHERE DateUnload='$DateUnload';