FROM openresty/openresty:1.15.8.2-1-bionic

RUN echo "\e[1;31m install wget \e[0m" \
    && apt-get install -y wget \
    && rm -rf /var/lib/apt/lists/* \
    && wget "https://luarocks.org/releases/luarocks-3.1.3.tar.gz" \
    && tar zxpf luarocks-3.1.3.tar.gz \
    && cd luarocks-3.1.3 \
    && ./configure --prefix=/usr/local/openresty/luajit \
    --with-lua=/usr/local/openresty/luajit/ \
    --lua-suffix=jit \
    --with-lua-include=/usr/local/openresty/luajit/include/luajit-2.1 \
    && make \
    && echo "\e[1;31m install luarocks \e[0m" \
    && make install \
    && cd .. \
    && rm -rf /luarocks-3.1.3 \
    && rm luarocks-3.1.3.tar.gz \
    && echo "\e[1;31m install lua-resty-auto-ssl \e[0m" \
    && luarocks install lua-resty-auto-ssl \
    && echo "\e[1;31m mkdir resty-auto-ssl \e[0m" \
    && mkdir /etc/resty-auto-ssl \
    && echo "\e[1;31m set access \e[0m" \
    && chown www-data /etc/resty-auto-ssl \
    && echo "\e[1;31m create dummy key-chain \e[0m" \
    && openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
	   -subj '/CN=sni-support-required-for-valid-ssl' \
	   -keyout /etc/ssl/resty-auto-ssl-fallback.key \
	   -out /etc/ssl/resty-auto-ssl-fallback.crt \
    && echo "\e[1;31m first run done \e[0m"
ADD openresty.service /etc/systemd/system