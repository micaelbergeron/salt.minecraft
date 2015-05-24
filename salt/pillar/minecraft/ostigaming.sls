include:
  - minecraft

minecraft:
  servers:
    ostigaming:
      accept_eula: yes
      started: yes
      msm:
        jar-group: spigot
        ram: 2048
        version: craftbukkit/1.3.0
      properties:
        name: world
        port: 25565
        motd: Raph est vraiment une kisse.
        seed: -740172851302529273
        max_players: 20

msm:
  jar-groups:
    spigot: /opt/spigot/bin/spigot.jar
