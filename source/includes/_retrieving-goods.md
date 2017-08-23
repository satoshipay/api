# Retrieving Goods

The merchant needs to provide public endpoints to allow the SatoshiPay widget to retrieve a good once it has successfully been paid for. The URL of an endpoint is defined as the **`data-sp-src` attribute** in the [HTML tag](#html-tags).

In the example, assuming the special HTML tags are defined in `https://example.org/index.html`, the `data-sp-src` attribute has been set to `/satoshipay-content/5` (another possibility would be the absolute URL `https://example.org/satoshipay-content/5`).

Content delivery for [text](#text), [images](#image), [audio files](#audio), [videos](#video) and [downloads](#download) needs to be supported.

## Request Format

> Example Request

```bash
curl https://example.org/satoshipay-content/5?paymentReceipt=kaTBAIv5j
```

```javascript
var request = require("request");
request({
  url: "https://example.org/satoshipay-content/5",
  qs: {
    paymentReceipt: "kaTBAIv5j"
  }
}, callback);
```

The endpoint will be called with a `GET` request that has the following *query parameters*:

Query&nbsp;Parameter | Description
--------------- | -----------
`paymentReceipt`   | Receipt for payment. This parameter should be used by the endpoint to authenticate the request (see [authentication](#retriving-auth) below).

<a name="retriving-auth"></a>
## Authentication

Authentication is done for each good using its payment receipt. The merchant's HTTP endpoint needs to verify that the value of the query parameter `paymentReceipt` is valid.

<aside class="warning">
  Because payment receipts can be used to access the content, it is advised to secure the HTTP endpoint using an SSL connection (HTTPS).
</aside>

## Response Format

> Example Response

```html
HTTP/1.1 200 OK
Content-Type: text/html; charset=UTF-8

<strong>OH HAI!</strong> You've <em>nanopaid</em> me.
```

The response needs to have HTTP status 200 set and contain the correct `Content-Type` header for the digital good. In most cases simply passing on the MIME media type returned by the file system should be sufficient, but make sure to check the [list of content types](#supported-content-types) that are supported.

The HTTP header is followed by the content of the digital good, for example HTML code.

## Cross-Domain

If you are serving digital goods from a different hostname the website containing SatoshiPay widget is served from, you need to work around the same-origin policy by adding these headers to your response:

> Required Headers

```
Access-Control-Allow-Origin: *
```

## Range Requests

For goods with a larger file size it is recommended to process HTTP range requests and serve [partial content](https://en.wikipedia.org/wiki/Byte_serving). This will allow browsers and download managers to resume a transfer or to transfer file segments in parallel.

To make skipping to a certain position (seeking) in an audio file or video possible, support for range requests is required. Most browsers or players won't allow seeking if the HTTP source does not support partial content.

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
