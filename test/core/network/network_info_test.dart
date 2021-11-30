
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:the_resident_zombie/core/platform/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(connectionChecker: mockInternetConnectionChecker);
  });

  group('NetworkInfo:', () {
    test('should forward the call to InternetConnectionChecker.hasConnection',
        () async {
      //arange
      final tHasConnectionFuture = Future.value(true);

      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => tHasConnectionFuture);
      //act{git add}

      final result = networkInfo.isConnected;
      //assert

      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, isA<Future<bool>>());
    });
  });
}