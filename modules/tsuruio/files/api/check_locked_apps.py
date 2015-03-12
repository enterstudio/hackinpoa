#!/usr/bin/env python
import yaml
import sys
from pymongo import Connection

stream = open(sys.argv[1], 'r')
yaml_data = yaml.load(stream)

mongo_client = Connection(yaml_data['database']['url'])
mongo_db = mongo_client[yaml_data['database']['name']]
if ( mongo_db.apps.find({"lock.locked":True}).count() != 0 ):
    sys.exit(2)
sys.exit(0)
