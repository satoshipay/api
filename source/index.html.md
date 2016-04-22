---
title: SatoshiPay API Reference

language_tabs:
  - shell: cURL
  - javascript: Node

toc_footers:
  - <a href='https://dashboard.satoshipay.io/'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - api
  - integration

search: true
---

# Introduction

The SatoshiPay infrastructure is designed in a way that allows third parties to develop plugins (or apps) that facilitate the management and content provision of the digital goods that are exchanged via SatoshiPay. For this, SatoshiPay provides a public *Digital Goods API*. In order to integrate SatoshiPay as a service, the plugin must do three things:

1. Communicate with the [Digital Goods API](#digital-goods-api) to manage the goods.
2. Insert [Content Items](#content-items) at the places in the website where the content of the digital goods should appear.
3. Provide a [Content API](#content-api) endpoint that delivers the content of a purchased digital good.

The following diagram illustrates how the plugin and SatoshiPay interact with each other:

<p align="center">
  <img src="images/api.svg" width="450px" height="250px" />
</p>

For every provider, the SatoshiPay backend manages a set of abstract digital goods. These abstract goods only contain the price and some meta information, but not the content. The plugin can register and define these goods through the Digital Goods API.

The goods can be included as *content items* on the web page. The location of the content item tag determines the location of the content (and its placeholder, if the content hasn't been paid for yet) on the webpage.

All content items are managed by the SatoshiPay widget that is injected in the web page. When the consumer buys a digital good, the widget handles the payment process by talking to the SatoshiPay backend. At the end of that process, the widget receives a payment certificate which is then used to fetch the actual content of the good from the *Content API*, which has to be provided by the plugin.
