# outputs.tf — Informations exposées après déploiement

output "instance_id" {
  description = "ID de l'instance EC2"
  value       = aws_instance.web.id
}

output "public_ip" {
  # TODO 5 : Description de l'adresse IP publique
  description = "Adresse IP publique de l'instance EC2 pour l'accès externe"
  value       = aws_instance.web.public_ip
}

output "ssh_command" {
  description = "Commande SSH prête à l'emploi pour se connecter à l'instance"
  # On utilise la variable du chemin de clé et l'IP publique de l'instance
  value       = "ssh -i ${var.ssh_public_key_path} ubuntu@${aws_instance.web.public_ip}"
}

output "ami_id" {
  description = "ID de l'AMI Ubuntu utilisée pour le déploiement"
  value       = data.aws_ami.ubuntu.id
}

output "security_group_id" {
  description = "ID du Security Group associé à l'instance"
  value       = aws_security_group.web.id
}
