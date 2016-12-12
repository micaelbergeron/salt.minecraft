include:
  - minecraft
{% set minecraft_user = salt['pillar.get']('minecraft:user', 'minecraft') %}

add overviewer repository:
  pkgrepo.managed:
    - humanname: Overviewer repository
    - name: deb http://overviewer.org/debian ./
    - key_url: http://overviewer.org/debian/overviewer.gpg.asc
    - require_in:
      - pkg: minecraft-overviewer

install overviewer:
  pkg.installed:
    - name: minecraft-overviewer

create runtime directories:
  file.directory:
    - names:
      - /opt/overviewer
      - /opt/overviewer/renders
      - /opt/overviewer/config.d
    - user: {{minecraft_user}}

{% for pack in salt['pillar.get']('overviewer:textures') %}
{% set version = pack['version'] %}
download minecraft {{version}} textures:
  file.managed:
    - name: /home/{{minecraft_user}}/.minecraft/versions/{{version}}/{{version}}.jar
    - source: http://s3.amazonaws.com/Minecraft.Download/versions/{{version}}/{{version}}.jar
    - source_hash: {{pack['checksum']}}
    - user: {{minecraft_user}}
    - makedirs: true
{% endfor %}

{% for map in salt['pillar.get']('overviewer:maps') %}
{{map['name']}} ~ setup server configuration:
  file.managed:
    - name: /opt/overviewer/config.d/{{map['name']}}.py
    - source: salt://overviewer/files/config.py
    - template: jinja
    - context: {{map|yaml}}

{{map['name']}} ~ crontab:
  cron.present:
    - name: overviewer.py --config=/opt/overviewer/config.d/{{map['name']}}.py
    - identifier: overviewer_{{map['name']}}
    - user: minecraft
    - hour: '*/6'
    - require:
      - file: /opt/overviewer/config.d/{{map['name']}}.py
{% endfor %}
