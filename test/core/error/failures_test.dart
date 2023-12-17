import 'package:jahiz/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OfflineFailure', () {
    test('toString method should return the correct message', () {
      final offlineFailure = OfflineFailure();

      final result = offlineFailure.toString();

      expect(result, 'You\'re offline');
    });

    test('props should be an empty list', () {
      final offlineFailure = OfflineFailure();

      final result = offlineFailure.props;

      expect(result, isEmpty);
    });
  });

  group('ServerFailure', () {
    test('toString method should return the correct message', () {
      const errorMessage = 'This is a server error message';
      final stackTrace = StackTrace.current;
      final serverFailure = ServerFailure(errorMessage, stackTrace);

      final result = serverFailure.toString();

      expect(result, errorMessage);
    });

    test('props should contain message and stack trace', () {
      const errorMessage = 'This is a server error message';
      final stackTrace = StackTrace.current;
      final serverFailure = ServerFailure(errorMessage, stackTrace);

      final result = serverFailure.props;

      expect(result, [errorMessage, stackTrace]);
    });
  });
}
