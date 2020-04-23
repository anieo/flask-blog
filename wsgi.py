python_home = '/var/www/html/flask-blog/venv'

activate_this = python_home + '/bin/activate_this.py'
execfile(activate_this, dict(__file__=activate_this))
import sys
sys.path.insert(0, '/var/www/html/flask-blog')
from flaskblog import app as application


