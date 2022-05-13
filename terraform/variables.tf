variable "REGION" {
  type    = string
  default = "us-east-2"
}

variable "AWS_ACCESS_KEY" {
  type      = string
  sensitive = true
}

variable "AWS_SECRET_KEY" {
  type      = string
  sensitive = true
}

variable "SSH_PASSWORD" {
  type      = string
  sensitive = true
}

variable "ALLOCATION_ID" {
  type      = string
  sensitive = false
  default   = "eipalloc-0c57be50bb3a7471b"
}
