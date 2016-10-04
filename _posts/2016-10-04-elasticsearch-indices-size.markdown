---
layout: post
title: ElasticSearch indices size
date: 2016-10-04 12:10:00
description: How to get the size of the indices
categories:
- blog
---

```
curl http://localhost:9250/_stats/index,store | jq -C
```

Where `jq` is this [fantastic tool](https://stedolan.github.io/jq/manual/#Invokingjq)

More information in [the documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-stats.html)
