# Digital Goods API

> Digital Goods API Endpoint

```
https://api.satoshipay.io/v2/
```

The Digital Goods API allows developers to interact with SatoshiPay using HTTP REST calls and JSON. Digital goods merchants communicate with the API in order to register individual goods for sale &ndash; either directly or through plugins and libraries provided by SatoshiPay or 3rd parties. The digital goods merchant hosts complementary [HTTP Endpoints](#retrieving-goods) that deliver the goods to the user.

## General

### API Authentication

> Basic Authentication

```shell
curl https://api.satoshipay.io/v2/goods/ \
  -u <api-key>:<api-secret>
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v2/goods/",
  auth: {
    user: "<api-key>",
    password: "<api-secret>"
  }
}, callback);
```

Every request to the API must be authenticated with your API credentials. These credentials can be obtained in the [SatoshiPay Dashboard](https://dashboard.satoshipay.io/) after [creating an account](https://dashboard.satoshipay.io/sign-up). Before you can access your credentials, you need to set a Stellar address for payouts. Your API key and secret can then be found at [Settings > API Access](https://dashboard.satoshipay.io/settings/api).

The API uses [Basic Authentication](https://en.wikipedia.org/wiki/Basic_access_authentication), where the user name is your API key, and the password is your API secret.

The example uses Basic Authentication to receive the list of your goods. The result will be an empty array `[]` if you didn't add any goods yet.

If authorization fails, a JSON object with an error message will be returned as a response (along with the HTTP status `401`) .

### Valid JSON 

```shell
curl https://api.satoshipay.io/v2/goods/558bcdbb1309c59725bdb559 \
  -X PATCH \
  -u apikey:apisecret \
  -H 'Content-Type: application/json' \
  -d '{ "sharedSecret": "xyz" }'
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v2/goods/558bcdbb1309c59725bdb559",
  auth: {
    user: "apikey",
    password: "apisecret"
  },
  method: "PATCH",
  json: {
    sharedSecret: "xyz"
  }
}, callback);
```

All endpoints respond with JSON objects.

For `POST`, `PUT` or `PATCH` requests, the request body needs to be valid JSON. Also make sure to include a `Content-Type: application/json` header in your requests.

### Errors

> Example Error Object

```json
{
  "name": "unauthorized",
  "message": "Unauthorized Request",
  "statusCode": 401,
  "errorCode": 401
}
```

If an error occurs while handling the request, a JSON error object will be returned along with a corresponding HTTP status code. The object contains status and error codes, the name of the error, as well as the error message.

## Goods

The API resource `goods` allows a merchant to manage their digital goods. A good in the API represents a merchant's digital good (e.g. news article, image, audio/video or file download) and holds all information needed for SatoshiPay to handle payments. This includes pricing information and other metadata, but not the content itself.

### List Goods

> Definition

```
GET https://api.satoshipay.io/v2/goods/
```

> Example Request

```shell
curl https://api.satoshipay.io/v2/goods/ \
  -u apikey:apisecret
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v2/goods/",
  auth: {
    user: "apikey",
    password: "apisecret"
  },
  json: true
}, callback);
```

> Example Response

```json
[
  {
    "id": "56c5a2a4f1cc5c0448c429f2",
    "price": 100000000,
    "asset": "XLM",
    "sharedSecret": "n1hLnMiJwAwB",
    "url": "https://example.info",
    "title": "Tempora accusamus maxime similique veritatis magni."
  },
  {
    "id": "56c5a2a52362b70448a589b4",
    "price": 50000000,
    "asset": "XLM",
    "sharedSecret": "m1btHMWJ6O6g",
    "url": "http://example.name",
    "title": "Saepe voluptatibus tempore pariatur atque quia corrupti nisi dolores.",
    "purchaseValidityPeriod": 86400000
  }
]
```

`GET goods`

Get a list of all goods a merchant has created.

#### Response

Returns an array of 'good' objects. Every object has the following properties:

Property | Type      | Description
-------- | --------- | ------------
`id`     | *string*  | Unique identifier of the good.
`price`  | *integer* | Gross price of good in stroops. One lumen is `10^7` (10,000,000) stroops.
`asset`  | *string*  | Asset of good's price.  Only "XLM" is currently supported.
`sharedSecret` | *string*  | Shared secret information which will be used to sign the `paymentReceipt` used to [authenticate](#retriving-auth) user during digital goods [retrieval](#retrieving-goods).
`url`    | *string*  | URL of the web page which contains the good. Used as a reference in the [Dashboard](https://dashboard.satoshipay.io/performance/goods).
`title`  | *string*  | Title of the good for reference in the provider dashboard.
`purchaseValidityPeriod`  | *string*  | Time until the good's [payment expiry](#payment-expiry).

### Create a Good

> Definition

```
POST https://api.satoshipay.io/v2/goods
```

> Example Request

```shell
curl https://api.satoshipay.io/v2/goods/ \
  -u apikey:apisecret \
  -H 'Content-Type: application/json' \
  -X POST \
  -d '{
       "sharedSecret": "DLDwYsQGromi",
       "price": 200000000,
       "asset": "XLM",
       "title": "Nihil placeat sapiente ut eaque assumenda et reprehenderit quos ab.",
       "url": "http://example.org/post1",
       "purchaseValidityPeriod": "1h"
      }'
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v2/goods/",
  auth: {
    user: "apikey",
    password: "apisecret"
  },
  method: "POST",
  json: {
    "sharedSecret": "DLDwYsQGromi",
    "price": 200000000,
    "asset": "XLM",
    "title": "Nihil placeat sapiente ut eaque assumenda et reprehenderit quos ab.",
    "url": "http://example.org/post1",
    "purchaseValidityPeriod": "1h"
  }
}, callback);
```

> Example Response

```json
{
    "id": "5b61b65c96fec50010512cf6",
    "sharedSecret": "DLDwYsQGromi",
    "asset": "XLM",
    "price": 200000000,
    "title": "Nihil placeat sapiente ut eaque assumenda et reprehenderit quos ab.",
    "url": "http://example.org/post1",
    "purchaseValidityPeriod": 3600000
}
```

`POST goods`

Create a new good.

#### Request

Provide a 'good' object with the following properties:

Property | Type      | Required | Description
-------- | --------- | -------- | ------------
`price`  | *integer* | yes      | Gross price of good in stroops. One lumen is `10^7` (10,000,000) stroops.
`asset`  | *string*  | yes      | Asset of good's price. Only "XLM" is currently supported.
`sharedSecret` | *string*  | yes      | Shared secret information which will be used to sign the `paymentReceipt` used to [authenticate](#retriving-auth) user during digital goods [retrieval](#retrieving-goods).
`url`    | *string*  | yes      | URL of the web page which contains the good. Used as a reference in the [Dashboard](https://dashboard.satoshipay.io/performance/goods).
`title`  | *string*  | yes      | Title of the good for reference in the provider dashboard.
`purchaseValidityPeriod`  | *string*  | no      | Time until the good's [payment expiry](#payment-expiry).

#### Response

As a confirmation, the handler returns the an object representing the good from the request, augmented by an `id` property, which holds the ID that has been assigned to the good as a *string*.

### Retrieve a Good

> Definition

```
GET https://api.satoshipay.io/v2/goods/<id>
```

> Example Request

```shell
curl https://api.satoshipay.io/v2/goods/558bcdbb1309c59725bdb559 \
  -u apikey:apisecret
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v2/goods/558bcdbb1309c59725bdb559",
  auth: {
    user: "apikey",
    password: "apisecret"
  },
  json: true
}, callback);
```

> Example Response

```json
{
  "id": "558bcdbb1309c59725bdb559",
  "sharedSecret": "m1btHMWJ6O6g",
  "price": 50000000,
  "asset": "XLM",
  "title": "Saepe voluptatibus tempore pariatur atque quia corrupti nisi dolores.",
  "url": "http://example.name",
  "purchaseValidityPeriod": 60000
}
```

`GET goods/<id>`

Retrieve a specific good identified by `<id>`. If no good with the given ID can be found, an error object with status code `404` is returned.

#### Request

Insert the ID of the good into the request URL.

#### Response

A 'good' object with the following properties:

Property | Type      | Description
-------- | --------- | ------------
`id`     | *string*  | Unique identifier of the good.
`price`  | *integer* | Gross price of good in stroops. One lumen is `10^7` (10,000,000) stroops.
`asset`  | *string*  | Asset of good's price.  Only "XLM" is supported.
`sharedSecret` | *string*  | Shared secret information which will be used to sign the `paymentReceipt` used to [authenticate](#retriving-auth) user during digital goods [retrieval](#retrieving-goods).
`url`    | *string*  | URL of the web page which contains the good. Used as a reference in the [Dashboard](https://dashboard.satoshipay.io/performance/goods).
`title`  | *string*  | Title of the good for reference in the provider dashboard.
`purchaseValidityPeriod`  | *interger*  | Time in milliseconds until the good's payment expires.

### Replace a Good

> Definition

```
PUT https://api.satoshipay.io/v2/goods/<id>
```

> Example Request

```shell
curl https://api.satoshipay.io/v2/goods/56c5a91265e80b7c51afad23 \
  -u apikey:apisecret \
  -H 'Content-Type: application/json' \
  -X PUT \
  -d '{
        "sharedSecret": "RLC43wvCcmcs",
        "price": 200000000,
        "asset": "XLM",
        "title": "Veritatis impedit mollitia nam ipsum laudantium quam quidem.",
        "url": "https://example.net",
        "purchaseValidityPeriod": "60000"
      }'
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v2/goods/558bcdbb1309c59725bdb559",
  auth: {
    user: "apikey",
    password: "apisecret"
  },
  method: "PUT",
  json: {
    "sharedSecret": "RLC43wvCcmcs",
    "price": 200000000,
    "asset": "XLM",
    "title": "Veritatis impedit mollitia nam ipsum laudantium quam quidem.",
    "url": "https://example.net",
    "purchaseValidityPeriod": "60000"
  }
}, callback);
```

> Example Response

```json
{
    "id": "5b61b76d66fec50010514cf7",
    "sharedSecret": "RLC43wvCcmcs",
    "asset": "XLM",
    "price": 200000000,
    "title": "Veritatis impedit mollitia nam ipsum laudantium quam quidem.",
    "url": "https://example.net",
    "purchaseValidityPeriod": 60000
}
```

`PUT goods/<id>`

Replace the good given by `<id>`. If no good with the given ID exists, an error object with status code `404` will be returned.

#### Request

Insert the ID of the good that should be replaced into the request URL and provide a 'good' object that will replace the old good with the given `id`. The object has the following properties:

Property | Type      | Required | Description
-------- | --------- | -------- | ------------
`price`  | *integer* | yes      | Gross price of good in stroops. One lumen is `10^7` (10,000,000) stroops.
`asset`  | *string*  | yes      | Asset of good's price. Only "XLM" is currently supported.
`sharedSecret` | *string*  | yes      | Shared secret information which will be used to create `paymentReceipt` used to [authenticate](#retriving-auth) user during digital goods [retrieval](#retrieving-goods).
`url`    | *string*  | yes      | URL of the web page which contains the good. Used as a reference in the [Dashboard](https://dashboard.satoshipay.io/performance/goods).
`title`  | *string*  | yes      | Title of the good for reference in the provider dashboard.
`purchaseValidityPeriod`  | *string*  | no      | Time until the good's [payment expiry](#payment-expiry).

#### Response

As a confirmation, the handler returns an object representing the good from the request, including the `id` property with type *string*.

### Update a Good

> Definition

```
PATCH https://api.satoshipay.io/v2/goods/<id>
```

> Example Request

```shell
curl https://api.satoshipay.io/v2/goods/558bcdbb1309c59725bdb559 \
  -u apikey:apisecret \
  -H 'Content-Type: application/json' \
  -X PATCH \
  -d '{
        "url": "http://example.com/changed"
      }'
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v2/goods/558bcdbb1309c59725bdb559",
  auth: {
    user: "apikey",
    password: "apisecret"
  },
  method: "PATCH",
  json: {
    "url": "http://example.com/changed"
  }
}, callback);
```

> Example Response

```json
{
  "id": "56c5a82328383fe54f841a60",
  "sharedSecret": "XyZtFohL7",
  "price": 150000000,
  "asset": "XLM",
  "title": "Beatae ab autem delectus dolorem est fugiat.",
  "url": "http://example.com/changed"
}
```

`PATCH goods/<id>`

Partially update a good, i.e. send only those properties that are to be updated.

#### Request

Insert the ID of the good that should be updated into the request URL and provide an 'update' object that has any subset of the following properties. The specified properties will then overwrite the properties of the good with the given id in the request URL.

Property | Type      | Required | Description
-------- | --------- | -------- | ------------
`price`  | *integer* | no       | Gross price of good in stroops. One lumen is `10^7` (10,000,000) stroops.
`asset`  | *string*  | yes      | Asset of good's price. Only "XLM" is currently supported.
`sharedSecret` | *string*  | no       | Shared secret information which will be used to create `paymentReceipt` used to [authenticate](#retriving-auth) user during digital goods [retrieval](#retrieving-goods).
`url`    | *string*  | no       | URL of the web page which contains the good. Used as a reference in the [Dashboard](https://dashboard.satoshipay.io/performance/goods).
`title`  | *string*  | no       | Title of the good for reference in the provider dashboard.
`purchaseValidityPeriod`  | *string*  | no      | Time until the good's [payment expiry](#payment-expiry).

#### Response

The updated 'good' object.

### Delete a Good

> Definition

```
DELETE https://api.satoshipay.io/v2/goods/<id>
```

> Example Request

```shell
curl https://api.satoshipay.io/v2/goods/558bcdbb1309c59725bdb559 \
  -u apikey:apisecret \
  -X DELETE
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v2/goods/558bcdbb1309c59725bdb559",
  auth: {
    user: "apikey",
    password: "apisecret"
  },
  method: "DELETE"
}, callback);
```

`DELETE goods/<id>`

Delete a good.

#### Request

Insert the ID of the good to be deleted into the request URL.

## Batch Requests

> Definition

```
POST https://api.satoshipay.io/v2/batch/
```

> Example Request

```shell
curl https://api.satoshipay.io/v2/batch/ \
  -u apikey:apisecret \
  -H 'Content-Type: application/json' \
  -X POST \
  -d '{
        "requests": [
          {
            "method": "POST",
            "path": "/goods",
            "body": {
              "sharedSecret": "NSKLDspUuo_V",
              "price": 50000000,
              "asset": "XLM",
              "title": "Aliquam sit nisi quia ut rerum.",
              "url": "https://example.com/post1"
            }
          },
          {
            "method": "POST",
            "path": "/goods",
            "body": {
              "sharedSecret": "NSfg1elotk_R",
              "price": 180000000,
              "asset": "XLM",
              "title": "Vitae facere ea totam hic",
              "url": "https://example.com/post2"
            }
          }
        ]
      }'
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v2/batch/",
  auth: {
    user: "apikey",
    password: "apisecret"
  },
  method: "POST",
  json: {
    "requests": [
      {
        "method": "POST",
        "path": "/goods",
        "body": {
          "sharedSecret": "NSKLDspUuo_V",
          "price": 50000000,
          "asset": "XLM",
          "title": "Aliquam sit nisi quia ut rerum.",
          "url": "https://example.com/post1"
        }
      },
      {
        "method": "POST",
        "path": "/goods",
        "body": {
          "sharedSecret": "NSfg1elotk_R",
          "price": 180000000,
          "asset": "XLM",
          "title": "Vitae facere ea totam hic",
          "url": "https://example.com/post2"
        }
      }
    ]
  }
}, callback);
```

> Example Response

```json
{
  "responses": [
    {
      "status": 200,
      "body": {
        "id": "56c59f4092d316b1419591eb",
        "sharedSecret": "NSKLDspUuo_V",
        "price": 50000000,
        "asset": "XLM",
        "title": "Aliquam sit nisi quia ut rerum.",
        "url": "https://example.com/post1"
      }
    },
    {
      "status": 200,
      "body": {
        "id": "56c59f4092d316b1419591ec",
        "sharedSecret": "NSfg1elotk_R",
        "price": 180000000,
        "asset": "XLM",
        "title": "Vitae facere ea totam hic.",
        "url": "https://example.com/post2"
      }
    }
  ]
}
```

`POST batch`

Execute a batch of requests at once.

#### Request

Provide an array of 'request' objects in the body. Each request object has the following properties:

Property | Type          | Required              | Description
-------- | ------------- | -------------------   | -----------
`method` | *string*      | yes                   | The method of the query. Has to be one of POST, PUT, PATCH or DELETE.
`path`   | *string*      | yes                   | The path of the resource. For example: `/goods/<id>`
`body`   | *json value*  | depending on `method` | JSON value that represents the body of the request.

#### Response

Returns an array of 'response' objects that each correspond to the respective request from the request array. Each response object has the following properties:

Property | Type         | Description
-------- | ------------ | -----------
`status` | *integer*    | HTTP status code of the respective request.
`body`   | *json value* | JSON value that represents the response body from the respective request.

## Payment Expiry

Digital goods can have a payment expiry. After a successful payment, a good will be in its paid state until the defined expiry time interval has passed, after which the payment will no longer be valid.

### Setting Payment Expiry

During the registration of a good, the optional `purchaseValidityPeriod` property can be set with an arbitrary, positive time period. The time format is translated by the ["ms" NPM package](https://www.npmjs.com/package/ms), which converts various time formats to milliseconds. See examples below. 

**Examples:**

Value | Milliseconds
-------- | ------------ 
`"5s"` | 5000
`"60000"` | 60000
`"1m"` | 60000
`"2.5 hrs"` | 9000000
`"2 days"` | 172800000  
`"1y"` | 31557600000
