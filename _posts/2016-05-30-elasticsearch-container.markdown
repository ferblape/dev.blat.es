---
layout: post
title: Creating a Docker container for ElasticSearch
date: 2016-05-11 12:10:00
description: How to setup and configure a data container for ElasticSearch
categories:
- blog
---

At Populate, we use [ElasticSearch as a superstructured data storage](https://medium.com/lets-populate/using-elasticsearch-as-a-super-fast-structured-data-storage-5df441292ab#.j8nluj6k8).

In the last days we have moved that infrastructure to Docker. This post describes how.

Creating the container:

```
# Create data volume
docker create -v /usr/share/elasticsearch/data/elasticsearch --name es-gobierto-budgets-data busybox bin/true

# Create elasticsearch
docker run -d  -p 9250:9200 --name es-gobierto-budgets --volumes-from es-gobierto-budgets-data elasticsearch

# Check it works
# using alpine
docker run -t -i --rm --volumes-from es-gobierto-budgets-data alpine /bin/sh
# using ubuntu
docker run -t -i --rm --volumes-from es-gobierto-budgets-data ubuntu /bin/bash
```

Backup the container:

```
docker run --rm --volumes-from es-gobierto-budgets-data -v $(pwd):/backup alpine tar cvf /backup/backup.tar /usr/share/elasticsearch/data/elasticsearch
```


Restore backup:

```
docker create -v /usr/share/elasticsearch/data/elasticsearch --name es-gobierto-budgets-data busybox bin/true
docker run --volumes-from es-gobierto-budgets-data -v $(pwd):/backup ubuntu bash -c "cd / && tar xvf /backup/es-gobierto-budgets-data.tar --strip 1 && mv share/elasticsearch/data/elasticsearch/* /usr/share/elasticsearch/data/elasticsearch/"
```
