import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jahiz/core/network/remote_data_source_mixin.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';

import '../../../../core/data/models/app_response_model.dart';
import '../models/Cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel?> getCart();
  Future<CartModel?> updateCart(CartModel cartModel);
}

class CartRemoteDataSourceImpl
    with RemoteDataSourceMixin
    implements CartRemoteDataSource {
  final NetworkService<Response> _networkService;

  CartRemoteDataSourceImpl(this._networkService);

  @override
  Future<CartModel?> getCart() async {
    final AppResponseModel<CartModel?> responseModel =
        await performRequest<CartModel?>(
            () => _networkService.get(endpoint: EndPoints.getCart),
            _parseCartModel);
    return responseModel.data;
  }

  @override
  Future<CartModel?> updateCart(CartModel cartModel) async {
    // CartModel cart = CartModel(
    //     name: cartModel.name,
    //     transactionDate: cartModel.transactionDate,
    //     shippingAddressName: cartModel.shippingAddressName,
    //     currency: cartModel.currency,
    //     totalQty: cartModel.totalQty,
    //     totalTaxesAndCharges: cartModel.totalTaxesAndCharges,
    //     additionalDiscountPercentage: cartModel.additionalDiscountPercentage,
    //     discountAmount: cartModel.discountAmount,
    //     grandTotal: cartModel.grandTotal,
    //     status: cartModel.status,
    //     couponCode: cartModel.couponCode,
    //     couponCodeDetails: cartModel.couponCodeDetails,
    //     shippingAddressDetails: cartModel.shippingAddressDetails,
    //     items: [cartModel.items.first],

    //     otherChargesCalculation: cartModel.otherChargesCalculation,
    //     paymentGateway: cartModel.paymentGateway);
    // var formData = FormData.fromMap({'items': jsonEncode(cartModel.toJson())});
    var formData = FormData.fromMap({
      'items': jsonEncode('''
{
        "shipping_address_name": "",
        "coupon_code": "",
        "payment_gateway": "Cash on Delivery",
        "items": [
            {
                "Website_item_code": "WEB-ITM-0001",
                "qty": 2,
                "product_options": [
                  {
                   "option_name":"Storage",
                   "option_value":"",
                   "is_price_modifier":""
                  }
                ]
            }
        ]
    }
''')
    });
    print('--------------------------');
    print(formData.fields.first);
    print(cartModel.shippingAddressName == null); // true ?
    print("->${cartModel.shippingAddressName}<-");
    print(cartModel.toJson());
    final AppResponseModel<CartModel?> appResponseModel =
        await performRequest<CartModel?>(
            () => _networkService.post(endpoint: EndPoints.updateCart, data: {
            
                  'items': jsonEncode({
                    "shipping_rule": "Shipping Fees",
                    // "shipping_rule": {"name": "Shipping Fees"},
                    "shipping_address_name":
                        cartModel.shippingAddressName ?? "",
                    "coupon_code": cartModel.couponCode ?? "",
                    "payment_gateway":
                        cartModel.paymentGateway ?? "Cash on Delivery",
                    "items": cartModel.items.map((item) {
                      return {
                        "Website_item_code": item.itemCode,
                        "qty": item.qty,
                        "product_options": item.productOptions.map((option) {
                          return {
                            "option_name": option.productOptionFieldName,
                            "option_value": option.productOptionFieldValue,
                            "is_price_modifier": option.isPriceModifier,
                          };
                        }).toList(),
                      };
                    }).toList(),
                  })
//                   'items': '''
// {
//         "shipping_address_name": "",
//         "coupon_code": "",
//         "payment_gateway": "Cash on Delivery",
//         "items": [
//             {
//                 "Website_item_code": "WEB-ITM-0001",
//                 "qty": 2,
//                 "product_options": [
//                   {
//                    "option_name":"Storage",
//                    "option_value":"",
//                    "is_price_modifier":""
//                   }
//                 ]
//             }
//         ]
//     }

// '''
                }),
            _parseCartModel);
    return appResponseModel.data;
  }

  CartModel? _parseCartModel(data) =>
      data.isNotEmpty ? CartModel.fromJson(data.first) : null;
}
