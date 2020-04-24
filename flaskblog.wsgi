activate_this = '/var/www/html/flask-blog/venv/bin/activate'
with open(activate_this) as file_:
    exec(file_.read(), dict(__file__=activate_this))

import sys
sys.path.insert(0, '/var/www/html/flask-blog/')
from flaskblog import app as application


