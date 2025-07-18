## Part 9. Свой *node_exporter*

##### Изменение конфигурационного файла **Prometheus** для сборки информации с созданной скриптом **main.sh** страницы.

- /etc/prometheus/prometheus.yml

![](09/part9_1.png "prometheus.yml")

- /etc/nginx/nginx.conf

![](09/part9_2.png "nginx.conf")

- Prometheus:

![](09/part9_3.png "Prometheus")

- Метрики на `192.168.1.4:9191/metrics`

![](09/part9_4.png "Метрики")

##### Проведение тестов из [Части 7](#part-7-prometheus-и-grafana)

## Запуск скрипта из 2 части

![](09/part9_5.png "Скрипт из 2 части")

## Очистка скриптом из части 3

![](09/part9_6.png "Очистка")

## Запуск стресс-теста

> `stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 60s`

![](09/part9_7.png "Стресс-тест")
