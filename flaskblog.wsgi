activate_this = '/var/www/html/flask-blog/nenv/bin/activate'
with open(activate_this) as file_:
    exec(file_.read(), dict(__file__=activate_this))

import sys
sys.path.insert(0, '/home/ubuntu/flask-blog')
from flaskblog import app as application


