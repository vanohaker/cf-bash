# cf-bash

Что нужно для работы:
---------------------

- Git
- nano
- Cron

Установка щависимостей Ubuntu:
------------------------------

```
sudo apt-get install git nano
```

Установка скрипта:
------------------

```
mkdir /etc/ddns
cd /etc/ddns
git clone https://github.com/vanohaker/cf-bash.git
cd cf-bash
chmod 775 cloudflire.sh
nano cloudflire.sh
```

### Меняем данные скрипта на свои.

```
APIKEY="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
DOMAIN="domain.ru"
USERNAME="username@emailserver.ru"
```

### Где взять APIKEY?
APIKEY можно найти в настройкам учётной записи CF на самой первой странице. 
Нажимаем сверху Overview, идём вниз и ищем Get your API key, жмум на ссылку.
Ижём в низ. Нам нужен GLOBAL API KEY. Жмём синюю кнопку View API key.

Далее нужно добавтить спавило в cron для того чтобы скрипт выполнялся раз в 5-10 минут.
В скрипте предусмотренна функция кеширования ip то есть если ip не менялся то он не будет 
послен на CF посторно.