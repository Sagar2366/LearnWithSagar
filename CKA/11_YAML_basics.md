# YAML : Yet Another Markup Language

- Widely used format for writing Kubernetes resource files
- Data serialization language
- When you create an object in Kubernetes, you must provide the object spec that describes its desired state, as well as some basic information about the object (such as a name).
- Most often, you provide the information to kubectl in a file known as a manifest written in YAML format.
- Tools such as kubectl convert the information from a manifest into JSON or another supported serialization format when making the API request over HTTP.

In the manifest (YAML or JSON file) for the Kubernetes object you want to create, you'll need to set values for the following fields:
```
apiVersion - Which version of the Kubernetes API you're using to create this object
kind - What kind of object you want to create
metadata - Data that helps uniquely identify the object, including a name string, UID, and optional namespace
spec - What state do you desire for the object
```

## Creating a pod using the declarative method:
1. Write a pod manifest file
```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80
```
2. Apply the manifest file to create a pod
   ```
   kubectl apply -f pod_manifest.yaml
   ```

## Creating a pod using the imperative method
```
kubectl run nginx --image=nginx:1.14.2 --port=80
kubectl run nginx --image=nginx:1.14.2 --port=80 --dry-run=client -o yaml > pod_manifest.yaml
```

# YAML Syntax
1. <b>Key Value Pairs:</b>
   The basic type of entry in a YAML file is of a key value pair. After the Key and colon there is a space and then the value.
   
2. <b>Arrays/List:</b>
   Lists would have a number of items listed under the name of the list.</br>
   The elements of the list would start with a -. There can be a n of lists, however the indentation of various elements of the array matters a lot.
   Used for grouping multiple items of the same type

3. <b>Dictionary/Maps:</b>
   YAML dictionaries are collections of key-value pairs, often nested to represent hierarchical data and represented with a ':'
   where each key is unique and the order doesn't matter



## Another example:
```
apiVersion: v1
kind: Pod
metadata:                         # Dictionary: Pod Metadata
  name: multi-container-pod       # String: Name of the Pod
  labels:
    app: multi-container-app      # String: Label to identify the Pod
spec:
  containers:                     # List: A list of containers within the Pod
    - name: nginx-container       # Dictionary: Container 1 definition
      image: nginx:1.14.2         # String: Docker image for the first container
      ports:                      # List: Ports exposed by the first container
        - containerPort: 80       # Integer: The port number for the first container
      env:                        # List: Environment variables for the first container
        - name: ENV_VAR_ONE       # String: Name of an environment variable
          value: "value1"         # String: Value of the environment variable
      securityContext:
        readOnlyRootFilesystem: true   # Boolean: true means the filesystem is read-only
        allowPrivilegeEscalation: false # Boolean: false means privilege escalation is not allowed
    - name: sidecar-container     # Dictionary: Container 2 definition
      image: busybox              # String: Docker image for the second container
      args:                       # List: Arguments passed to the second container
        - /bin/sh                 # String: Command to run in the second container
        - -c                      # String: Command flag
        - "echo Hello, Kubernetes! && sleep 3600" # String: Command string to execute
      env:                        # List: Environment variables for the second container
        - name: ENV_VAR_TWO       # String: Name of an environment variable
          value: "value2"         # String: Value of the environment variable
        - name: ENV_VAR_THREE     # String: Name of an environment variable
          value: "value3"         # String: Value of the environment variable
        - name: ENABLE_FEATURE_X
          value: "true"  # Although it's a boolean, it's passed as a string here

```

# Additional Notes:
<b>Boolean:</b>
   Booleans in YAML can take one of two values: true or false.
   These values are unquoted and case-insensitive, so you can write them as true, True, TRUE, false, False, or FALSE.

<b>Multiline strings:</b>
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: game-demo
data:
  # property-like keys; each key maps to a simple value
  player_initial_lives: "3"
  ui_properties_file_name: "user-interface.properties"

  # file-like keys
  game.properties: |
    enemy.types=aliens,monsters
    player.maximum-lives=5    
  user-interface.properties: |
    color.good=purple
    color.bad=yellow
    allow.textmode=true 
   ```

- Multiple YAML documents can be separated by three '-' 
- YAML uses indentation to denote hierarchy. Always use spaces (not tabs) for indentation.
- Use # for adding comments
