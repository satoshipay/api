# HTML Tags

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

## Data Attributes

Data Attribute   | Required | Description
---------------- | -------- | -----------
`data-sp-src`    | yes      | Absolute or relative URL to the [HTTP endpoint](#http-endpoints), e.g. `/satoshipay-content`.
`data-sp-id`     | yes      | Unique identifier for content assigned by SatoshiPay to each product monetized through SatoshiPay. Consists of a hex string, e.g. "558bcdbb1309c59725bdb559".
<span style="white-space: nowrap;">`data-sp-length`</span> | no       | Number of characters of the text content (excluding HTML tags and other invisible characters). For example: "800". The length will be used to determine how much area the masked characters should approximately cover. Default value is 500 characters.
`data-sp-price`  | yes      | Content price in satoshis, for example: "4000".
