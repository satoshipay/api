# Content Items

Before purchase, paid content is displayed on the content provider's website as masked characters, similar to this: `███████`. These block characters are injected by the SatoshiPay widget, which scans the current page for empty content item placeholder tags on initialisation. The placeholder tags are identified by CSS class names starting with `satoshipay-content-item-` and contain details about the content they replace in their `data-` attributes. Example:

```html
<p data-content-url="/satoshipay-content" data-satoshipay-id="558bcdbb1309c59725bdb559" data-content-length="800" data-price="4000" class="satoshipay-content-item-text satoshipay-untouched-placeholder"></p>
```

The data attributes specify where the content can be downloaded from by the SatoshiPay client once the purchase was successfully completed, which specific content item is being masked, its price and its length. See below for a detailed description of the data attributes.

Currently only `satoshipay-content-item-text` for floating text is supported.

The CSS class `satoshipay-untouched-placeholder` styles the placeholder before content is loaded.

## Data Attributes

* **content-url**: (required) Absolute or relative URL to [Content API](README_CONTENT_API.md) endpoint, e.g. `/satoshipay-content`
* **satoshipay-id**: (required) unique identifier for content assigned by SatoshiPay to each product monetized through SatoshiPay. It looks something like this: "558bcdbb1309c59725bdb559"
* **content-length**: (required) number of characters for text content (excluding HTML tags and other invisible characters), example: "800"
* **price**: (required) content price in satoshis, example: "4000"

## CSS Classes
* **satoshipay-content-item-text**: (required for text items) enables SatoshiPay client to identify text content items in the DOM
* **satoshipay-untouched-placeholder**: (optional) places grey content bars before content is loaded.
