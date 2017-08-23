<!--                                                                                       -->
<!-- ATTENTION:                                                                            -->
<!--                                                                                       -->
<!-- This is experimental feature, which is not included in our official API documentation -->
<!--                                                                                       -->

## HTTP 402

The SatoshiPay widget supports HTTP status code 402 (**"Payment Required"**): It sends payment receipt as an `X-Payment-Certificate` request header. This is only done for the digital goods type Text/HTML, because this type is loaded via an AJAX request where custom headers can be added in JavaScript.

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

Alternatively to the GET parameter `paymentReceipt` a request to the endpoint can provide the following header:

Request Header | Description
-------------- | -----------
<span style="white-space: nowrap;">`X-Payment-Certificate: <certificate>`</span> | Payment certificate that proves to the endpoint that payment for the associated good has been successfully completed.
