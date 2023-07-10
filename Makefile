build-and-push-img:
		cd connectors && \
		docker build . -t $(full-img-name) && \
		docker push $(full-img-name)

init-kubectl:
		kubectl create namespace confluent && \
        kubectl config set-context --current --namespace confluent && \
        helm repo add confluentinc https://packages.confluent.io/helm && \
        helm repo update && \
        helm upgrade --install confluent-operator confluentinc/confluent-for-kubernetes

terraform-first-run:
		az login && \
		cd terraform && \
		terraform init && \
		terraform apply -auto-approve && \
		make terraform-create-key && \
		echo 'change resource group and name if you were updating them in tf variables' && \
		az aks get-credentials --resource-group rg-kuksh0m11-westeurope --name aks-kuksh0m11-westeurope --overwrite-existing && \
		make init-kubectl


terraform-subs-run:
		cd terraform && \
		terraform apply -auto-approve && \
		make terraform-create-key && \
        make init-kubectl

terraform-create-key:
		terraform output -raw azure_acc_key > ../key.txt

terraform-get-key:
		cd terraform && \
		make terraform-create-key


apply-infrastructure:
		bash setImage.sh $(full-img-name) && \
 		kubectl apply -f confluent-platform.yaml && \
 		kubectl apply -f producer-app-data.yaml

tunnel-connect:
		kubectl port-forward connect-0 8083:8083

tunnel-control-center:
		kubectl port-forward controlcenter-0 9021:9021


submit-connector:
		bash maskKeyAndSubmit.sh

first-run:
		make build-and-push-img full-img-name=$(full-img-name) && \
		make terraform-first-run && \
		make apply-infrastructure full-img-name=$(full-img-name)

subs-run:
		make terraform-subs-run && \
		make apply-infrastructure full-img-name=$(full-img-name)

get-key-and-apply-infra:
		make terraform-get-key && \
		make apply-infrastructure full-img-name=$(full-img-name)
