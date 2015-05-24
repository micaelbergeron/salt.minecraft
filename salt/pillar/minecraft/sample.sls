include:
  - minecraft

minecraft:
  servers:
    sample:
      started: yes
      accept_eula: yes
      msm:
        jar-group: minecraft
        version: minecraft/1.3.0
        ram: 512
      properties:
        name: world
        port: 25565
        motd: Welcome to your Minecraft server.
        max_players: 4