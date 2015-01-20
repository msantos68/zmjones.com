import sys
reload(sys)
sys.setdefaultencoding("utf-8")
from flask import Flask, render_template
from flask_flatpages import FlatPages
from flask_frozen import Freezer
from datetime import date, datetime
import pandas as pd

DEBUG = True
FLATPAGES_AUTO_RELOAD = DEBUG
FLATPAGES_ENCODING = 'utf-8'
FLATPAGES_EXTENSION = '.md'
FLATPAGES_MARKDOWN_EXTENSIONS = ['codehilite', 'footnotes']

app = Flask(__name__, static_folder='static')
app.config.from_object(__name__)
flatpages = FlatPages(app)
freezer = Freezer(app)
app.config['FREEZER_BASE_URL'] = 'http://zmjones.com/'

pages = [p for p in flatpages if p.meta.get('type') == 'page' and
         p.meta.get('status') != 'hidden']
posts = [p for p in flatpages if p.meta.get('type') == 'post' and
         p.meta.get('status') != 'hidden']
posts = sorted(posts, reverse=True, key=lambda p: p.meta.get('date', date.today()))
tags = sorted(list(set([tag for p in posts for tag in p.meta.get('tags')])))

logs = pd.read_csv('./static/analytics/views_by_key.csv')

for i in range(0, len(posts)):
    if len(logs.views[logs.key == posts[i].path]) == 1:
        posts[i].views = int(logs['views'][logs.key == posts[i].path])
    else:
        posts[i].views = int(0)
    
popular = sorted(posts, reverse=True, key=lambda p: p.views)

@app.route('/')
def index():
    return render_template('home.html', home=flatpages.get('home'))


@app.route('/<path:path>/')
def page(path):
    page = flatpages.get_or_404(path)
    return render_template('page.html', page=page)

@app.route('/posts/')
def archive():
    return render_template('posts.html', tags=tags, posts=posts,
                           popular = popular, archive=flatpages.get('archive'))


@app.route('/feed.atom')
def feed():
    xml = render_template('atom.xml', posts=posts, updated=datetime.now())
    return app.response_class(xml, mimetype='application/atom+xml')


@app.route('/404/')
def error():
    return render_template('404.html')


# @freezer.register_generator
# def page_generator():
#     yield '//'

if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1] == "build":
        freezer.freeze()
    else:
        app.run(port=8000)
