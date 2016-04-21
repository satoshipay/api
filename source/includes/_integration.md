# Integration

This section describes what needs to be done by the provider in order to integrate paid content items into his website.

## Content API

A Content API needs to be made available by the content provider to allow the SatoshiPay widget to pull content once the item has successfully been paid for.

<aside class="notice">
  Currently only text content needs to be supported. Images and other content types will added soon.
</aside>

### Endpoints

The API needs to provide exactly one endpoint. The route of that endpoint is defined as the **`data-sp-src` attribute** in the [content item tag](#content-items).

In the example below, assuming the content item tags are defined in `https://example.org/index.html`, the `data-sp-src` attribute has been set to `/satoshipay-content` (Another possibility would be the absolute url `https://example.org/satoshipay-content`).

### Request Format

> Example request

```bash
curl https://example.org/satoshipay-content?id=9lgf2XmI&paymentCert=kaTBAIv5j
```

The endpoint will be called with a `GET` request that has the following *query parameters*:

Query Parameter | Description
--------------- | -----------
`id`            | Identifier of the product that's being monetized. See [Content Items](#content-items) for more information on IDs.
`paymentCert`   | Certificate for payment. This parameter should be used by the API to authenticate the call (see [Authentication](#authentication8) below).

### Response Format

> Example response

```
HTTP/1.1 200 OK
Date: Wed, 20 Apr 2016 16:14:25 GMT
Content-Type: text/html; charset=utf-8

<strong>Some premium content</strong>: Lorem ipsum!
```

The Content API needs to return the correct `Content-Type` header for the content that is shipped. For example `Content-Type: text/html; charset=utf-8` for regular HTML.

### Authentication

Authentication is done for each content item using its payment certificate. Currently the provider's Content API only needs to check that the value of the query parameter `paymentCert` matches the `secret` that was specified by the provider when registering the content item using the [Provider API](#provider-api). Proper payment certificate matching will be added in the future.

<aside class="warning">
  Since the payment certificate currently is only a shared secret between the SatoshiPay backend and the Content API, it is strongly advised to use SSL/TLS.
</aside>

## Content Items

> Content item tag example

```html
<p class="satoshipay-content-item-text satoshipay-untouched-placeholder"
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
