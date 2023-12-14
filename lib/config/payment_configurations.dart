
class AppPaymentConfiguration {
  static String defaultApplePay = '''{
    "provider": "apple_pay",
    "data": {
      "merchantIdentifier": "merchant.com.peemz.onparty",
      "displayName": "On Party",
      "merchantCapabilities": [
        "3DS",
        "debit",
        "credit"
      ],
      "supportedNetworks": [
        "amex",
        "visa",
        "masterCard"
      ],
      "countryCode": "FR",
      "currencyCode": "EUR",
      "requiredBillingContactFields": null, 
      "requiredShippingContactFields": null
    }
  }''';

  /// Sample configuration for Google Pay. Contains the same content as the file
  /// under `assets/default_payment_profile_google_pay.json`.
  static String defaultGooglePay = '''{
    "provider": "google_pay",
    "data": {
      "environment": "TEST",
      "apiVersion": 2,
      "apiVersionMinor": 0,
      "allowedPaymentMethods": [
        {
          "type": "CARD",
          "tokenizationSpecification": {
            "type": "PAYMENT_GATEWAY",
            "parameters": {
              "gateway": "example",
              "gatewayMerchantId": "gatewayMerchantId"
            }
          },
          "parameters": {
            "allowedCardNetworks": ["VISA", "MASTERCARD"],
            "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
            "billingAddressRequired": true,
            "billingAddressParameters": {
              "format": "FULL",
              "phoneNumberRequired": true
            }
          }
        }
      ],
      "merchantInfo": {
        "merchantId": "01234567890123456789",
        "merchantName": "Example Merchant Name"
      },
      "transactionInfo": {
        "countryCode": "US",
        "currencyCode": "USD"
      }
    }
  }''';

  static String basicGooglePayIsReadyToPay = '''{
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "allowedPaymentMethods": [
      {
        "type": "CARD",
        "parameters": {
          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          "allowedCardNetworks": ["AMEX", "DISCOVER", "INTERAC", "JCB", "MASTERCARD", "VISA"]
        }
      }
    ]
  }''';

  static String basicGooglePayLoadPaymentData = '''{
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "merchantInfo": {
      "merchantName": "Example Merchant"
    },
    "allowedPaymentMethods": [
      {
        "type": "CARD",
        "parameters": {
          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          "allowedCardNetworks": ["AMEX", "DISCOVER", "INTERAC", "JCB", "MASTERCARD", "VISA"]
        },
        "tokenizationSpecification": {
          "type": "PAYMENT_GATEWAY",
          "parameters": {
            "gateway": "example",
            "gatewayMerchantId": "exampleGatewayMerchantId"
          }
        }
      }
    ],
    "transactionInfo": {
      "totalPriceStatus": "FINAL",
      "totalPrice": "12.34",
      "currencyCode": "USD"
    }
  }''';

  static String invalidGooglePayIsReadyToPay = '''{
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "allowedPaymentMethods": [
      {
        "type": "CARD",
        "parameters": {}
      }
    ]
  }''';

  static String invalidGooglePayLoadPaymentData = '''{
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "merchantInfo": {
      "merchantName": "Example Merchant"
    },
    "allowedPaymentMethods": [
      {
        "type": "CARD",
        "parameters": {
          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          "allowedCardNetworks": ["AMEX", "DISCOVER", "INTERAC", "JCB", "MASTERCARD", "VISA"]
        },
        "tokenizationSpecification": {
          "type": "PAYMENT_GATEWAY",
          "parameters": {
            "gateway": "example",
            "gatewayMerchantId": "exampleGatewayMerchantId"
          }
        }
      }
    ],
    "transactionInfo": {
      "totalPriceStatus": "FINAL",
      "totalPrice": "12.34",
      "currencyCode": "USD"
    }
  }''';

}