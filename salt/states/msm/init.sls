# will install minecraft-server-manager
# more info here: 

include:
  - minecraft.spigot

/opt/msm:
  file.directory:
    - user: minecraft

install msm:
  file.managed:
    - name: /usr/local/bin/msm
    - source: http://git.io/J1GAxA
    - source_hash: sha1=a56593d5d72d98ff4aa8006bb64c993c5d3d54fe
    - mode: 755
    - user: minecraft
    - require:
      - file: /opt/msm

create init.d link:
  file.symlink:
    - name: /etc/init.d/msm
    - target: /usr/local/bin/msm
    - require:
      - file: /usr/local/bin/msm
  cmd.wait:
    - name: update-rc.d msm defaults

add msm cron script:
  file.managed:
    - name: /etc/cron.d/msm
    - source: http://git.io/pczolg
    - source_hash: sha1=787a29a7f6d3c4cf3b010a142fc639b0d5a2c966
    - watch_in:
      - service: cron
    - require:
      - file: /usr/local/bin/msm

update msm:
  cmd.run:
    - name: yes | /usr/local/bin/msm update
    - require:
      - file: /usr/local/bin/msm

/etc/msm.conf:
  file.managed:
    - source: salt://msm/files/msm.conf
    - template: jinja
    - require:
      - file: /usr/local/bin/msm

# add all jar groups
{% for group, path in salt['pillar.get']('msm:jar-groups').items() %}
add {{ group }} to jar groups:
  cmd.run:
    - user: minecraft
    - name: /usr/local/bin/msm jargroup create {{ group }} {{ path }}
    - unless: /usr/local/bin/msm jargroup list | grep {{ group }}

# this is a tweak that make msm believe it downloaded a jar
# it seems it can't use local files as jar group.
/opt/msm/jars/{{group}}/main.jar:
  file.symlink:
    - target: {{ path }}

{% endfor %}

{% for server, props in salt['pillar.get']('minecraft:servers').items() %}
create the server {{ server }}:
  cmd.run:
    - user: minecraft
    - name: msm server create {{ server }}
    - unless: msm server list | grep {{ server }}

set the server jar to {{ props['jar-group'] }}:
  cmd.run:
    - user: minecraft
    - name: msm {{ server }} jar {{ props['jar-group'] }} main.jar

# create the server, then add the worlds
{% endfor %}
