from flask import Blueprint, render_template, request, current_app, session, redirect, url_for
from DB.work_with_db import select_dict
from DB.sql_provider import SQLProvider
from DB.DBconn import DBContextManager
from access import group_required, login_required

import os

blueprint_unload = Blueprint('bp_unload', __name__, template_folder='templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))
unload = {}



@blueprint_unload.route('/', methods=['GET', 'POST'])
@group_required
@login_required
def unload_menu():
    if request.method == 'GET':
        return render_template("unload_menu.html")
    else:
        date_ = request.form.get("UnloadDate")
        workHours_ = request.form.get("WorkHours")
        RegID = request.form.get("RegID")

        _sql = provider.get('chk.sql', RegID=RegID)

        RegID_ = select_dict(current_app.config['db_config'], _sql)

        if not RegID_:
            return render_template("unload_menu.html", error="Такой корабля не зарегистрировался")

        session['unload_date'] = date_
        session['unload_hours'] = workHours_
        session['unload_regID'] = RegID

        return redirect(url_for('bp_unload.choose'))
    


@blueprint_unload.route('/chose', methods=['GET', 'POST'])
@group_required
@login_required
def choose():
    global unload
    db_config = current_app.config['db_config']
    if request.method == 'GET':
        sql = provider.get('all_emp.sql')
        items = select_dict(db_config, sql)
        print(items)
        # unload_items = session.get('unload', {})
        return render_template('unload_show.html', item=items, unload=unload, un_keys=unload.keys())
    else:
        EmployeeID = request.form.get('EmployeeID')
        sql = provider.get('add_item.sql', EmployeeID=EmployeeID)
        session["EmployeeID"] = EmployeeID
        item = select_dict(db_config, sql)[0]
        add_to_unload(unload, item)
    return redirect(url_for('bp_unload.choose'))


def add_to_unload(unload, item):
    if item['EmployeeID'] in unload.keys():
        unload[item['EmployeeID']]= 1
    else:
        unload[item['EmployeeID']] = {'EmployeeID': item["EmployeeID"], 'LastName': item['LastName'], 'Profession': item['Profession'], 'amount': 1}



@blueprint_unload.route('/save_unload', methods=['GET', 'POST'])
@group_required
@login_required
def save_unload():
    db_config = current_app.config['db_config']

    # Получаем значения из сеанса
    unload_date = session.get('unload_date')
    unload_hours = session.get('unload_hours')
    unload_regID = session.get('unload_regID')

    with DBContextManager(db_config) as cursor:
        if cursor:
            # Проходим по всем сотрудникам в бригаде
            for employee_id in unload.keys():
                # Используем значения в запросе для каждого сотрудника
                sql = provider.get('insert_unload.sql', unload_hours=unload_hours, unload_date=unload_date,
                                   unload_regID=unload_regID, EmployeeID=employee_id)
                cursor.execute(sql)
                unload_id = cursor.lastrowid
                print(f'unload_id = {unload_id}')

            # Очищаем значения в сеансе
            session.pop('unload_date', None)
            session.pop('unload_hours', None)
            session.pop('unload_regID', None)

        else:
            raise ValueError('Курсор не создан')

    return render_template('done.html')



@blueprint_unload.route('/clear')
@login_required
@group_required
def clear_unload():
    global unload
    unload = {}
    return redirect(url_for('bp_unload.choose'))








# @blueprint_unload.route('/save_unload', methods=['GET', 'POST'])
# @group_required
# @login_required
# def save_unload():
#     db_config = current_app.config['db_config']
#     with DBContextManager(db_config) as cursor:
#         if cursor:
#
#             sql = provider.get('insert_unload.sql', user_id=session['user_id'],
#                                    user_date=datetime.now().strftime("%Y-%m-%d"))
#             cursor.execute(sql)
#             order_id = cursor.lastrowid
#             print(f'order_id = {order_id}')
#             if order_id:
#                 for key in session['basket'].keys():
#                     item = session['basket'][key]
#                     sql = provider.get('insert_order_list.sql', order_id=order_id, prod_id=key,                                           prod_amount=item['amount'],
#                                            cost=item['amount'] * item['prod_price'])
#                     cursor.execute(sql)
#         else:
#             raise ValueError('Курсор не создан')
#     session['basket'] = {}
#     return render_template('done.html')




