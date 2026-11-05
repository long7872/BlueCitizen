"""Local, build-time preview and layout measurement endpoint."""
import http.server
import pathlib

ROOT = pathlib.Path(__file__).resolve().parents[2]
class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self,*args,**kwargs):
        super().__init__(*args,directory=str(ROOT),**kwargs)
    def do_POST(self):
        if self.path != '/__save_layout':
            self.send_error(404)
            return
        body=self.rfile.read(int(self.headers['Content-Length']))
        (ROOT/'design_source/preview/measured_layout.json').write_bytes(body)
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b'Layout saved')
    def log_message(self,*args):
        pass
http.server.ThreadingHTTPServer(('127.0.0.1',8081),Handler).serve_forever()
