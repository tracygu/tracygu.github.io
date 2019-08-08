---
title: "Example Post"
date: 2018-01-01 00:00:00 +0800
categories: [Blog, Example]
tags: [example]
comments: false
---


## Typograpy

# H1

<h2 data-toc-skip>H2</h2>

<h3 data-toc-skip>H3</h3>

#### H4


## Tables

|Company|Contact|Country|
|:---|:--|---:|
|Alfreds Futterkiste | Maria Anders | Germany
|Island Trading | Helen Bennett | UK
|Magazzini Alimentari Riuniti | Giovanni Rovelli | Italy

## Hightlight

This is a `sample` to `code hightlight`.

## Link

[http://127.0.0.1:4000](http://127.0.0.1:4000)


## Footnote

Click the hook will locate the footnote. [^footnote]


## Image

![Desktop View]({{site.baseurl}}/assets/img/sample/mockup.jpg)


## Code Snippet

### Ruby

```ruby
def sum_eq_n?(arr, n)
  return true if arr.empty? && n == 0
  arr.product(arr).reject { |a,b| a == b }.any? { |a,b| a + b == n }
end
```

### Shell

```shell
if [ $? -ne 0 ]; then
    echo "The command was not successful.";
    #do the needful / exit
fi;
```

### Liquid

{% highlight liquid %}
{% raw %}
{% if product.title contains 'Pack' %}
  This product's title contains the word Pack.
{% endif %}
{% endraw %}
{% endhighlight %}

### Line Number

**No Scrolling**

{% capture _code %}
{% highlight html linenos %}
<div class="sidenav">
  <a href="#contact">Contact</a>
  <button class="dropdown-btn">Dropdown 
    <i class="fa fa-caret-down"></i>
  </button>
  <div class="dropdown-container">
    <a href="#">Link 1</a>
    <a href="#">Link 2</a>
    <a href="#">Link 3</a>
  </div>
  <a href="#contact">Search</a>
</div>
{% endhighlight %}
{% endcapture %}{% include fixlinenos.html %}{{ _code }}

**Horizontal Scrolling**

{% capture _code %}
{% highlight html linenos %}
<div class="panel-group">
  <div class="panel panel-default">
    <div class="panel-heading" id="{{ category_name }}">
      <i class="far fa-folder"></i>
      <p>This is a very long long long long long long long long long long long long long long long long long long long long long line.</p>
      </a>
    </div>
  </div>
</div>
{% endhighlight %}
{% endcapture %}{% include fixlinenos.html %}{{ _code }}


***


[^footnote]: The footnote source.


