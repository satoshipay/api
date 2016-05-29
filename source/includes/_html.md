# HTML Tags

Digital goods can be included in a web page by defining special *HTML tags*, which will then be controlled by the SatoshiPay [widget](#sun-of-satoshi). Currently the only supported type of digital goods is [Text/HTML](#text-html). We are working hard on making other types like images, audio and video, downloadable files like PDFs and streams available soon. Follow [@SatoshiPay](https://twitter.com/SatoshiPay) on Twitter to receive updates on new features.

![Goods Placeholder](images/content-mask.png "Goods Placeholder")

Before purchase, a digital good is represented on the merchant's website by a placeholder. These placeholders are injected by the SatoshiPay widget, which scans the current page for placeholder tags on initialization. The placeholder tags are identified by the CSS class name `satoshipay-placeholder` and contain details about the good they replace in their `data` attributes (see the HTML tag example).

The data attributes specify where the good can be downloaded from by the SatoshiPay client once the purchase has been successfully completed, which specific type of good is being replaced, its price and its length or size. See below for a detailed description of the data attributes.

The SatoshiPay stylesheets apply styles to placeholders using the `satoshipay-placeholder` CSS class, so that the items are recognizable while the SatoshiPay widget is being initialized.

## Text/HTML

> Text/HTML Example

```html
<p class="satoshipay-placeholder"
   data-sp-type="text/html"
   data-sp-src="/paid-content/1"
   data-sp-id="558bcdbb1309c59725bdb559"
   data-sp-length="800"
   data-sp-price="4000"
></p>
```

This tag type represents text or HTML source that is loaded into the web page via an AJAX call after payment.

#### Data Attributes

Data Attribute   | Required | Description
---------------- | -------- | -----------
`data-sp-type`   | yes      | Content type, must be "text/html" for this type of digital good.
`data-sp-src`    | yes      | [HTTP endpoint](#http-endpoints) as absolute or relative URL, e.g. `/satoshipay-content`.
`data-sp-id`     | yes      | Unique identifier for the good in SatoshiPay's registry. Consists of a hex string, e.g. "558bcdbb1309c59725bdb559".
<span style="white-space: nowrap;">`data-sp-length`</span> | no       | Number of content characters (excluding HTML tags and other invisible characters). For example: "800". The length will be used to determine how much area the placeholder will cover. Default value is 500 characters.
`data-sp-price`  | yes      | Content price in satoshis, for example: "4000".
