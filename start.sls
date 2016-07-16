Versichere, dass Docker am laufen ist:
  service.running:
    - name: docker

Versichere, dass Docker Image Centos7 vorhanden ist:
  dockerng.image_present:
    - name: centos
