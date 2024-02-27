from flask import Blueprint, render_template, request, current_app
import os
from DB.work_with_db import select_dict
from DB.sql_provider import SQLProvider
from access import group_required, login_required


blueprint_query = Blueprint('bp_query', __name__, template_folder='templates', static_folder='static')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))
tittle = 'Полученный результат'



@blueprint_query.route('/menu_query', methods=['GET', 'POST'])
@group_required
@login_required
def query_menu():
    if request.method == 'GET':
        return render_template('menu_query.html')


# Пример для query_emp
@blueprint_query.route('/emp_surname', methods=['GET', 'POST'])
@group_required
@login_required
def query_emp():
    input_params = [
        {'input_type': 'text', 'input_name': 'LastName', 'label_text': 'Введите фамилию', 'value': ''},
    ]
    if request.method == 'GET':
        return render_template('input_param.html', input_params=input_params)
    else:
        LastName = request.form.get('LastName')
        _sql = provider.get('emp_name.sql', LastName=LastName)
        all_Emp = select_dict(current_app.config['db_config'], _sql)
        if all_Emp:
            return render_template('dynamic1.html', result=all_Emp, key_list=all_Emp[0].keys())
        else:
            return render_template('input_param.html', input_params=input_params, error="Результаты не найдены")




#Все сведеия о регистрации кораблей, заходивших в определнное число
@blueprint_query.route('/reg_ships', methods=['GET', 'POST'])
@group_required
@login_required
def query_reg_ships():
    input_params = [
        {'input_type': 'date', 'input_name': 'ArrivalDate', 'label_text': 'Введите дату', 'value': ''}
    ]
    if request.method == 'GET':
        return render_template('input_param.html', input_params=input_params)
    else:
        ArrivalDate = request.form.get('ArrivalDate')
        #print(ArrivalDate)
        _sql = provider.get('RegShips.sql',ArrivalDate=ArrivalDate)
        all_PE = select_dict(current_app.config['db_config'], _sql)
        if all_PE:
            return render_template('dynamic1.html', result=all_PE, key_list=all_PE[0].keys())
        else:
            return render_template('input_param.html', input_params=input_params, error="Результаты не найдены")

#Сведения о корабле по домашнему порту
@blueprint_query.route('/homeport', methods=['GET', 'POST'])
@group_required
@login_required
def home_port():
    input_params = [
        {'input_type': 'text', 'input_name': 'HomePort', 'label_text': 'Введите порт прописки', 'value': ''}
    ]
    if request.method == 'GET':
        return render_template('input_param.html', input_params=input_params)
    else:
        HomePort = request.form.get('HomePort')
        print(HomePort)
        _sql = provider.get('home_port.sql', HomePort=HomePort)
        all_Ship = select_dict(current_app.config['db_config'], _sql)
        if all_Ship:
            return render_template('dynamic1.html', result=all_Ship, key_list=all_Ship[0].keys())
        else:
            return render_template('input_param.html', input_params=input_params, error="Результаты не найдены")


#Сведения о причале по типу причала
@blueprint_query.route('/dock', methods=['GET', 'POST'])
@group_required
@login_required
def query_dock():
    input_params = [
        {'input_type': 'text', 'input_name': 'DockType', 'label_text': 'Введите тип причала', 'value': ''}
    ]
    if request.method == 'GET':
        return render_template('input_param.html', input_params=input_params)
    else:
        DockType = request.form.get('DockType')
        print(DockType)
        _sql = provider.get('docktype.sql',DockType=DockType)
        all_Dock = select_dict(current_app.config['db_config'],_sql)
        if all_Dock:
            return render_template('dynamic1.html', result=all_Dock, key_list=all_Dock[0].keys())
        else:
            return render_template('input_param.html', input_params=input_params, error="Результаты не найдены")



#Отчет о регистрациях кораблей в ArrivalDate: Шифр кор, название кор, дата прих, дата ухода, нахвание причала
@blueprint_query.route('/report', methods=['GET', 'POST'])
@group_required
@login_required
def query_report():
    input_params = [
        {'input_type': 'date', 'input_name': 'ArrivalDate', 'label_text': 'Дата прихода'},
        {'input_type': 'date', 'input_name': 'ArrivalDate1', 'label_text': 'Дата ухода'}
    ]
    if request.method == 'GET':
        return render_template('input_param.html', input_params=input_params)
    else:
        ArrivalDate = request.form.get('ArrivalDate')
        ArrivalDate1 = request.form.get('ArrivalDate1')
        print(ArrivalDate)
        print(ArrivalDate1)
        _sql = provider.get('report.sql', ArrivalDate=ArrivalDate, ArrivalDate1=ArrivalDate1)
        all = select_dict(current_app.config['db_config'], _sql)
        if all:
            return render_template('dynamic1.html', result=all, key_list=all[0].keys())
        else:

            return render_template('input_param.html', input_params=input_params, error="Результаты не найдены")




@blueprint_query.route('/unloadtable', methods=['GET', 'POST'])
@group_required
@login_required
def unloadtable():
    input_params = [
        {'input_type': 'date', 'input_name': 'DateUnload', 'label_text': 'Введите дату', 'value': ''}
    ]
    if request.method == 'GET':
        return render_template('input_param.html', input_params=input_params)
    else:
        DateUnload = request.form.get('DateUnload')
    if not DateUnload:
        return render_template('input_param.html', input_params=input_params)
    _sql = provider.get('date_unload.sql', DateUnload=DateUnload)
    all_Unload = select_dict(current_app.config['db_config'], _sql)
    if all_Unload:
        return render_template('dynamic1.html', result=all_Unload, key_list=all_Unload[0].keys())
    else:
        return render_template('input_param.html', input_params=input_params, error="Результаты не найдены")