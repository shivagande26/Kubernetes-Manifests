- Install helm chart of secret store csi driver to kubernetes.
  helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts
  helm install csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver --namespace kube-system

- Verify all crd's installed by the helm chart.
  kubectl get crd -n kube-system

- Install AWS provider to kubernetes cluster.
  kubectl apply -f https://raw.githubusercontent.com/aws/secrets-store-csi-driver-provider-aws/main/deployment/aws-provider-installer.yaml
  NOTE : AWS Provider allows EKS cluster to interact with various AWS services.

- Create a IAM policy with command below.
  POLICY_ARN=$(aws --region ap-south-1 --query Policy.Arn --output text iam create-policy --policy-name secret-manager-access-one --policy-document '{
               "Version": "2012-10-17",
               "Statement": [ {
                   "Effect": "Allow",
                   "Action": ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"],
                   "Resource": ["arn:*:secretsmanager:*:*:secret:mysql-creds"]
               } ]
               }')

- Create the IAM OIDC provider for the cluster
  eksctl utils associate-iam-oidc-provider --region=ap-south-1 --cluster=uat-dev --approve

- Create a service account used by the pod and associate a IAM policy with that service account.
  eksctl create iamserviceaccount --name mysql-creds-sa-one --region=ap-south-1 --cluster uat-test --attach-policy-arn arn:aws:iam::954976304649:policy/secret-manager-access-one --approve --override-existing-serviceaccounts

- Install secret provider class.
  kubectl apply -f secretProvider.yaml

- Install deployment.
  kubectl apply -f deploy.yaml

- Set auto rotation of the secret.
  helm search repo csi
  helm show values secrets-store-csi-driver/secrets-store-csi-driver >> values.yml

- In above values.yml file update the value of "enableSecretsRotation" to true.

- Update the helm release.
  helm list -n kube-system
  helm upgrade csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver --values values-one.yml -n kube-system

Installing ps in mysql container as it is using Oracle os.
yum install -y procps-ng

Kill the process
kill 1
