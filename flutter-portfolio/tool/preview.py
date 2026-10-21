import argparse
from functools import partial
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path


class WasmHandler(SimpleHTTPRequestHandler):
    extensions_map = {**SimpleHTTPRequestHandler.extensions_map, '.wasm': 'application/wasm'}

    def end_headers(self):
        self.send_header('Cross-Origin-Embedder-Policy', 'credentialless')
        self.send_header('Cross-Origin-Opener-Policy', 'same-origin')
        self.send_header('Cache-Control', 'no-cache')
        super().end_headers()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Preview the Flutter Wasm release on loopback.')
    parser.add_argument('--port', type=int, default=5314)
    args = parser.parse_args()
    directory = Path(__file__).resolve().parent.parent / 'build' / 'web'
    if not (directory / 'index.html').is_file():
        parser.error('Build the web app before previewing it.')
    print(f'Local: http://127.0.0.1:{args.port}', flush=True)
    with ThreadingHTTPServer(('127.0.0.1', args.port), partial(WasmHandler, directory=str(directory))) as server:
        try:
            server.serve_forever()
        except KeyboardInterrupt:
            pass
