import os
from flask import Blueprint, render_template, request, current_app, session
from DB.work_with_db import select_dict
from DB.sql_provider import SQLProvider



blueprint_auth = Blueprint('bp_auth', __name__, template_folder='templates', static_folder='static')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))


@blueprint_auth.route('/', methods=["GET", "POST"])
def authorization():
    if request.method == 'GET':
        return render_template('authorization.html')
    else:
        login = request.form.get('login')
        password = request.form.get('password')
        _sql = provider.get('login_in.sql', login=login, password=password)
        enter = select_dict(current_app.config['db_config'], _sql)
        if enter:
            session['user_id'] = enter[0]['user_id']
            session['user_group'] = enter[0]['group_name']
            return render_template("main_menu.html")
        else:
            _sql = provider.get('login_g.sql', login=login, password=password)
            enter = select_dict(current_app.config['db_config'], _sql)
            if enter:
                session['user_id'] = enter[0]['user_id']
                session['user_group'] = "noname"
                return render_template("main_menu.html")
            else:
                return render_template('authorization.html', error="Неверный логин или пароль!")


@blueprint_auth.route('/', methods=['GET', 'POST'])
def sign_out():
    session.clear()
    return render_template('main_menu_auth.html.html')