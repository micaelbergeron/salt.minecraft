# this will install the Spigot Build tools and build spigot
# more info here: http://www.spigotmc.org/

include:
  - minecraft

scaffolding spigot directories:
  file.directory:
    - names:
      - /opt/spigot
      - /opt/spigot/bin
      - /opt/spigot/buildtools
    - user: minecraft
    - mode: 755

install buildtools:
  file.managed:
    - name: /opt/spigot/buildtools/BuildTools.jar
    - source: https://hub.spigotmc.org/jenkins/job/BuildTools/lastStableBuild/artifact/target/BuildTools.jar
    - source_hash: md5=315b5360005e9eaaf3be1da7c42fecdb
    - mode: 755
    - user: minecraft
    - group: minecraft
    - require:
      - file: /opt/spigot

build spigotmc:
  cmd.wait:
    - name: java -jar BuildTools.jar
    - cwd: /opt/spigot/buildtools
    - user: minecraft
    - watch:
      - file: /opt/spigot/buildtools/BuildTools.jar

deploy spigotmc:
  cmd.run:
    - use:
      - cmd: java -jar BuildTools.jar
    - name: mv spigot*.jar /opt/spigot/bin/spigot.jar
    - watch:
      - cmd: java -jar BuildTools.jar

