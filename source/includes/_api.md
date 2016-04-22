# Digital Goods API

> URL of the Digital Goods API

```
https://api.satoshipay.io/v1/
```

The Digital Goods API is hosted by SatoshiPay. Providers talk to this API either directly or through plugins and libraries provided by SatoshiPay or third parties in order to register individual goods for monetization. The provider itself hosts a complementary [Content API](#content-api).

<aside class="notice">
  In the context of monetization of web page content, <em>goods</em> are called <a href="#content-items">Content Items</a>.
</aside>

## General

### Authentication

> Basic Authentication

```shell
curl https://api.satoshipay.io/v1/goods \
  -u <api-key>:<api-secret>
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v1/goods",
  auth: {
    user: "<api-key>",
    password: "<api-secret>"
  }
}, callback);
```

Every request to the API must be authenticated with your API credentials. These credentials can be obtained by creating a provider account at [https://dashboard.satoshipay.io/](https://dashboard.satoshipay.io/). After signing up, you have to add a bitcoin payout address in order for the API credentials to be generated. Once generated, your API key and secret can be found at [https://dashboard.satoshipay.io/settings/api](https://dashboard.satoshipay.io/settings/api).

The API uses [Basic Authentication](https://en.wikipedia.org/wiki/Basic_access_authentication), where the user name is your API key, and the password is your API secret.

The example on the right uses cURL for Basic Authentication to receive the list of all goods.

When the authorization fails, a JSON object with an error message will be returned as a response (along with the HTTP status `401`) .

### Content Types

```shell
curl https://api.satoshipay.io/v1/goods/558bcdbb1309c59725bdb559 \
  -X PATCH \
  -u ngYFu8z33dHT5BdNX:4e2b80863e94ac88da23c541d2772124eb55f57d \
  -H 'Content-Type: application/json' \
  -d '{ "secret": "xyz" }'
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v1/goods/558bcdbb1309c59725bdb559",
  auth: {
    user: "ngYFu8z33dHT5BdNX",
    password: "4e2b80863e94ac88da23c541d2772124eb55f57d"
  },
  method: "PATCH",
  json: {
    secret: "xyz"
  }
}, callback);
```

In general, all endpoints respond with JSON objects.

For `POST`, `PUT` or `PATCH` requests, the request body should be a valid JSON value. Also make sure to include the `Content-Type: application/json` header in those requests.

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

If an error occurs while handling the request, a JSON error object will be returned along with a corresponding HTTP status code. The object contains status- and error-codes, the name of the error, as well as the error message.

## Digital Goods

API endpoints for managing the provider's digital goods.

### List all goods

> Definition

```
GET https://api.satoshipay.io/v1/goods
```

> Example Request

```shell
curl https://api.satoshipay.io/v1/goods \
  -u ngYFu8z33dHT5BdNX:4e2b80863e94ac88da23c541d2772124eb55f57d
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v1/goods",
  auth: {
    user: "ngYFu8z33dHT5BdNX",
    password: "4e2b80863e94ac88da23c541d2772124eb55f57d"
  },
  json: true
}, callback);
```

> Example Response

```json
[
  {
    "id": "56c5a2a4f1cc5c0448c429f2",
    "secret": "n1hLnMiJwAwB",
    "price": 9106,
    "title": "Tempora accusamus maxime similique veritatis magni.",
    "url": "https://example.info"
  },
  {
    "id": "56c5a2a52362b70448a589b4",
    "secret": "m1btHMWJ6O6g",
    "price": 1349,
    "title": "Saepe voluptatibus tempore pariatur atque quia corrupti nisi dolores.",
    "url": "http://example.name"
  }
]
```

Get a list of all the goods that the authenticated user has created.

#### Response

Returns an array of 'good' objects. Every object has the following properties:

Property | Type      | Description
-------- | --------- | ------------
`id`     | *string*  | Unique identifier of the good.
`price`  | *integer* | Product price in satoshis.
`secret` | *string*  | Secret information which the SatoshiPay widget will use to fetch content after successful payment. See [Content API](#content-api).
`url`    | *string*  | URL of the web page which contains the good. Used as a reference in the [Dashboard](https://dashboard.satoshipay.io/performance/goods).
`title`  | *string*  | Title of the good for reference in the provider dashboard.

### Retrieve one Good

> Definition

```
GET https://api.satoshipay.io/v1/goods/<id>
```

> Example Request

```shell
curl https://api.satoshipay.io/v1/goods/558bcdbb1309c59725bdb559 \
  -u ngYFu8z33dHT5BdNX:4e2b80863e94ac88da23c541d2772124eb55f57d
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v1/goods/558bcdbb1309c59725bdb559",
  auth: {
    user: "ngYFu8z33dHT5BdNX",
    password: "4e2b80863e94ac88da23c541d2772124eb55f57d"
  },
  json: true
}, callback);
```

> Example Response

```json
{
  "id": "558bcdbb1309c59725bdb559",
  "secret": "m1btHMWJ6O6g",
  "price": 1349,
  "title": "Saepe voluptatibus tempore pariatur atque quia corrupti nisi dolores.",
  "url": "http://example.name"
}
```

Retrieve a specific good identified by `<id>`. If no good with the given id can be found, an error object with status code `404` is returned.

#### Request

Insert the id of the good into the request URL.

#### Response

A 'good' object with the following properties:

Property | Type      | Description
-------- | --------- | ------------
`id`     | *string*  | Unique identifier of the good.
`price`  | *integer* | Product price in satoshis.
`secret` | *string*  | Secret information which the SatoshiPay widget will use to fetch content after successful payment. See [Content API](#content-api).
`url`    | *string*  | URL of the web page which contains the good. Used as a reference in the [Dashboard](https://dashboard.satoshipay.io/performance/goods).
`title`  | *string*  | Title of the good for reference in the provider dashboard.

### Create a Good

> Definition

```
POST https://api.satoshipay.io/v1/goods
```

> Example Request

```shell
curl https://api.satoshipay.io/v1/goods \
  -u ngYFu8z33dHT5BdNX:4e2b80863e94ac88da23c541d2772124eb55f57d \
  -H 'Content-Type: application/json' \
  -X POST \
  -d '{
       "secret": "DLDwYsQGromi",
       "price": 6247,
       "title": "Nihil placeat sapiente ut eaque assumenda et reprehenderit quos ab.",
       "url": "http://example.org/post1"
      }'
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v1/goods",
  auth: {
    user: "ngYFu8z33dHT5BdNX",
    password: "4e2b80863e94ac88da23c541d2772124eb55f57d"
  },
  method: "POST",
  json: {
    "secret": "DLDwYsQGromi",
    "price": 6247,
    "title": "Nihil placeat sapiente ut eaque assumenda et reprehenderit quos ab.",
    "url": "http://example.org/post1"
  }
}, callback);
```

> Example Response

```json
{
  "id": "56c5a5a722252b484dc4839f",
  "secret": "DLDwYsQGromi",
  "price": 6247,
  "title": "Nihil placeat sapiente ut eaque assumenda et reprehenderit quos ab.",
  "url": "http://example.org/post1"
}
```

Create a new good.

#### Request

Provide a 'good' object with the following properties:

Property | Type      | Required | Description
-------- | --------- | -------- | ------------
`price`  | *integer* | yes      | Product price in satoshis.
`secret` | *string*  | yes      | Secret information which the SatoshiPay widget will use to fetch content after successful payment. See [Content API](#content-api).
`url`    | *string*  | yes      | URL of the web page which contains the good. Used as a reference in the [Dashboard](https://dashboard.satoshipay.io/performance/goods).
`title`  | *string*  | yes      | Title of the good for reference in the provider dashboard.

#### Response

As a confirmation, the handler returns the an object representing the good from the request, augmented by an `id` property, which holds the id that has been assigned to the good as a *string*.

### Replace a Good

> Definition

```
PUT https://api.satoshipay.io/v1/goods/<id>
```

> Example Request

```shell
curl https://api.satoshipay.io/v1/goods/56c5a91265e80b7c51afad23 \
  -u ngYFu8z33dHT5BdNX:4e2b80863e94ac88da23c541d2772124eb55f57d \
  -H 'Content-Type: application/json' \
  -X PUT \
  -d '{
        "secret": "RLC43wvCcmcs",
        "price": 4806,
        "title": "Veritatis impedit mollitia nam ipsum laudantium quam quidem.",
        "url": "https://example.net"
      }'
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v1/goods/558bcdbb1309c59725bdb559",
  auth: {
    user: "ngYFu8z33dHT5BdNX",
    password: "4e2b80863e94ac88da23c541d2772124eb55f57d"
  },
  method: "PUT",
  json: {
    "secret": "RLC43wvCcmcs",
    "price": 4806,
    "title": "Veritatis impedit mollitia nam ipsum laudantium quam quidem.",
    "url": "https://example.net"
  }
}, callback);
```

> Example response

```json
{
  "id": "56c5a91265e80b7c51afad23",
  "secret": "RLC43wvCcmcs",
  "price": 4806,
  "title": "Veritatis impedit mollitia nam ipsum laudantium quam quidem.",
  "url": "https://example.net"
}
```

Replace the good given by `<id>`. If no good with the given id exists, an error object with status code `404` will be returned.

#### Request

Insert the id of the good that should be replaced into the request URL and provide a 'good' object that will replace the old good with the given `id`. The object has the following properties:

Property | Type      | Required | Description
-------- | --------- | -------- | ------------
`price`  | *integer* | yes      | Product price in satoshis.
`secret` | *string*  | yes      | Secret information which the SatoshiPay widget will use to fetch content after successful payment. See [Content API](#content-api).
`url`    | *string*  | yes      | URL of the web page which contains the good. Used as a reference in the [Dashboard](https://dashboard.satoshipay.io/performance/goods).
`title`  | *string*  | yes      | Title of the good for reference in the provider dashboard.

#### Response

As a confirmation, the handler returns an object representing the good from the request, including the `id` property with type *string*.

### Update a Good

> Definition

```
PATCH https://api.satoshipay.io/v1/goods/<id>
```

> Example Request

```shell
curl https://api.satoshipay.io/v1/goods/558bcdbb1309c59725bdb559 \
  -u ngYFu8z33dHT5BdNX:4e2b80863e94ac88da23c541d2772124eb55f57d \
  -H 'Content-Type: application/json' \
  -X PATCH \
  -d '{
        "url": "http://example.com/changed"
      }'
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v1/goods/558bcdbb1309c59725bdb559",
  auth: {
    user: "ngYFu8z33dHT5BdNX",
    password: "4e2b80863e94ac88da23c541d2772124eb55f57d"
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
  "secret": "XyZtFohL7",
  "price": 1799,
  "title": "Beatae ab autem delectus dolorem est fugiat.",
  "url": "http://example.com/changed"
}
```

Partially update a good, i.e. send only those properties that are to be updated.

#### Request

Insert the id of the good that should be updated into the request URL and provide an 'update' object that has any subset of the following properties. The specified properties will then overwrite the properties of the good with the given id in the request URL.

Property | Type      | Required | Description
-------- | --------- | -------- | ------------
`price`  | *integer* | no       | Product price in satoshis.
`secret` | *string*  | no       | Secret information which the SatoshiPay widget will use to fetch content after successful payment. See [Content API](#content-api).
`url`    | *string*  | no       | URL of the web page which contains the good. Used as a reference in the [Dashboard](https://dashboard.satoshipay.io/performance/goods).
`title`  | *string*  | no       | Title of the good for reference in the provider dashboard.

#### Response

The updated 'good' object.

### Delete a Good

> Definition

```
DELETE https://api.satoshipay.io/v1/goods/<id>
```

> Example Request

```shell
curl https://api.satoshipay.io/v1/goods/558bcdbb1309c59725bdb559 \
  -u ngYFu8z33dHT5BdNX:4e2b80863e94ac88da23c541d2772124eb55f57d \
  -X DELETE
```

```javascript
var request = require("request");
request({
  url: "https://api.satoshipay.io/v1/goods/558bcdbb1309c59725bdb559",
  auth: {
    user: "ngYFu8z33dHT5BdNX",
    password: "4e2b80863e94ac88da23c541d2772124eb55f57d"
  },
  method: "DELETE"
}, callback);
```

Delete a good.

#### Request

Insert the id of the good to be deleted into the request URL.

## Batch Requests

> Definition

```
POST https://api.satoshipay.io/v1/batch
```

> Example Request

```shell
curl https://api.satoshipay.io/v1/batch \
  -u ngYFu8z33dHT5BdNX:4e2b80863e94ac88da23c541d2772124eb55f57d \
  -H 'Content-Type: application/json' \
  -X POST \
  -d '{
        "requests": [
          {
            "method": "POST",
            "path": "/goods",
            "body": {
              "secret": "NSKLDspUuo_V",
              "price": 1182,
              "title": "Aliquam sit nisi quia ut rerum.",
              "url": "https://example.com/post1"
            }
          },
          {
            "method": "POST",
            "path": "/goods",
            "body": {
              "secret": "NSfg1elotk_R",
              "price": 7343,
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
  url: "https://api.satoshipay.io/v1/batch",
  auth: {
    user: "ngYFu8z33dHT5BdNX",
    password: "4e2b80863e94ac88da23c541d2772124eb55f57d"
  },
  method: "POST",
  json: {
    "requests": [
      {
        "method": "POST",
        "path": "/goods",
        "body": {
          "secret": "NSKLDspUuo_V",
          "price": 1182,
          "title": "Aliquam sit nisi quia ut rerum.",
          "url": "https://example.com/post1"
        }
      },
      {
        "method": "POST",
        "path": "/goods",
        "body": {
          "secret": "NSfg1elotk_R",
          "price": 7343,
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
        "secret": "NSKLDspUuo_V",
        "price": 1182,
        "title": "Aliquam sit nisi quia ut rerum.",
        "url": "https://example.com/post1"
      }
    },
    {
      "status": 200,
      "body": {
        "id": "56c59f4092d316b1419591ec",
        "secret": "NSfg1elotk_R",
        "price": 7343,
        "title": "Vitae facere ea totam hic.",
        "url": "https://example.com/post2"
      }
    }
  ]
}
```

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
