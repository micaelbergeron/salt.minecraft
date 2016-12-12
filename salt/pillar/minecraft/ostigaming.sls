include:
  - minecraft

minecraft:
  servers:
    ostigaming:
      accept_eula: yes
      started: no
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
    pokemosti:
      accept_eula: yes
      started: no
      msm:
        jar-group: forge
        ram: 2048
        version: craftbukkit/1.3.0
      properties:
        name: world
        port: 25566
        motd: "Gotta catch'em all!"
        seed: 2001046416115967020
    srv_zero:
      accept_eula: yes
      started: no
      msm:
        jar-group: spigot
        ram: 2048
        version: craftbukkit/1.3.0
      properties:
        name: world
        port: 25565
        motd: Burp.
        seed: -075383288093610
        max_players: 20
    panda:
      accept_eula: yes
      started: yes
      msm:
        jar-group: spigot
        ram: 2048
        version: craftbukkit/1.3.0
      properties:
        generator-settings: "{heightStretch: 8}"
        name: world
        port: 25565
        motd: Burp.
        seed: -4172365330660934297
        max_players: 20

msm:
  jar-groups:
    spigot: /opt/spigot/bin/spigot.jar

overviewer:
  maps:
    - name: panda
      worlds:
        main: /opt/msm/servers/panda/world
      renders:
        day:
          world: main
          title: Day
          rendermode: smooth_lighting
        night:
          world: main
          title: Night
          rendermode: smooth_night
