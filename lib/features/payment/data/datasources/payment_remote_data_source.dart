import 'package:dio/dio.dart';
import 'package:jahiz/core/network/remote_data_source_mixin.dart';
import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';
import '../models/payment_method_model.dart';

abstract class PaymentRemoteDataSource {
  Future<List<PaymentMethodModel>> getPaymentMethods();
}

class PaymentRemoteDataSourceImpl with RemoteDataSourceMixin implements PaymentRemoteDataSource {
  final NetworkService<Response> _networkService;

  PaymentRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    final AppResponseModel<List<PaymentMethodModel>> responseModel =
        await performRequest<List<PaymentMethodModel>>(
            () => _networkService.get(endpoint: EndPoints.paymentMethods),
            (data) => (data as List).map((e) => PaymentMethodModel.fromJson(e)).toList());
    return responseModel.data;
  }
}
