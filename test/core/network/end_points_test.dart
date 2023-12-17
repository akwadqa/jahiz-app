import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/network/end_points.dart';

void main() {
  test('All endpoints should be non-null strings', () {
    expect(EndPoints.getHomeBlocks, isA<String>());
    expect(EndPoints.getDetailedProduct, isA<String>());
    expect(EndPoints.checkUserValidation, isA<String>());
    expect(EndPoints.getAppSettings, isA<String>());
    expect(EndPoints.login, isA<String>());
    expect(EndPoints.register, isA<String>());
    expect(EndPoints.getCategories, isA<String>());
    expect(EndPoints.getCities, isA<String>());
    expect(EndPoints.addUpdateAddress, isA<String>());
    expect(EndPoints.getCart, isA<String>());
    expect(EndPoints.updateCart, isA<String>());
    expect(EndPoints.getAddresses, isA<String>());
    expect(EndPoints.paymentMethods, isA<String>());
    expect(EndPoints.placeOrder, isA<String>());
    expect(EndPoints.updatePaymentStatus, isA<String>());
    expect(EndPoints.getSalesOrders, isA<String>());
    expect(EndPoints.getProfileDetails, isA<String>());
    expect(EndPoints.updateProfileDetails, isA<String>());
    expect(EndPoints.getSalesOrderDetails, isA<String>());
    expect(EndPoints.appMessages, isA<String>());
    expect(EndPoints.updateDeviceToken, isA<String>());
  });
}
