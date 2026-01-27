<<<<<<< HEAD
## Git Branching Strategy

This project follows a multi-branch Git workflow to support safe development and deployment across environments.

### Branches

- **main**
  - Production-ready infrastructure and configuration.
  - Only stable, approved changes are merged here.

- `test` branch is deployed to the test environment.
- `staging` branch is deployed to the staging environment after successful testing.
- `main` branch is deployed to production after approvals.

└── feature/* (New features / improvements)
```

---
>>>>>>> f31ddf2 (Finalize .gitignore, README, and Terraform configs for branching)
