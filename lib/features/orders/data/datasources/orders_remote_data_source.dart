import 'package:dio/dio.dart';
import 'package:jahiz/core/data/models/app_response_model.dart';
import 'package:jahiz/core/network/end_points.dart';
import 'package:jahiz/features/orders/data/models/sales_order_details/sales_order_details_model.dart';
import 'package:jahiz/features/orders/data/models/sales_order_model/sales_order_model.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_service.dart';
import '../models/Order_model.dart';

abstract class OrdersRemoteDataSource {
  Future<OrderModel> createOrder(String quotationId, String paymentMethodId);
  Future<void> updatePaymentStatus(
      String orderId,
      String paymentGateway,
      String invoiceId,
      String amount,
      String payerEmail,
      String payerName,
      String currency);

  Future<AppResponseModel<List<SalesOrderModel>>> getSalesOrders([int? page]);

  Future<SalesOrderDetailsModel> getSalesOrderDetails(String orderId);
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final NetworkService<Response> _networkService;

  OrdersRemoteDataSourceImpl(this._networkService);

  @override
  Future<OrderModel> createOrder(
      String quotationId, String paymentMethodId) async {
    final formData = FormData.fromMap({
      'quotation_id': quotationId,
      'payment_method': paymentMethodId,
    });

    try {
      final response = await _networkService.post(
        endpoint: EndPoints.createOrder,
        data: formData,
      );

      final responseModel = AppResponseModel<OrderModel>.fromJson(
        response.data,
        (data) => data.isNotEmpty ? OrderModel.fromJson(data) : null,
      );

      if (responseModel.error == 1) {
        throw ServerException(message: responseModel.message);
      } else {
        return responseModel.data;
      }
    }catch (e, stackTrace) {
      throw ServerException(message: e.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<void> updatePaymentStatus(
    String orderId,
    String paymentGateway,
    String invoiceId,
    String amount,
    String payerEmail,
    String payerName,
    String currency,
  ) async {
    final formData = FormData.fromMap({
      'data': {
        'order_id': orderId,
        'payment_gateway': paymentGateway,
        'invoice_id': invoiceId,
        'amount': amount,
        'payer_email': payerEmail,
        'payer_name': payerName,
        'currency': currency,
      },
    });

    try {
      final response = await _networkService.post(
        endpoint: EndPoints.updatePaymentStatus,
        data: formData,
      );

      final responseModel = AppResponseModel.fromJson(
        response.data,
        (data) => data,
      );

      if (responseModel.error == 1) {
        throw ServerException(message: responseModel.message);
      }
    } catch (e, stackTrace) {
      throw ServerException(message: e.toString(), stackTrace: stackTrace);
    } 
  }

  @override
  Future<AppResponseModel<List<SalesOrderModel>>> getSalesOrders(
      [int? page]) async {
    try {
      final response = await _networkService.get(
        endpoint: EndPoints.getSalesOrders,
        queryParameters: {
          'page': page,
        },
      );

      final responseModel = AppResponseModel<List<SalesOrderModel>>.fromJson(
        response.data,
        (data) => (data as List)
            .map((e) => SalesOrderModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

      if (responseModel.error == 1) {
        throw ServerException(message: responseModel.message);
      } else {
        return responseModel;
      }
    } on ServerException catch (e, stackTrace) {
      throw ServerException(message: e.message ?? '', stackTrace: stackTrace);
    } catch (e, stackTrace) {
      throw ServerException(
          message: 'Unexpected error occurred: $e', stackTrace: stackTrace);
    }
  }

  @override
  Future<SalesOrderDetailsModel> getSalesOrderDetails(String orderId) async {
    try {
      final response = await _networkService.get(
        endpoint: EndPoints.getSalesOrderDetails,
        queryParameters: {
          'sales_order_id': orderId,
        },
      );

      final responseModel = AppResponseModel<SalesOrderDetailsModel>.fromJson(
        response.data,
        (data) => SalesOrderDetailsModel.fromJson(data as Map<String, dynamic>),
      );

      if (responseModel.error == 1) {
        throw ServerException(message: responseModel.message);
      } else {
        return responseModel.data;
      }
    } on ServerException catch (e, stackTrace) {
      throw ServerException(message: e.message ?? '', stackTrace: stackTrace);
    } catch (e, stackTrace) {
      throw ServerException(
          message: 'Unexpected error occurred: $e', stackTrace: stackTrace);
    }
  }
}
