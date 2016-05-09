# Integration

This section describes what needs to be done by the provider in order to integrate paid content items into his website.

## Content API

A Content API needs to be made available by the content provider to allow the SatoshiPay widget to pull content once the item has successfully been paid for.

<aside class="notice">
  Currently only text content needs to be supported. Images and other content types will added soon.
</aside>

### Endpoints

The API needs to provide exactly one endpoint. The route of that endpoint is defined as the **`data-sp-src` attribute** in the [content item tag](#content-items).

In the example below, assuming the content item tags are defined in `https://example.org/index.html`, the `data-sp-src` attribute has been set to `/satoshipay-content/5` (Another possibility would be the absolute url `https://example.org/satoshipay-content/5`).

### Request Format

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
`paymentCert`   | Certificate for payment. This parameter should be used by the API to authenticate the call (see [Authentication](#authentication19) below).

### Response Format

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

The Content API needs to return the correct `Content-Type` header for the content that is shipped. For example `Content-Type:application/json; charset=utf-8` for JSON.

### Authentication

Authentication is done for each content item using its payment certificate. Currently the provider's Content API only needs to check that the value of the query parameter `paymentCert` matches the `secret` that was specified by the provider when registering the content item using the [Provider API](#provider-api). Proper payment certificate matching will be added in the future.

<aside class="warning">
  Since the payment certificate currently is only a shared secret between the SatoshiPay backend and the Content API, it is strongly advised to use SSL/TLS.
</aside>

### HTTP 402

The SatoshiPay widget supports the HTTP status code 402 (**"Payment Required"**): It sends the certificate of payment as the `X-Payment-Certificate` request header. In order to implement the server part of the protocol, the content API server has to do the following:

#### Return 402 Response with Payment Information Headers

> Example response

```
HTTP/1.1 402 Payment Required
Date: Mon, 27 Jul 2009 12:28:53 GMT
X-Payment-Types-Accepted: SatoshiPay
X-Payment-Amount-SatoshiPay: 4000
X-Payment-ID-SatoshiPay: <satoshipay id>
```

When the `X-Payment-Certificate` header is not set, or the certificate is invalid, the server has to respond with a status code of `402` and the following response headers:

Response Header       | Description
--------------------- | -----------
<span style="white-space: nowrap;">`X-Payment-Types-Accepted: SatoshiPay`</span> | Indicate that one of the accepted payment methods is the SatoshiPay service.
`X-Payment-Amount-SatoshiPay: <amount>` | Price of the resource. Given in Satoshis.
<span style="white-space: nowrap;">`X-Payment-ID-SatoshiPay: <satoshipay-id>`</span> | Identifier assigned by SatoshiPay of the product that's being monetized and which this resource references. Coincides with the `data-sp-id` attribute in the [Content Item](#content-items).

#### Process Request Headers

A valid request to the content API endpoint needs to provide the following headers, which the server needs to process:

Request Header | Description
-------------- | -----------
<span style="white-space: nowrap;">`X-Payment-Certificate: <certificate>`</span> | Payment certificate that proves to the server that payment for the associated good has been successfully completed.

## Content Items

> Content item tag example

```html
<p class="satoshipay-placeholder"
   data-sp-src="/satoshipay-content"
   data-sp-id="558bcdbb1309c59725bdb559"
   data-sp-length="800"
   data-sp-price="4000"
></p>
```

Paid content can be included in a website by defining *content-item tags* which will then be controlled by the SatoshiPay widget.

![Content item](images/content-mask.png "Content item")

Before purchase, paid content is displayed on the content provider's website as masked characters. These block characters are injected by the SatoshiPay widget, which scans the current page for empty content item placeholder tags on initialization. The placeholder tags are identified by the CSS class name `satoshipay-placeholder` and contain details about the content they replace in their `data` attributes (see the content item example).

The data attributes specify where the content can be downloaded from by the SatoshiPay client once the purchase has been successfully completed, which specific content item is being masked, its price and its length. See below for a detailed description of the data attributes.

The SatoshiPay stylesheets apply styles to content items using the `satoshipay-placeholder` CSS class, so that the items are recognizable while the SatoshiPay widget is being initialized.

### Data Attributes

Data Attribute   | Required | Description
---------------- | -------- | -----------
`data-sp-src`    | yes      | Absolute or relative URL to endpoints of the [Content API](#content-api), e.g. `/satoshipay-content`.
`data-sp-id`     | yes      | Unique identifier for content assigned by SatoshiPay to each product monetized through SatoshiPay. Consists of a hex string, e.g. "558bcdbb1309c59725bdb559".
<span style="white-space: nowrap;">`data-sp-length`</span> | no       | Number of characters of the text content (excluding HTML tags and other invisible characters). For example: "800". The length will be used to determine how much area the masked characters should approximately cover. Default value is 500 characters.
`data-sp-price`  | yes      | Content price in satoshis, for example: "4000".
