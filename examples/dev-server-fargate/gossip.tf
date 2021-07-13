resource "aws_secretsmanager_secret" "gossip_key" {
  count = var.gossip_encryption_key != "" ? 1 : 0
  name  = "${var.name}-gossip-encryption-key"
}

resource "aws_secretsmanager_secret_version" "gossip_key" {
  count         = var.gossip_encryption_key != "" ? 1 : 0
  secret_id     = aws_secretsmanager_secret.gossip_key[0].id
  secret_string = var.gossip_encryption_key
}