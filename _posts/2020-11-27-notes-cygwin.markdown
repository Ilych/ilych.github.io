---
layout: post
title:  "Заметки про Cygwin"
date:   2020-11-27 00:49:40 +0300
categories: jekyll update
---

### **cygwin**

[cygwin64_min.zip](https://yadi.sk/d/CQl7n0oO8AjGDg) 32MB 2020-11-10

Единый хомяк для всех пользователей: `/etc/nsswitch.conf: db_home:  /home/user`

Виндовые ярлыки: `export CYGWIN=winsymlinks:lnk`

Отключение posix acl, tmp пользователя /etc/fstab: 
	
	none /cygdrive cygdrive noacl,binary,posix=0,user 0 0
	none /tmp usertemp noacl,binary,posix=0 0 0


apt-cyg:
	
	curl https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg -o apt-cyg
	/etc/setup/setup.rc
	https://mirror.yandex.ru/mirrors/ftp.cygwin.com/x86_64/setup.ini

Количество файлов в подпапках:

	ls | while read d ; do c=$(find "$d" -type f | wc -l); echo $c $d; done | sort -nr 

Чистка 
{% highlight shell %}
/usr/share/locale
	ls | grep -v ru | xargs rm -rf

/usr/share/terminfo
/usr/lib/terminfo
	find . -type f | grep -v -e rxvt -e xterm -e screen -e mintty | xargs rm -v
	find . -type d -empty
	find . -type d -empty | xargs rm -rf -v
	
/usr/share/zoneinfo
	find . -type f | grep -v -e GMT -e Moscow | xargs rm -v
	find . -type d -empty | xargs rm -rf -v	
	
/usr/share/doc
{% endhighlight %} 

Установка Jekyll

	apt-cyg install sqlite3 gcc-g++ make ruby libsqlite3-devel zlib-devel libgdbm-devel openssl-devel libffi-devel
	gem install jekyll bundler


### **msys2**

<https://mirror.yandex.ru/mirrors/msys2/distrib/x86_64/>

<https://www.msys2.org/>

	ls | while read d ; do c=$(find "$d" -type f | wc -l); echo $c $d; done | tee -a ~/share.txt

Чистка:
{% highlight shell %}
/usr/share/locale
	ls | grep -v ru | xargs rm -rf

/usr/share/terminfo
/usr/lib/terminfo
	find . -type f | grep -v -e rxvt -e xterm -e screen -e mintty | xargs rm -v
	find . -type d -empty
	find . -type d -empty | xargs rm -rf -v

/usr/share/zoneinfo
	find . -type f | grep -v -e GMT -e Moscow | xargs rm -v
	find . -type d -empty | xargs rm -rf -v	
{% endhighlight %} 

Jekyll also offers powerful support for code snippets:

{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
{% endhighlight %}

Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/
