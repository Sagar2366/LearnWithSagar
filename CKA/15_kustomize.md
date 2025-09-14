
### Kustomize: End-to-End Walkthrough

**Core Concept**: Kustomize is a **declarative, overlay-based** tool for customizing Kubernetes manifests. It doesn't use a templating language; it modifies existing YAML files.

#### Key Components

  * **`base`**: The directory containing the original, unmodified Kubernetes manifests. This is your single source of truth.
  * **`overlays`**: Directories that contain a `kustomization.yaml` file and patches to modify the `base` for specific environments.
  * **`kustomization.yaml`**: The central file that defines which resources to manage and what patches or modifications to apply.

#### End-to-End Example

Let's say you have a basic Nginx deployment.

**1. Create a `base` directory with your original manifests.**

```bash
mkdir -p app/base
cd app/base
```

`deployment.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.21.0
        ports:
        - containerPort: 80
```

`service.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: ClusterIP
  ports:
  - port: 80
    targetPort: 80
  selector:
    app: nginx
```

**2. Create a `kustomization.yaml` in the `base` directory.**
This file simply lists the resources you want to manage.

`kustomization.yaml`

```yaml
resources:
- deployment.yaml
- service.yaml
```

**3. Create an `overlays` directory for a "production" environment.**
In this environment, you want to increase replicas and add an environment-specific label.

```bash
mkdir -p ../overlays/prod
cd ../overlays/prod
```

`kustomization.yaml`

```yaml
# kustomization.yaml in overlays/prod
resources:
- ../../base # Reference the base directory

# Add a common label to all resources
commonLabels:
  env: production

# Use a patch to modify the deployment
patches:
- patch: |-
    - op: replace
      path: /spec/replicas
      value: 3
  target:
    kind: Deployment
    name: nginx-deployment
```

**4. Deploy the application for a specific environment.**

  * **Dry Run**: To see the final YAML without applying it.
    ```bash
    kubectl kustomize app/overlays/prod
    # or the standalone command:
    kustomize build app/overlays/prod
    ```
  * **Deploy**: To apply the production configuration.
    ```bash
    kubectl apply -k app/overlays/prod
    ```

-----

### Helm: End-to-End Walkthrough

**Core Concept**: Helm is a **templating-based package manager** for Kubernetes. It uses Go templates and values to generate manifests.

#### Key Components

  * **`Chart`**: A package that contains all necessary resources.
  * **`values.yaml`**: The file for default configuration values.
  * **`templates/`**: Directory where Kubernetes manifest templates live.

#### End-to-End Example

Let's create a similar Nginx deployment using Helm.

**1. Scaffold a new Helm chart.**

```bash
helm create my-nginx-app
cd my-nginx-app
```

**2. Modify `values.yaml` for configuration.**
You'll use this file to manage the image tag and replica count.

`values.yaml`

```yaml
replicaCount: 1

image:
  repository: nginx
  tag: 1.21.0
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 80
```

**3. Modify `templates/deployment.yaml` to use values.**
The template uses Go template syntax to pull values from `values.yaml`.

`templates/deployment.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "my-nginx-app.fullname" . }}
  labels:
    {{- include "my-nginx-app.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: {{ .Chart.Name }}
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
        ports:
        - name: http
          containerPort: 80
```

**4. Install or upgrade the application.**

  * **Dry Run**: To see the final YAML.
    ```bash
    helm template my-nginx-app .
    ```
  * **Install**: To deploy the chart with a release name.
    ```bash
    helm install my-nginx-release .
    ```
  * **Upgrade**: To update the replica count for production.
    ```bash
    helm upgrade my-nginx-release . --set replicaCount=3
    ```
  * **Rollback**: To revert to a previous version if an upgrade fails.
    ```bash
    helm rollback my-nginx-release [REVISION_NUMBER]
    ```

-----

### Final Comparison

| Feature | Helm | Kustomize |
| :--- | :--- | :--- |
| **Philosophy** | **Templating & Packaging**: "Chart your application." | **Overlay & Customization**: "Customize your manifest." |
| **Best For** | Distributing reusable applications, managing complex dependency trees (e.g., WordPress with MariaDB). | Managing different environments (dev, prod) for your own applications. |
| **Release Management** | **Built-in**. Tracks history, supports one-command rollback. | **Manual**. You manage history via Git commits. |
| **Learning Curve** | **Higher**. Requires learning Go templating and Helm-specific conventions. | **Lower**. Uses standard YAML and feels like a natural extension of `kubectl`. |
| **Integration** | A separate CLI tool (`helm`). | **Built-in** to `kubectl` since v1.14. |
| **How It Works** | Combines **templates** and **values** to generate YAML. | Combines **base** manifests and **patches** to generate YAML. |
