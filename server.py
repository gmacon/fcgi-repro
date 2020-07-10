def myapp(environ, start_response):
    start_response('200 OK', [('Content-Type', 'text/plain')])
    return ['Hello World!\n']

if __name__ == '__main__':
    from flup.server.fcgi import WSGIServer
    WSGIServer(myapp, bindAddress=('127.0.0.1', 65535)).run()
