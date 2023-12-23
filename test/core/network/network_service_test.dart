import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/blocs/selected_language_cubit.dart';
import 'package:jahiz/core/network/end_points.dart';
import 'package:jahiz/core/network/network_service.dart';
import 'package:jahiz/features/auth/application/auth_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockSelectedLanguageCubit extends Mock implements SelectedLanguageCubit {}

class MockAuthCubit extends Mock implements AuthCubit {}

class MockResponse extends Mock implements Response {}

class MockDio extends Mock implements Dio {}

void main() {
  group('DioNetworkService', () {
    late DioNetworkService dioNetworkService;
    late MockSelectedLanguageCubit mockSelectedLanguageCubit;
    late MockAuthCubit mockAuthCubit;
    late Dio mockDio;

    setUp(() {
      mockSelectedLanguageCubit = MockSelectedLanguageCubit();
      mockAuthCubit = MockAuthCubit();
      mockDio = MockDio();
      dioNetworkService = DioNetworkService(
        mockSelectedLanguageCubit,
        mockAuthCubit,
      );
    });

    test('get returns Response on success', () async {
      final mockResponse = MockResponse();
      const endpoint = EndPoints.getHomeBlocks;

      when(() => mockDio.get(endpoint)).thenAnswer((_) async => mockResponse);

      final result = await dioNetworkService.get(endpoint: endpoint);

      verify(() => mockDio.get(
            endpoint,
          )).called(1);
      expect(result, mockResponse);
    });
  });
}
