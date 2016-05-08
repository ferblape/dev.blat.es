---
layout: post
title:  How to create a embed snippet
date:   2016-05-06 16:10:00
description: How to create a snippet to embed some content
categories:
- blog
---

In Panama Papers project we created some simple and beautiful [charts](https://panamapapers.icij.org/graphs/) representing the key figures of the database. Each chart is embedable using a snippet like this:

{% highlight javascript %}
<script type="text/javascript" src="https://panamapapers.icij.org/embed-chart.js" data-graph="1" data-width="100%" data-height="450px"></script>
{% endhighlight %}

What's the content of `embed-chart.js`?

{% highlight javascript %}
(function(global, undefined){
  'use strict';

  var jQuery;

  /******** Load jQuery if not present *********/
  if (window.jQuery === undefined || window.jQuery.fn.jquery !== '2.2.0') {
    var script_tag = document.createElement('script');
    script_tag.setAttribute("type","text/javascript");
    script_tag.setAttribute("src", "//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.0/jquery.min.js");
    if (script_tag.readyState) {
      script_tag.onreadystatechange = function () { // For old versions of IE
        if (this.readyState == 'complete' || this.readyState == 'loaded') {
          scriptLoadHandler();
        }
      };
    } else { // Other browsers
      script_tag.onload = scriptLoadHandler;
    }
    // Try to find the head, otherwise default to the documentElement
    (document.getElementsByTagName("head")[0] || document.documentElement).appendChild(script_tag);
  } else {
    // The jQuery version on the window is the one we want to use
    jQuery = window.jQuery;
    main();
  }

  /******** Called once jQuery has loaded ******/
  function scriptLoadHandler() {
    // Restore $ and window.jQuery to their previous values and store the
    // new jQuery in our local jQuery variable
    jQuery = window.jQuery.noConflict(true);
    // Call our main function
    main();
  }

  /******** Our main function ********/
  function main() {
    jQuery(document).ready(function($) {
      $('script[data-graph]').each(function(){
        var $script = $(this);
        var graph = $script.data('graph');
        var graphId = "prometheus-graph-" + graph;
        if($('#' + graphId).length === 0){
          var width = $script.data('width');
          var height = $script.data('height');
          $script.after('<iframe id="' + graphId + '" style="width:' + width + ';height:' + height + ';" frameborder="0" marginwidth="0" marginheight="0" scrolling="yes"></iframe>');
          var $iframe = $('#' + graphId);
          height = $iframe.height();
          $iframe.attr('src', "https://panamapapers.icij.org/graphs/" + graph + "/#" + height);
        }
      });
    });
  }
})(window);
{% endhighlight %}

This file generates an iFrame:

{% highlight html %}
<iframe id="prometheus-graph-1" style="width:100%;height:450px;" frameborder="0" marginwidth="0" marginheight="0" scrolling="yes" src="https://panamapapers.icij.org/graphs/1/#450"></iframe>
{% endhighlight %}

In summary:

- we are loading from a CDN the latest version of jQuery

- we search all the elements with `data-graph` in the current page

- the identifier of the graph is included in that attribute

- we need to propagate the height of the graph, instead of ussing iFrame postMessage we are just using the anchor, for simplicity

- in case you need more libraries, apart from jQuery, you could just create a single file with all of them and load it in the header

