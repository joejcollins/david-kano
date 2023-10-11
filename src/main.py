"""Run the web server."""
import http.server
import socketserver
import os

def run_web_server(directory=".", port=8000):
    """Serve the files in a directory."""
    os.chdir(directory)
    handler = http.server.SimpleHTTPRequestHandler
    with socketserver.TCPServer(("", port), handler) as httpd:
        url = f"http://localhost:{port}"
        print(f"Serving on {url}")
        httpd.serve_forever()

if __name__ == "__main__":
    directory = "./docs"
    port = 8080
    run_web_server(directory, port)
