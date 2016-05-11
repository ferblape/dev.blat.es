---
layout: post
title: Cap local deploy
date: 2016-05-11 12:10:00
description: How to deploy to localhost
categories:
- blog
---

To give a server of the capabilities to auto-update itself and run the latest version of an
application code with the latest dependencies is a great feature, very useful, for example, if you
are using Amazon auto-scaling, where servers are created and destroyed all the time.

We have solved this issue with Capistrano in [our latest project](https://offshoreleaks.icij.org)
with this hack:

```
$ ls -1 config/deploy/
local.rb
production.rb
staging.rb
```

Yes, we have a `local` stage, with a very simple configuration:

```
server 'localhost', roles: %w{app web}, user: fetch(:user)
```

That's all. Everytime a server is created, it'll run `cap local deploy` to have the latest version
of the code, gems, and assets installed.
