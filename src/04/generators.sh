#!/bin/bash

# Коды ответа HTTP:
# 200: OK (Успешный запрос)
# 201: Created (Успешное создание ресурса)
# 400: Bad Request (Некорректный запрос)
# 401: Unauthorized (Неавторизованный запрос)
# 403: Forbidden (Доступ запрещен)
# 404: Not Found (Ресурс не найден)
# 500: Internal Server Error (Внутренняя ошибка сервера)
# 501: Not Implemented (Не реализовано на сервере)
# 502: Bad Gateway (Плохой, недействительный шлюз)
# 503: Service Unavailable (Сервис недоступен)

list_methods=(
    "GET"
    "POST"
    "PUT"
    "PATCH"
    "DELETE"
)

list_responses=(
    "200"
    "201"
    "400"
    "401"
    "403"
    "404"
    "500"
    "501"
    "502"
    "503"
)

list_url=(
    "/index.html"
    "/about"
    "/contact"
    "/product/123"
    "/product/456"
    "/category/electronics"
    "/category/clothing"
    "/blog/post1"
    "/blog/post2"
    "/login"
    "/logout"
    "/dashboard"
    "/settings"
    "/search?q=query"
    "/cart"
)

list_http_prot=(
    "HTTP/1.1"
    "HTTP/2"
)

list_refer=(
    "http://www.google.com"
    "https://www.bing.com"
    "https://search.yahoo.com"
    "https://duckduckgo.com"
    "https://www.facebook.com"
    "https://twitter.com"
    "https://www.instagram.com"
    "https://www.pinterest.com"
    "https://www.reddit.com"
    "https://www.linkedin.com"
    "https://www.youtube.com"
    "https://www.amazon.com"
    "https://www.ebay.com"
    "https://www.etsy.com"
    "https://www.walmart.com"
)

list_agent=(
    "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36,gzip(gfe)"
    "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36"
    "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36"
    "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36"
    "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36"
    "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 YaBrowser/20.9.2.102 Yowser/2.5 Safari/537.36"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.41 YaBrowser/21.5.0.579 Yowser/2.5 Safari/537.36"
    "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.183 Safari/537.36 Vivaldi/1.96.1147.36"
    "Keybot Translation-Search-Machine"
    "Mozilla/5.0 (Linux; Android 9; Redmi Note 8) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.127 Mobile Safari/537.36"
    "Mozilla/5.0 (Linux; Android 6.0; M5c) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Mobile Safari/537.36"
    "Mozilla/5.0 (Linux; Android 9; Redmi Note 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.99 Mobile Safari/537.36"
    "Mozilla/5.0 (Linux; Android 9; vivo 1901 Build/PPR1.180610.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.84 Mobile Safari/537.36 VivoBrowser/6.7.0.1"
    "Mozilla/5.0 (Linux; Android 10; SM-A600FN) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Mobile Safari/537.36"
    "Mozilla/5.0 (Linux; arm_64; Android 9; Redmi Note 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 YaBrowser/20.11.2.69.00 SA/3 Mobile Safari/537.36"
    "Mozilla/5.0 (Linux; Android 10; MI 8 Lite) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.110 Mobile Safari/537.36"
    "Mozilla/5.0 (Linux; Android 9; COR-L29) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.127 Mobile Safari/537.36"
    "Mozilla/5.0 (Linux; Android 6.0.1; SM-N910C) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Mobile Safari/537.36"
    "Mozilla/5.0 (Linux; Android 10; Redmi Note 8 Pro) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Mobile Safari/537.36"
    "Mozilla/5.0 (Linux; Android 10; COL-L29) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Mobile Safari/537.36"
    "Mozilla/5.0 (Linux; Android 10; M2003J15SC) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36"
    "Mozilla/5.0 (Android 10; Mobile; rv:91.0) Gecko/91.0 Firefox/91.0"
    "Netcat Bot"
    "netEstate NE Crawler (+http://www.website-datenbank.de/)"
    "dklBot/1.0 (klass@odnoklassniki.ru)"
    "parser3"
    "PEAR HTTP_Request class ( http://pear.php.net/ )"
    "pr-cy.ru Screenshot Bot"
    "python-requests/2.8.1"
    "Riddler (http://riddler.io/about)"
    "rogerbot/1.0 (http://moz.com/help/pro/what-is-rogerbot-, rogerbot-wherecat@moz.com)"
    "RookeeBot"
)

log_generator() {
local AMOUNT=$((RANDOM % 901 + 100))
for ((j = 0; j < $AMOUNT; j++)); do
    IP=$(($RANDOM % 255 + 1)).$(($RANDOM % 256)).$(($RANDOM % 256)).$(($RANDOM % 255 + 1))
    DATE=$(LC_TIME=en_US.UTF-8 date -d "+$((j * 5)) seconds" +"[%d/%b/%Y:%H:%M:%S %z]")
    METHOD=${list_methods[$((RANDOM % 5))]}
    URL=${list_url[$((RANDOM % 5))]}
    HTTP=${list_http_prot[$((RANDOM % 2))]}
    RESPONSE=${list_responses[$((RANDOM % 10))]}
    SIZE=$((RANDOM % 1518 + 1))
    REFER=${list_refer[$((RANDOM % 15))]}
    AGENT=${list_agent[$((RANDOM % 32))]}
    echo "$IP - - $DATE \"$METHOD $URL $HTTP\" $RESPONSE $SIZE \"$REFER\" \"$AGENT\"" >> "$1"
done
}
