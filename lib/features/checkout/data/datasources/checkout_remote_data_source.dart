import 'package:dio/dio.dart';
import 'package:jahiz/core/data/models/app_response_model.dart';
import 'package:jahiz/core/error/exception.dart';
import 'package:jahiz/core/network/end_points.dart';
import 'package:jahiz/core/network/network_service.dart';

abstract class CheckoutRemoteDataSource {
  Future<String> placeOrder(String quotationId, int? isSuccess);
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final NetworkService<Response> _networkService;

  CheckoutRemoteDataSourceImpl(this._networkService);

  @override
  Future<String> placeOrder(String quotationId, int? isSuccess) async {
    final formData = FormData.fromMap({
      'quotation_id': quotationId,
      if (isSuccess != null) 'is_success': isSuccess,
    });

    try {
      final response = await _networkService.post(
        endpoint: EndPoints.placeOrder,
        data: formData,
      );

      final responseModel = AppResponseModel<String>.fromJson(
        response.data,
        (data) => data.isNotEmpty ? data['sales_order'] : null,
      );

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
