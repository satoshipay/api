# Testnet Sandbox

To faciliate easier development, the SatoshiPay client is available in a sandbox environment which connects to the [Stellar testnet](https://www.stellar.org/developers/guides/concepts/test-net.html). Testnet funds are free. Please note that the testnet may arbitrarily reset. 

To get started, you must register a test account on the URL below:

[dashboard.satoshipay.io/testnet](https://dashboard.satoshipay.io/testnet/)

To get the account upgraded for use, please write an email to api@satoshipay.io from the email you used to create the account. 

## Endpoints

> Testnet API Endpoint

```
https://api.satoshipay.io/testnet/v2/
```

The testnet version follows the same structure and logic as the [Digital Goods API](#digital-goods-api), except it is accessed through different endpoints.

The root endpoint is:

`https://api.satoshipay.io/testnet/v2/`

### Testnet Widget

> Include Testnet Widget

```html
<script src="https://wallet.satoshipay.io/testnet/satoshipay.js"></script>
```

In order to use the testnet version of the [widget](#the-satoshipay-widget) on your web page, call the javascript below:

`https://wallet.satoshipay.io/testnet/satoshipay.js`

## Testnet Funds

To get testnet funds, find a Stellar friendbot which sends free testnet lumens to a testnet account. Solar wallet is free and comes with a friendbot feature. Download the wallet from [solarwallet.io](https://solarwallet.io/).



