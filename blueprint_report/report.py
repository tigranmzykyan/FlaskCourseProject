from datetime import datetime

from flask import Blueprint, render_template, request, current_app,abort
from DB.work_with_db import select_dict, call_procedure
from DB.sql_provider import SQLProvider
from access import group_required, login_required
import os

blueprint_report = Blueprint('bp_report', __name__, template_folder='templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))

@blueprint_report.route('/work')
@login_required
@group_required
def work_with_reports():
    config = current_app.config['report_config']
    return render_template('report_menu.html', conf=config, key_list=config.keys())


@blueprint_report.route('/create_report/<report_key>', methods=['GET', 'POST'])
@login_required
@group_required
def create_report(report_key):
    if request.method == 'GET':
        return render_template('input_param1.html')
    else:
        date_ = request.form.get('date')

        if not date_:
            return render_template('input_param1.html', error='Недостаточно входных данных')
        else:
            date_1 = datetime.strptime(date_, '%Y-%m')
            year_ = date_1.year
            month_ = date_1.month

            config = current_app.config['report_config']
            if report_key not in config:
                abort(404)  # Обработка случая, если ключ отчета не найден в конфигурации
            proc, sql = config[report_key]
            _sql = provider.get(sql, month_=month_, year_=year_)

            res = select_dict(current_app.config['db_config'], _sql)

            if not res:
                temp = call_procedure(current_app.config['db_config'], proc, year_, month_)
                _sql = provider.get(sql, month_=month_, year_=year_)
                res = select_dict(current_app.config['db_config'], _sql)


                if res:

                    return render_template('dynamic1.html', result=res, key_list=res[0].keys())

                else:
                    return render_template('input_param1.html',
                                           error='Невозможно создать отчёт по указанному периоду. Недостаточно данных')

            else:
                return render_template('report.html', report_key=report_key, date_=date_)


@blueprint_report.route('/report_show/<report_key>', methods=['GET', 'POST'])
@login_required
@group_required
def report_show(report_key):
    date_ = request.form.get('date')
    if date_:
        date_1 = datetime.strptime(date_, '%Y-%m')
        year_ = date_1.year
        month_ = date_1.month
        config = current_app.config['report_config']
        if report_key not in config:
            abort(404)
        sql = config[report_key][1]
        _sql = provider.get(sql, month_=month_, year_=year_)
        res = select_dict(current_app.config['db_config'], _sql)
        if res:
            return render_template('dynamic1.html', result=res, key_list=res[0].keys())
        else:
            return render_template('input_param1.html', error='Отчёт по данному периоду не существует')
    return render_template('input_param1.html')



