Dockerfile:
  runs-on: ubuntu-latest
  needs: Dependances

  steps:
    - name: Récupération du repository
      uses: actions/checkout@v7

    - name: Contrôle du Dockerfile avec Trivy
      uses: aquasecurity/trivy-action@v0.36.0
      with:
        scan-type: config
        scan-ref: Dockerfile
        severity: HIGH,CRITICAL
        exit-code: 1

    - name: Construction de l'image Docker
      run: |
        docker build -t breakableflask:test .

    - name: Contrôle des dépendances de l'image Docker avec Trivy
      uses: aquasecurity/trivy-action@v0.36.0
      with:
        scan-type: image
        image-ref: breakableflask:test
        severity: HIGH,CRITICAL
        exit-code: 1
