{% set minecraft = salt['pillar.get']('minecraft') %}

include:
  - java.jdk

minecraft:
  user.present: []

scaffold minecraft directories:
  file.directory:
    - makedirs: yes
    - names:
      - /opt/minecraft/bin
    - user: minecraft
    - mode: 755

download minecraft_server.jar:
  file.managed:
    - source: https://s3.amazonaws.com/Minecraft.Download/versions/{{ minecraft.jar.version }}/minecraft_server.{{ minecraft.jar.version }}.jar
    - source_hash: {{ minecraft.jar.checksum }}
    - user: minecraft
    - group: minecraft
    - name: /opt/minecraft/bin/minecraft_server.jar
    - mode: 755
    - require:
      - file: /opt/minecraft/bin