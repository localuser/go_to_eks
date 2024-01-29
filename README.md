## Hello wide world!

This application is a "Hello world" app with a difference (hint: it is a wide world).

### Requirements

1. You have [minikube](https://minikube.sigs.k8s.io) installed

### Getting started

1. Open a terminal in the local project directory (here)
1. Start a minikube cluster: 
    ```
    minikube start
    ```
1. Build the Docker image: 
    ```
    minikube image build -t hello-wide-world:latest .
    ```
1. Start the load-balanced kubernetes service: 
    ```
    minikube kubectl -- apply -f hello-wide-world.yaml
    ```
1. Start minikube tunnel to allow external access to the service: 
    ```
    minikube tunnel
    ```

### What next?

Well done! You are ready to use this service. 

For a basic test, run `minikube service hello-wide-world` and your browser will be opened to the service URL.