
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "boarding-week2-eks"
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.33"
}

variable "vpc_name" {
  description = "Existing VPC name"
  type        = string
  default     = "boarding-week2-vpc"
}
