include:
  - minecraft

minecraft:
  servers:
    sample:
      started: yes
      accept_eula: yes
      msm:
        jar-group: spigot
        version: minecraft/1.3.0
        ram: 512
      properties:
        name: world
        port: 25565
        motd: Welcome to your Minecraft server.
        max_players: 4

msm:
  jar-groups:
    spigot: /opt/spigot/bin/spigot.jar

overviewer:
  maps:
    - name: sample
      worlds:
        main: /opt/msm/servers/sample/world
      renders:
        normal:
          world: main
          title: The main world.