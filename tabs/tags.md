---
layout: page
title:
  zh: 标签
  en: Tags
sitemap:
  priority: .5
---


{%comment%}
'site.tags' looks like a Map, e.g. site.tags.MyTag[Post0, Post1, ...]
{%endcomment%}
<div id="tags" class="d-flex flex-wrap">
{% assign sort_tuple_tags = site.tags | sort %}
{% for tuple_tag in sort_tuple_tags %}
  {% assign tag = tuple_tag | first %}
  {% assign post_size  = tuple_tag | last | size %}
  <div>
    <a class="tag" href="/tags/{{tag | downcase | replace:' ' , '-'}}/">{{ tag }}<span class="text-muted">{{ post_size }}</span></a>
  </div>
{% endfor %}
</div>
