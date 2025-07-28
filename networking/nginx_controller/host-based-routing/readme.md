Here is the docs.
https://kubernetes.github.io/ingress-nginx/deploy/#aws

Copied the manifest file to nginx-tls-termination.yaml file.

Updated "proxy-real-ip-cidr" in nginx-tls-termination.yaml manifest file with the EKS cluster VPC CIDR.

Updated the ACM certificate "service.beta.kubernetes.io/aws-load-balancer-ssl-cert" with AWS Certificate Manager certificate arn.

Deployed nginx ingress controller with nginx-tls-termination.yaml file.

Deployed the ingress resource with host-routing.yaml file.