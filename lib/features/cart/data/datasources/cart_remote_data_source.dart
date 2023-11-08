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
    var formData = FormData.fromMap({'items': jsonEncode(cartModel.toJson())});
    final AppResponseModel<CartModel?> appResponseModel =
        await performRequest<CartModel?>(
            () => _networkService.post(
                endpoint: EndPoints.updateCart, data: formData),
            _parseCartModel);
    return appResponseModel.data;
  }

  CartModel? _parseCartModel(data) =>
      data.isNotEmpty ? CartModel.fromJson(data.first) : null;
}
