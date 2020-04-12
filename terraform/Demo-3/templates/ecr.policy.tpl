{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep only one tagged image",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 1
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}