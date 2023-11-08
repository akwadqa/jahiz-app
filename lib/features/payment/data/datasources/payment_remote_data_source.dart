import 'package:dio/dio.dart';
import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';
import '../models/payment_method_model.dart';

abstract class PaymentRemoteDataSource {
  Future<List<PaymentMethodModel>> getPaymentMethods();
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final NetworkService<Response> _networkService;

  PaymentRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    try {
      final Response response =
          await _networkService.get(endpoint: EndPoints.paymentMethods);
      AppResponseModel<List<PaymentMethodModel>> responseModel =
          AppResponseModel<List<PaymentMethodModel>>.fromJson(
              response.data,
              (data) => (data as List)
                  .map((e) => PaymentMethodModel.fromJson(e))
                  .toList());
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
