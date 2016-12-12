# This file is managed by Salt, do not edit.
{% set outputdir = salt['pillar.get']('overviewer:output_dir') %}
from collections import OrderedDict

worlds = {{worlds|python}}
renders = {{renders|python}}
outputdir = "{{outputdir}}/{{name}}" 
