# HTTP Endpoints

HTTP endpoints need to be made available by the digital goods merchant to allow the SatoshiPay widget to retrieve a good once it has successfully been paid for.

Content delivery for [text](#text), [images](#image), [videos](#video) and [downloads](#download) needs to be supported. Audio support will be required soon.

## Endpoints

The merchant needs to provide public endpoints. The URL of an endpoint is defined as the **`data-sp-src` attribute** in the [HTML tag](#html-tags).

In the example, assuming the special HTML tags are defined in `https://example.org/index.html`, the `data-sp-src` attribute has been set to `/satoshipay-content/5` (another possibility would be the absolute URL `https://example.org/satoshipay-content/5`).

## Request Format

> Example Request

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
`paymentCert`   | Certificate for payment. This parameter should be used by the endpoint to authenticate the request (see [authentication](#request-authentication) below).

## Response Format

> Example Response

```html
HTTP/1.1 200 OK
Content-Type: text/html; charset=UTF-8

<strong>OH HAI!</strong> You've <em>nanopaid</em> me.
```

The response needs to have HTTP status 200 set and contain the correct `Content-Type` header for the digital good. In most cases simply passing on the MIME media type returned by the file system should be sufficient, but make sure to check the [list of content types](#supported-content-types) that are supported.

The HTTP header is followed by the content of the digital good, for example HTML code. For a digital good that is HTML text, your responses should look like this example:

## Request Authentication

Authentication is done for each good using its payment certificate. Currently the merchant's HTTP endpoint only needs to check that the value of the query parameter `paymentCert` matches the `secret` that was specified by the merchant when registering the good using the [Provider API](#provider-api). More sophisticated payment certificate matching will be added soon.

<aside class="warning">
  Because payment certificates are pre-shared secrets between the SatoshiPay backend and the merchant, it is advised to secure the HTTP endpoint using an SSL connection (HTTPS).
</aside>

## Cross-Domain

If you are serving digital goods from a different hostname the website containing SatoshiPay widget is served from, you need to work around the same-origin policy by adding these headers to your response:

> Required Headers

```
Access-Control-Allow-Origin: *
Access-Control-Allow-Headers: X-Payment-Certificate
```

## Range Requests

For goods with a larger file size it is recommended to process HTTP range requests and serve [partial content](https://en.wikipedia.org/wiki/Byte_serving). This will allow browsers and download managers to resume a transfer or to transfer file segments in parallel.

To make skipping to a certain position (seeking) in a video possible, support for range requests is mandatory. Most browsers or players won't allow seeking if the HTTP source does not support partial content.

We will publish sample digital goods servers written in PHP and Node with support for range requests soon. [Contact us](mailto:hello@satoshipay.io) if you would like to get early access.

> Standard Response Header

```
HTTP/1.1 200 OK
Accept-Ranges: bytes
Content-Length: 1000
```

> Partial Content Response Header

```
HTTP/1.1 206 Partial Content
Accept-Ranges: bytes
Content-Length: 500
Content-Range: bytes 0-499/1000
```

## HTTP 402

The SatoshiPay widget supports HTTP status code 402 (**"Payment Required"**): It sends payment certificates as an `X-Payment-Certificate` request header. This is only done for the digital goods type Text/HTML, because this type is loaded via an AJAX request where custom headers can be added in JavaScript.

<aside class="notice">
  SatoshiPay's HTTP 402 support is experimental. For production use we advise to implement HTTP endpoints as described above.
</aside>

In order to implement the server part of HTTP 402 handling, your endpoint needs to process and send specific HTTP header information. Currently there is no standard for HTTP 402 responses, so we have created our own proposal.

### Response Header Fields

> Example Response

```
HTTP/1.1 402 Payment Required
Date: Mon, 27 Jul 2009 12:28:53 GMT
X-Payment-Types-Accepted: SatoshiPay
X-Payment-Price: 4000
X-Payment-Identifier: 558bcdbb1309c59725bdb559
```

When the `X-Payment-Certificate` header is not set, or the certificate is invalid, the server needs to respond with HTTP status code `402` and the following response headers containing payment details:

Response Header       | Description
--------------------- | -----------
<span style="white-space: nowrap;">`X-Payment-Types-Accepted: SatoshiPay`</span> | Indicate that the only accepted payment method is SatoshiPay.
`X-Payment-Price: <price>` | Price of the good in satoshis.
<span style="white-space: nowrap;">`X-Payment-Identifier: <satoshipay-id>`</span> | Identifier of the good in SatoshiPay's registry. Needs to be the same as the `data-sp-id` attribute in the corresponding [HTML tag](#html-tags).

### Process Request Headers

Alternatively to the GET parameter `paymentCert` a request to the endpoint can provide the following header:

Request Header | Description
-------------- | -----------
<span style="white-space: nowrap;">`X-Payment-Certificate: <certificate>`</span> | Payment certificate that proves to the endpoint that payment for the associated good has been successfully completed.
