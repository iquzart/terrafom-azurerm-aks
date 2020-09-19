echo "Installing Istio"
bin/istioctl operator init -f custom.yaml

echo "Creating Namespace for CertManager"
kubectl create namespace istio-extentions

echo "Label the istio-extentions namespace to disable resource validation"
kubectl label namespace istio-extentions cert-manager.io/disable-validation=true

echo "Add the Jetstack Helm repository"
helm repo add jetstack https://charts.jetstack.io

echo "Update your local Helm chart repository cache"
helm repo update

echo "Install the cert-manager Helm chart"
helm install \
  cert-manager \
  --namespace istio-extentions \
  --version v0.16.1 \
  --set installCRDs=true \
  jetstack/cert-manager


