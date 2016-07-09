Versichere, dass Apache installiert ist:
  pkg.installed:
    - name: httpd

Versichere, dass Apache am laufen ist:
  service.running:
    - name: httpd
