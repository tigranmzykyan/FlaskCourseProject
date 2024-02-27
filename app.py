from flask import Flask,render_template,session
import json
from blueprint_query.query import blueprint_query
from blueprint_auth.auth import blueprint_auth
from blueprint_report.report import blueprint_report
from blueprint_unload.unload import blueprint_unload





app = Flask(__name__, template_folder='templates')
app.secret_key = 'A vot i moi secretniy cluch'

app.register_blueprint(blueprint_query, url_prefix='/query')
app.register_blueprint(blueprint_auth, url_prefix='/auth')
app.register_blueprint(blueprint_report, url_prefix='/report')
app.register_blueprint(blueprint_unload, url_prefix='/unload')



with open('jsonFile/db_config.json') as f:
    app.config['db_config'] = json.load(f)

with open('jsonFile/access.json') as f:
    app.config['access_config'] = json.load(f)

with open('jsonFile/reports.json') as f:
    app.config['report_config'] = json.load(f)



@app.route('/')
def main_menu_auth():
    return render_template("main_menu_auth.html")


@app.route('/main')
def main_menu():
    return render_template("main_menu.html")



if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5001, debug=True)
