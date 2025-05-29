### My GitHub Actions Workflow Naming Conventions

| Type                     | Pattern             | Example               | Purpose                                |
|--------------------------|---------------------|------------------------|----------------------------------------|
| Tool-specific CI         | `*-ci.yml`          | `ansible-ci.yml`       | Run validation/lint/test for a tool    |
| CD / Deployment flows    | `*-cd.yml`          | `helmfile-cd.yml`      | Deploy apps or infra (orchestrators)   |
| Callable (tool-specific) | `<tool>-<type>.yml` | `ansible-lint.yml`<br>`tf-lint.yml`, `tf-docs.yml` | Reusable jobs scoped to a tool         |
