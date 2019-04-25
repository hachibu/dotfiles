# Installation
- git clone ...
- bin/setup
- rake install

# Usage
Create a file called `.heroku/deploy.yml`.

```yml
version: 1

git_remotes:
  - name: staging
    url: git@heroku.com:app-staging.git

  - name: production
    url: git@heroku.com:app-production.git

hooks:
  - before_git_push: |
      echo 'before git_push'
  - after_git_push: |
      echo 'before git_push'
  - before_heroku_restart: |
      echo 'before git_push'
  - after_heroku_restart: |
      echo 'before git_push'
```

heroku-deploy staging --dry-run
