# Flask Cookies

Welcome to Flask-Cookies

This is a little package that we developed to rapidly implement cookie banners within our [Flask](https://flask.palletsprojects.com/en/3.0.x/) based web applications in just 3 lines of code.

This banner deal with cookies following [Google Tag Consent](https://support.google.com/tagmanager/?hl=en#topic=13562736) types, which are thoroughly explained [here](https://support.google.com/tagmanager/?hl=en#topic=) and in several other guides.

Basically, if you want to, you can easily connect your [Google Tag Manager](https://tagmanager.google.com/) account to the banner, and directly work on consent and actions from your GTM console, with all the advantages and functionalities it offers. You can create personalized events that users will trigger or not based on the consent they expressed etc. and easily visualize all these activities on your [Google Analytics](https://analytics.google.com/) account.

`Flask-Cookies` is *extremely easy* to install and immediately takes up the banner for you in your Flask application.

Here is an ***example*** of how then banner looks: ![screenshot of flask cookie banner](flask-cookies-banner.png)

You can also have a look at a ***live example*** of the `Flask-Cookies` banner [here](https://flask-cookies-rpreview.tiiny.site)

*Please note*: as we collapsed the whole thing in a single HTML document for this [live example](https://flask-cookies-rpreview.tiiny.site/), *in some browser it might have some rendering problem*. It should work on Firefox, Safari, Chrome, etc.

You have different options to install `Flask-Cookies`:
1. [Python installation](#1-python-installation) (the easiest way)
2. [Flask-Cookies installer](#2-flask-cookies-installer)
3. [Manual installation](#3-manual-installation)

## 1. Python installation
Installation of [Flask-Cookies](https://pypi.org/project/flask-cookies/0.0.1/
) can be easily done with [pip](https://pypi.org/project/pip/):
```
pip install flask-cookies
```
Simply add these lines into your app `__init__.py` file:
```
from flask_cookies import Cookies

cookies = Cookies(<put-your-GTM-ID-here>)

app = Flask(__name__)

cookies.init_app(app)
```
And that's all!

Now you can simply import the `Flask-Cookies` template from your base application template (the one that you extend in the rest of application templates, have a look [here](https://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-ii-templates) if you don't know what I'm talking about: it will change your life):
```
{% extends 'cookies/cookies.html' %}
```

And you are completely set!
Next time you run your application you have your nice cookie banner on it and directly connected with your Google Tag Manager account, from which you can easily manage and implement consent thorough your website without needing additional code modifications (have a look [here](https://support.google.com/tagmanager/answer/10718549?hl=en) to have an idea of how powerful GTM is)

Please note: if you *don't* specify your GTM ID at `Cookies()` initialization you will see an error in your prompt:
> You must pass your Google Tag Manager ID to Cookies() initialization or it will NOT be connected with your GTM account: "cookies = Cookies(<put-here-your-GTM-ID>)"

---
Here how many times `Flask-Cookies` python package has been downoaded: [![Downloads](https://static.pepy.tech/badge/flask-cookies)](https://pepy.tech/project/flask-cookies)

## 2. Flask-Cookies Installer
Clone `Flask-Cookies` into your local machine:
```
git clone https://github.com/cccnrc/flask-cookies
```
You have a `installer.sh` file ([here](installer.sh)) which you can easily run in a `bash` shell with:
```
bash installer.sh \
    --app-dir <flask-app-dir>
    --gtm-id <your-GTM-ID>
```
You need to specify to the installer these two options above:
1. `--app-dir`: the full path to your flask application directly
2. `--gtm-id`: your Google Tag Manager ID

***important***: the installer assumes that your application structure is:
```
app
└── __init__.py
└── static/
└── templates/
```
as it will copy `Flask-Cookies` files in these two folders. Be sure it matches.
In case your application structure is different it will simply abort the installation.

The installer will put your GTM ID into needed fields, so you simply need to import the `Flask-Cookies` template from your base application template (the one that you extend in the rest of your application templates):
```
{% extends 'cookies.html' %}
```
and you will have your cookie banner connected with your GTM account all set up

## 3. Manual Installation
You can manually install the files in needed positions. You simply need to:
- copy `cookies.html` into your app `templates/` folder
- copy `cookies.css` and `cookies-logo.png` into your app `static/` folder

You will also need to replace `YOUR_GTM_ID` into `cookies.html` with your actual GTM ID in order to connect to it.
Then you simply import this template from your base app template:
```
{% extends 'cookies.html' %}
```
And everything is set up and working!

### Additional Informations

- `Flask-Cookies` depends on [Bootstrap v5](https://getbootstrap.com/docs/5.0/getting-started/introduction/) which will be imported in your website (precisely in [this page](cookies.html), lines 44). Thus if your flask application rely on a different Bootsrap version (or fore some strange reason you do not want to import it), you have to manually change these imports and `Flask-Cookies` objects relying on it.
- you can easily modify everything in `Flask-Cookies` banner, simply change required fields in [cookies.html](cookies.html) and [cookies.css](cookies.css). If you installed `Flask-Cookies` as a Python library you will find these files in `$PYTHONPATH/lib/python3/site-packages/flask_cookies/templates/cookies/` and `$PYTHONPATH/lib/python3/site-packages/flask_cookies/static/` (have a look [here](https://stackoverflow.com/questions/16269903/how-to-get-the-pythonpath-in-shell) for info on `$PYTHONPATH`)

### Closing Notes

Feel free to use `Flask-Cookies` and all your applications and to modify its files as you need (but share with us improvements so we can share them with the world).
