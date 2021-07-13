variable "name" {
  description = "Name to be used on all the resources as identifier."
  type        = string
  default     = "consul-ecs"
}

variable "region" {
  description = "AWS region."
  type        = string
  default     = "us-east-1"
}

variable "lb_ingress_ip" {
  description = "Your IP. This is used in the load balancer security groups to ensure only you can access the Consul UI and example application."
  type        = string
}

variable "gossip_encryption_key" {
  description = "Consul gossip encryption key. Must match among all Consul agents."
  type        = string
  // TODO: Generate if not specified (dev server use-case)
  default   = "h9NDBb1eJipSVqz+y+/kBpardnGw7kPGPZ6bOEhvVDE="
  sensitive = true
}