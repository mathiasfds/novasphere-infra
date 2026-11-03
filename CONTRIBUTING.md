# Conventions d'équipe - NovaSphere

- **Backend S3 & Verrouillage** : L'utilisation de `dynamodb_table` pour le verrouillage du backend S3 est dépréciée par HashiCorp au profit du verrouillage natif S3 (`use_lockfile = true`) via les requêtes conditionnelles HTTP 412.
- **Workflow Git** : Une branche par fonctionnalité/changement, relecture obligatoire et validation par pull request avant merge sur `main`.
- **Versionnement** : Un tag Git posé à la fin de chaque séance sous le format `v5.<séance>.0` (ex: `v5.1.0` pour la S1).
- **Hygiène et sécurité** : `.gitignore` non négociable interdisant tout commit de fichiers sensibles (`*.tfstate`, `*.tfvars`, `*.pem`, `.env`, inventaires générés).
- **Fin de session** : Exécution systématique de `terraform destroy` ou du script d'arrêt le soir avant de quitter la salle pour éviter la surconsommation de crédits.
