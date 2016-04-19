---
title: API Reference

language_tabs:
  - shell

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - errors

search: true
---

# Provider API

The Provider API is hosted by SatoshiPay. Providers talk to this API either directly or through plugins and libraries provided by SatoshiPay or third parties in order to register individual goods for monetisation. The provider itself hosts a complementary [Content API](README_CONTENT_API.md).

Note: In the context of monetisation of web page content *goods* are called [Content Items](README_CONTENT_ITEMS.md).

    https://provider-api-testnet.satoshipay.io/v1/

# Authentication

* [Basic Authentication](https://en.wikipedia.org/wiki/Basic_access_authentication)
* Sign up at https://dashboard-testnet.satoshipay.io/ to receive API key and secret
* Use API key as authentication username and API secret as password

# Format

## Convention

* Output: JSON
* Input: JSON body
* Make sure to send ```Content-Type: application/json``` header when posting data

```shell
curl https://provider-api-testnet.satoshipay.io/v1/goods/558bcdbb1309c59725bdb559 \
  -u user:password \
  -H 'Content-Type: application/json' \
  -d '{"secret": "x"}'
  -X PATCH
```



# Goods

## Get all goods

Get all goods for authenticated user.

```shell
curl https://provider-api-testnet.satoshipay.io/v1/goods \
  -u user:password
```

> Example response

```json
[
  { "id": "56c5a2a4f1cc5c0448c429f2",
    "secret": "n1hLnMiJwAwB",
    "price": 9106,
    "title": "Tempora accusamus maxime similique veritatis magni.",
    "src": "https://example.info" },
  { "id": "56c5a2a52362b70448a589b3",
    "secret": "naKQdYiJbOug",
    "price": 1836,
    "title": "Qui quod sint rem excepturi odio.",
    "src": "http://example.name" },
  { "id": "56c5a2a52362b70448a589b4",
    "secret": "m1btHMWJ6O6g",
    "price": 1349,
    "title": "Saepe voluptatibus tempore pariatur atque quia corrupti nisi dolores.",
    "src": "http://example.name" }
]
```

### HTTP Request

`GET https://api.satoshipay.io/v1/goods`

## Get one good

Get a good.

```shell
    curl https://api.satoshipay.io/v1/goods/558bcdbb1309c59725bdb559 \
      -u user:password
```
> Example response

```json
{
  "id": "558bcdbb1309c59725bdb559",
  "secret": "m1btHMWJ6O6g",
  "price": 1349,
  "title": "Saepe voluptatibus tempore pariatur atque quia corrupti nisi dolores.",
  "src": "http://example.name"
}
```


### HTTP Request

`GET https://api.satoshipay.io/v1/goods/<ID>`


## Post a good

Create a new good.

```shell
    curl https://provider-api-testnet.satoshipay.io/v1/goods \
      -u user:password \
      -H 'Content-Type: application/json' \
      -d '{"secret":"DLDwYsQGromi","price":6247, \
      "title":"Nihil placeat sapiente ut eaque assumenda et reprehenderit quos ab.", \
       "src":"http://example.org/post1"}'
```
> Response

```json
{
  "id": "56c5a5a722252b484dc4839f",
  "secret": "DLDwYsQGromi",
  "price": 6247,
  "title": "Nihil placeat sapiente ut eaque assumenda et reprehenderit quos ab.",
  "src": "http://example.org/post1"
}
```

### HTTP Request

`POST https://provider-api-testnet.satoshipay.io/v1/goods`

### Parameters

Parameter |  Description | Required
--------- |  ----------- | ---------
price | Product price in satoshis | yes
secret | Secret information which the payment server will deliver to client after payment | yes
src | URL of page that contains the good | yes
title | Title of good | yes



## Patch a good

Partially update a good, i.e. send only those properties that are to be updated.

```shell
    curl https://provider-api-testnet.satoshipay.io/v1/goods/558bcdbb1309c59725bdb559 \
      -u user:password \
      -H 'Content-Type: application/json' \
      -d '{"src": "http://example.com/changed"}' \
      -X PATCH
```
> Example response

```json
{
  "id": "56c5a82328383fe54f841a60",
  "secret": "XyZtFohL7",
  "price": 1799,
  "title": "Beatae ab autem delectus dolorem est fugiat.",
  "src": "http://example.com/changed"
}
```

### HTTP Request

`POST https://provider-api-testnet.satoshipay.io/v1/goods/558bcdbb1309c59725bdb559`

### Parameters

Parameter |  Description | Required
--------- |  ----------- | ---------
price | Product price in satoshis | no
secret | Secret information which the payment server will deliver to client after payment | no
src | URL of page that contains the good | no
title | Title of good | no



### *PUT* goods/:id

Replace a good, i.e. send a complete model.

#### Arguments

* **price** (required): Product price in satoshis
* **secret** (required): Secret information which the payment server will deliver to client after payment
* **url** (required): URL of page that contains the good
* **title** (required): Title of good

```shell
    curl https://provider-api-testnet.satoshipay.io/v1/goods/56c5a91265e80b7c51afad23 \
      -u user:password \
      -H 'Content-Type: application/json' \
      -d '{"secret":"RLC43wvCcmcs","price":4806,"title":"Veritatis impedit mollitia nam ipsum laudantium quam quidem.","src":"https://example.net"}' \
      -X PUT
```
> Example response

```json
{
  "id": "56c5a91265e80b7c51afad23",
  "secret": "RLC43wvCcmcs",
  "price": 4806,
  "title": "Veritatis impedit mollitia nam ipsum laudantium quam quidem.",
  "src": "https://example.net"
}
```

### *DELETE* goods/:id

Delete a good.

* No arguments

```shell
    curl https://provider-api-testnet.satoshipay.io/v1/goods/558bcdbb1309c59725bdb559 \
      -u user:password \
      -X DELETE
```
> Example response

* Empty response body

### *POST* batch

Add a batch job of requests

* **requests** (required): Array of requests of form:
    * **method** (required): The method of the query. (POST, PUT, PATCH, DELETE)
    * **path** (required): The path of the resource. (example: ```/goods/:id```)
    * **body** (required): JSON formatted body.



```shell
curl https://provider-api-testnet.satoshipay.io/v1/goods/558bcdbb1309c59725bdb559 \
  -u user:password \
  -d '{"requests":[{"method":"POST","path":"/goods","body":{"secret":"NSKLDspUuo_V","price":1182,"title":"Aliquam sit nisi quia ut rerum.","src":"https://example.com/post1"}},{"method":"POST","path":"/goods","body":{"secret":"wh8tDxlUtkWR","title":"Id fugit atque fugiat eum.","src":"https://armand.info"}},{"method":"POST","path":"/goods","body":{"secret":"NSfg1elotk_R","price":7343,"title":"Vitae facere ea totam hic.","src":"https://example.com/post1"}}]}'
  -X POST
```

> Example response

```json
{
  "responses": [
    {
      "status": 200,
      "body": {
        "id": "56c59f4092d316b1419591eb",
        "secret": "NSKLDspUuo_V",
        "price": 1182,
        "title": "Aliquam sit nisi quia ut rerum.",
        "src": "https://example.com/post1"
      }
    },
    {
      "status": 400,
      "body": {
        "error": "Malformed"
      }
    },
    {
      "status": 200,
      "body": {
        "id": "56c59f4092d316b1419591ec",
        "secret": "NSfg1elotk_R",
        "price": 7343,
        "title": "Vitae facere ea totam hic.",
        "src": "https://example.com/post2"
      }
    }
  ]
}
```