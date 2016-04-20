# Content API

A Content API needs to be made available by the content provider to allow the SatoshiPay widget to pull content once the item has successfully been paid for.

<aside class="notice">
  Currently only text content needs to be supported. Images and other content types will added soon.
</aside>

## Endpoints

The API needs to provide exactly one endpoint. The route of that endpoint is defined as the **`data-sp-src` attribute** in the [content item tag](#content-items).

In the example below, assuming the content item tags are defined in `https://example.org/index.html`, the `data-sp-src` attribute has been set to `/satoshipay-content` (Another possibility would be the absolute url `https://example.org/satoshipay-content`).

## Request Format

> Example request

```bash
curl https://example.org/satoshipay-content?id=9lgf2XmI&paymentCert=kaTBAIv5j
```

The endpoint will be called with a `GET` request that has the following *query parameters*:

Query Parameter | Description
--------------- | -----------
`id`            | Identifier of the product that's being monetized. See [Content Items](#content-items) for more information on IDs.
`paymentCert`   | Certificate for payment. This parameter should be used by the API to authenticate the call (see [Authentication](#authentication8) below).

## Response Format

> Example response

```
HTTP/1.1 200 OK
Date: Wed, 20 Apr 2016 16:14:25 GMT
Content-Type: text/html; charset=utf-8

<strong>Some premium content</strong>: Lorem ipsum!
```

The Content API needs to return the correct `Content-Type` header for the content that is shipped. For example `Content-Type: text/html; charset=utf-8` for regular HTML.

## Authentication

Authentication is done for each content item using its payment certificate. Currently the provider's Content API only needs to check that the value of the query parameter `paymentCert` matches the `secret` that was specified by the provider when registering the content item using the [Provider API](#provider-api). Proper payment certificate matching will be added in the future.

<aside class="warning">
  Since the payment certificate currently is only a shared secret between the SatoshiPay backend and the Content API, it is strongly advised to use SSL/TLS.
</aside>
