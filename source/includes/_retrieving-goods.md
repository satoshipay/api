# Retrieving Goods

The merchant needs to provide public endpoints to allow the SatoshiPay widget to retrieve a good once it has successfully been paid for. The URL of an endpoint is defined as the **`data-sp-src` attribute** in the [HTML tag](#html-tags).

In the example, assuming the special HTML tags are defined in `https://example.org/index.html`, the `data-sp-src` attribute has been set to `/satoshipay-content/5` (another possibility would be the absolute URL `https://example.org/satoshipay-content/5`).

Content delivery for [text](#text), [images](#image), [audio files](#audio), [videos](#video) and [downloads](#download) needs to be supported.

## Request Format

> Example Request

```bash
curl https://example.org/satoshipay-content/5?paymentReceipt=eyJleHAiOjE1MDM1NzY4NDksIml0byI6IjAyZmNmZWNiZGFiMTExMmY0MjRiYzc2MTVmZDY2NjkzNzBhMjc3Njg1MjgxMjc3MWM2YWQ1Y2RmZTU3MTgzNDNkNSIsImp0aSI6ImNRNkROa1dUdjU3NGVLb2NoQnZlZWFtRzY2WE9lSUx4In0.13c5d97f6ac3b0d2412962437066ca22ada3cafad1aefad85a2e261a98b2ee14e0ca8f3c7772c78fd8fed9cfb0b51b4b4c154c078a1a0b36a5c19185c84b6281
```

```javascript
var request = require("request");
request({
  url: "https://example.org/satoshipay-content/5",
  qs: {
    paymentReceipt: "eyJleHAiOjE1MDM1NzY4NDksIml0byI6IjAyZmNmZWNiZGFiMTExMmY0MjRiYzc2MTVmZDY2NjkzNzBhMjc3Njg1MjgxMjc3MWM2YWQ1Y2RmZTU3MTgzNDNkNSIsImp0aSI6ImNRNkROa1dUdjU3NGVLb2NoQnZlZWFtRzY2WE9lSUx4In0.13c5d97f6ac3b0d2412962437066ca22ada3cafad1aefad85a2e261a98b2ee14e0ca8f3c7772c78fd8fed9cfb0b51b4b4c154c078a1a0b36a5c19185c84b6281"
  }
}, callback);
```

The endpoint will be called with a `GET` request that has the following *query parameters*:

Query&nbsp;Parameter | Description
--------------- | -----------
`paymentReceipt`   | Receipt for payment. This parameter should be used by the endpoint to authenticate the request (see [authentication](#retrieving-auth) below).

<a name="retrieving-auth"></a>
## Authentication

Authentication is implemented on the merchant's HTTP endpoint without connecting to the SatoshiPay API. It is done by verifying the value of the query parameter `paymentReceipt`, which consists of the [Base64](https://en.wikipedia.org/wiki/Base64) encoded JSON payload and a signature split by a dot.

> Example URL

```text
https://example.org/satoshipay-content/5?paymentReceipt=eyJleHAiOjE1MDM1NzY4NDksIml0byI6IjAyZmNmZWNiZGFiMTExMmY0MjRiYzc2MTVmZDY2NjkzNzBhMjc3Njg1MjgxMjc3MWM2YWQ1Y2RmZTU3MTgzNDNkNSIsImp0aSI6ImNRNkROa1dUdjU3NGVLb2NoQnZlZWFtRzY2WE9lSUx4In0.13c5d97f6ac3b0d2412962437066ca22ada3cafad1aefad85a2e261a98b2ee14e0ca8f3c7772c78fd8fed9cfb0b51b4b4c154c078a1a0b36a5c19185c84b6281

PAYLOAD_BASE64="eyJleHAiOjE1MDM1NzY4NDksIml0byI6IjAyZmNmZWNiZGFiMTExMmY0MjRiYzc2MTVmZDY2NjkzNzBhMjc3Njg1MjgxMjc3MWM2YWQ1Y2RmZTU3MTgzNDNkNSIsImp0aSI6ImNRNkROa1dUdjU3NGVLb2NoQnZlZWFtRzY2WE9lSUx4In0"
SIGNATURE="13c5d97f6ac3b0d2412962437066ca22ada3cafad1aefad85a2e261a98b2ee14e0ca8f3c7772c78fd8fed9cfb0b51b4b4c154c078a1a0b36a5c19185c84b6281"
```

`http://example.org/path?paymentReceipt=${payloadBase64}.${signature}`


Query&nbsp;Parameter | Description
--------------- | -----------
`payloadBase64` | Base64 encoded payload describes the user and expiration time.
`signature` | Signature is the SHA-512 hash of string resulting from concatenating `payloadBase64` and the good's `sharedSecret` known only by the merchant.

### Payload

`payloadBase64` is a Base64 encoded JSON structure allowing to identify to whom the receipt was issued to and defining the time it expires.
> Example `payloadBase64`
```
eyJleHAiOjE1MDM1NzY4NDksIml0byI6IjAyZmNmZWNiZGFiMTExMmY0MjRiYzc2MTVmZDY2NjkzNzBhMjc3Njg1MjgxMjc3MWM2YWQ1Y2RmZTU3MTgzNDNkNSIsImp0aSI6ImNRNkROa1dUdjU3NGVLb2NoQnZlZWFtRzY2WE9lSUx4In0
```

> Example Payload

```json
{
    "exp": 1503576849,
    "ito": "02fcfecbdab1112f424bc7615fd6669370a2776852812771c6ad5cdfe5718343d5",
    "jti": "cQ6DNkWTv574eKochBveeamG66XOeILx"
}
```

> Example `signature`

The correct signature for the above example payload and a `sharedSecret` value of `"jsbicjttovhgtkdtsthduxg"` is
```text
"13c5d97f6ac3b0d2412962437066ca22ada3cafad1aefad85a2e261a98b2ee14e0ca8f3c7772c78fd8fed9cfb0b51b4b4c154c078a1a0b36a5c19185c84b6281"
```

Field | Name | Description
--------------- | ----------- | -----------
`exp` | Expiration time | Expiration time (UNIX time in seconds) after which the payment receipt **MUST NOT** be accepted for processing.
`ito` | Issued To | Identifies a user to whom the receipt was issued to.
`jti` | JWT ID | Case sensitive unique identifier of the token.

### Validating request

> Validation procedure

```js
const SHA512 = require('crypto-js/sha512')
const base64url = require('base64url');

function validate (sharedSecret, paymentReceipt) {
  const receipt = paymentReceipt.split('.')
  const payloadBase64 = receipt[0]
  const payload = base64url.decode(payloadBase64)
  const payloadParsed = JSON.parse(payload)
  const signature = receipt[1]
  const hash = SHA512(payloadBase64 + sharedSecret).toString()

  return (hash === signature && payloadParsed.exp > Date.now() / 1000)
}
```

Validating `paymentReceipt` means verifying the signature and expiration time. The signature is the SHA-512 hash of the string resulting from concatenating `payloadBase64` and the good's `sharedSecret` known only by merchant.

The merchant is responsible for generating a unique `sharedSecret` for every good and storing it in the merchant's own database.

<aside class="warning">
  If `sharedSecret` is not unique for every good, it would mean that any random valid `paymentReceipt` can be used to access all goods served by the merchant.
</aside>

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

The response needs to have HTTP status 200 set and contain the correct `Content-Type` header for the digital good. In most cases simply passing on the MIME media type returned by the file system should be sufficient, but make sure to check the [list of content types](#content-types) that are supported.

The HTTP header is followed by the content of the digital good, for example HTML code.

## Cross-Domain

> Required Headers

```
Access-Control-Allow-Origin: *
```

If you are serving digital goods from a different hostname the website containing SatoshiPay widget is served from, you need to work around the same-origin policy by adding these headers to your response:

## Range Requests

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

For goods with a larger file size it is recommended to process HTTP range requests and serve [partial content](https://en.wikipedia.org/wiki/Byte_serving). This will allow browsers and download managers to resume a transfer or to transfer file segments in parallel.

To make skipping to a certain position (seeking) in an audio file or video possible, support for range requests is required. Most browsers or players won't allow seeking if the HTTP source does not support partial content.

We will publish sample digital goods servers written in PHP and Node with support for range requests soon. [Contact us](mailto:hello@satoshipay.io) if you would like to get early access.
