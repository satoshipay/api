# HTTP Endpoints

HTTP endpoints need to be made available by the digital goods merchant to allow the SatoshiPay widget to retrieve a good once it has successfully been paid for.

<aside class="notice">
  Currently only HTML text content needs to be supported. Images and other content types will added soon.
</aside>

## Endpoints

The merchant needs to provide public endpoints. The URL of an endpoint is defined as the **`data-sp-src` attribute** in the [HTML tag](#html-tags).

In the example, assuming the special HTML tags are defined in `https://example.org/index.html`, the `data-sp-src` attribute has been set to `/satoshipay-content/5` (another possibility would be the absolute URL `https://example.org/satoshipay-content/5`).

## Request Format

> Example request

```bash
curl https://example.org/satoshipay-content/5?paymentCert=kaTBAIv5j
```

```javascript
var request = require("request");
request({
  url: "https://example.org/satoshipay-content/5",
  qs: {
    paymentCert: "kaTBAIv5j"
  }
}, callback);
```

The endpoint will be called with a `GET` request that has the following *query parameters*:

<span style="white-space: nowrap"> Query Parameter</span> | Description
--------------- | -----------
`paymentCert`   | Certificate for payment. This parameter should be used by the endpoint to authenticate the request (see [Authentication](#authentication19) below).

## Response Format

> Example response

```json
{
  "content": "<strong>Some premium content</strong>: Lorem ipsum!"
}
```

The response needs to be a JSON formatted object with the following property:

Property  | Type     | Required | Description
--------- | -------- | -------- | ------------
`content` | *string* | yes      | Content of the digital good. May contain HTML markup.

The endpoint needs to return the correct `Content-Type` header for the content that is shipped. For example `Content-Type:application/json; charset=utf-8` for JSON.

## Authentication

Authentication is done for each good using its payment certificate. Currently the merchant's HTTP endpoint only needs to check that the value of the query parameter `paymentCert` matches the `secret` that was specified by the merchant when registering the good using the [Provider API](#provider-api). More sophisticated payment certificate matching will be added soon.

<aside class="warning">
  Because payment certificates are pre-shared secrets between the SatoshiPay backend and the merchant, it is advised to secure the HTTP endpoint using an SSL connection (HTTPS).
</aside>

## HTTP 402

The SatoshiPay widget *optionally* supports the HTTP status code 402 (**"Payment Required"**): It sends the payment certificate as a `X-Payment-Certificate` request header.

<aside class="notice">
  SatoshiPay's HTTP 402 support is experimental. For production use we advise to implement HTTP endpoints as described above.
</aside>

In order to implement the server part of the HTTP 402 handling, the endpoint needs act as follows:

### Return 402 Response with Payment Information Headers

> Example response

```
HTTP/1.1 402 Payment Required
Date: Mon, 27 Jul 2009 12:28:53 GMT
X-Payment-Types-Accepted: SatoshiPay
X-Payment-Price: 4000
X-Payment-Identifier: <satoshipay-id>
```

When the `X-Payment-Certificate` header is not set, or the certificate is invalid, the server has to respond with a status code of `402` and the following response headers:

Response Header       | Description
--------------------- | -----------
<span style="white-space: nowrap;">`X-Payment-Types-Accepted: SatoshiPay`</span> | Indicate that one of the accepted payment methods is the SatoshiPay service.
`X-Payment-Price: <price>` | Price of the good in satoshis.
<span style="white-space: nowrap;">`X-Payment-Identifier: <satoshipay-id>`</span> | Identifier of the good in SatoshiPay's registry. Needs to be the same as the `data-sp-id` attribute in the corresponding [HTML tag](#html-tags).

### Process Request Headers

A valid request to the endpoint needs to provide the following header, which the server needs to process:

Request Header | Description
-------------- | -----------
<span style="white-space: nowrap;">`X-Payment-Certificate: <certificate>`</span> | Payment certificate that proves to the server that payment for the associated good has been successfully completed.
