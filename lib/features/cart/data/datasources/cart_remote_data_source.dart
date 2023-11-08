import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';

import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/error/exception.dart';
import '../models/Cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel?> getCart();
  Future<CartModel?> updateCart(CartModel cartModel);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final NetworkService<Response> _networkService;

  CartRemoteDataSourceImpl(this._networkService);

  @override
  Future<CartModel?> getCart() async {
    return await _handelCartResponse(
        () => _networkService.get(endpoint: EndPoints.getCart));
  }

  @override
  Future<CartModel?> updateCart(CartModel cartModel) async {
    var formData = FormData.fromMap({'items': jsonEncode(cartModel.toJson())});
    return await _handelCartResponse(() =>
        _networkService.post(endpoint: EndPoints.updateCart, data: formData));
  }

  Future<CartModel?> _handelCartResponse(
      Future<Response> Function() function) async {
    try {
      final Response response = await function();
      AppResponseModel<CartModel?> responseModel =
          AppResponseModel<CartModel?>.fromJson(
              response.data,
              (data) =>
                  data.isNotEmpty ? CartModel.fromJson(data.first) : null);
      if (responseModel.error == 1) {
        throw ServerException(message: responseModel.message);
      } else {
        return responseModel.data;
      }
    } catch (e, stackTrace) {
      throw ServerException(message: e.toString(), stackTrace: stackTrace);
    }
  }
}
