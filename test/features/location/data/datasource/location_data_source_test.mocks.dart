// Mocks generated by Mockito 5.0.16 from annotations
// in the_resident_zombie/test/features/location/data/datasource/location_data_source_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:geolocator/geolocator.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:the_resident_zombie/core/platform/location_info.dart' as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakePosition_0 extends _i1.Fake implements _i2.Position {}

/// A class which mocks [LocalizationInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalizationInfo extends _i1.Mock implements _i3.LocalizationInfo {
  MockLocalizationInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Position> getCurrentPosition() =>
      (super.noSuchMethod(Invocation.method(#getCurrentPosition, []),
              returnValue: Future<_i2.Position>.value(_FakePosition_0()))
          as _i4.Future<_i2.Position>);
  @override
  String toString() => super.toString();
}
