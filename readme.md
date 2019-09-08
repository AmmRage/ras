# ras

openresty with auto ssl in docker

![GitHub Actions](https://github.com/AmmRage/ras/workflows/Publish Docker/badge.svg)

## Usage

### Run

volume

mount **/usr/local/openresty/nginx/conf** and **/etc/ssl/[subfolder]** 

> **DO NOT** mount the /etc/ssl because it will affect the openssl environment.

### Add New Domain

2. **IN SERVER** add new server item in configuration file

1. **IN CONTAINER** run the commmand to create dummy key-chain

3. **IN CONTAINER** reload config 

> investigate auto reload of configuration file and other automatic things like intergate CSP api to auto add domain & add configuration items & create dummy cert 

## Build

## To Do

1. fill up usage details

2. add CI

3. add test

