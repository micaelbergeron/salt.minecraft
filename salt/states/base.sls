install base tools:
  pkg.installed:
    - pkgs: 
      - git
      - tar
      - screen
      - sudo
      - cron

cron:
  service.running: []