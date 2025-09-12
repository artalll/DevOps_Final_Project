"""This is the main module of QuakeWatch Flask app."""

from flask import Flask
app = Flask(__name__)
@app.route('/')
def hello():
    return 'Hello, World!'
 """Return a simple hello message."""   
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
