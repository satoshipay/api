# Content API

The Content API is hosted by the content provider and allows the SatoshiPay client to download content via AJAX after it was successfully paid through the WebSocket based *Payment API* (documentation pending).

Currently only text content needs to be supported. Images and other content types will be required soon.

## Request Format

The SatoshiPay client will only send GET requests to the Content API. Request URLs are built using **content URL**, **content ID** and **payment certificate**.

See [Content Items](README_CONTENT_ITEMS.md) for more information on content URLs and IDs.

### Example Request

    GET http://example.org/satoshipay-content?contentId=1&paymentCert=3048024100C918FACF8DEB2DEFD5

## Authentication

Authentication is done for each content item using its payment certificate. Currently the provider's Content API only needs to check that the value of the GET variable `paymentCert` matches the `secret` that was specified by the provider when registering the content item using the [Provider API](README.md). Proper payment certificate matching will need to be added soon.

## Output Format

The Content API needs to return the correct `Content-Type` header for the content that is shipped, for example `Content-Type: text/html; charset=utf-8` for regular HTML.

### Example Response

    HTTP/1.1 200 OK
    Content-Type: text/html; charset=utf-8

    <strong>Some premium content</strong>: Lorem ipsum!

## Error Handling

None required yet.
