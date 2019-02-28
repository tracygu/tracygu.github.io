---
layout: page
title:
  zh: 归档
  en: Archives
breadcrumb:
  -
    label: Home
    url: /
---

<div id="archives" class="pl-xl-2">
{% for post in site.posts %}
  {% capture this_year %}{{ post.date | date: "%Y" }}{% endcapture %}
  {% capture pre_year %}{{ post.previous.date | date: "%Y" }}{% endcapture %}
  {% if forloop.first %}
  <span class="lead">{{this_year}}</span>
  <ul class="list-unstyled">
  {% endif %}
    <li>
      <div>
        <span class="date day">{{ post.date | date: "%d" }}</span>
        <span class="date month small text-muted">{{ post.date | date: "%b" }}</span>
        <a href="{{ post.url }}">{{ post.title }}</a>
      </div>
    </li>
  {% if forloop.last %}
  </ul>
  {% else %}
    {% if this_year != pre_year %}
  </ul>
  <span class="lead">{{pre_year}}</span>
  <ul class="list-unstyled">
    {% endif %}
  {% endif %}
{% endfor %}
</div>