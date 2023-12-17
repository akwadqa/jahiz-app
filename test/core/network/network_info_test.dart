import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jahiz/core/network/network_info.dart';
import 'package:mocktail/mocktail.dart';

class MocktailInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  group("NetworkInfoImpl", () {
    late NetworkInfoImpl networkInfo;
    late MocktailInternetConnectionChecker mockConnectionChecker;

    setUp(() {
      mockConnectionChecker = MocktailInternetConnectionChecker();
      networkInfo = NetworkInfoImpl(mockConnectionChecker);
    });
    test(
        'isConnected should return true when InternetConnectionChecker has connection',
        () async {
      when(() => mockConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);

      final result = await networkInfo.isConnected;

      expect(result, true);
      verify(() => mockConnectionChecker.hasConnection).called(1);
    });
  });
}