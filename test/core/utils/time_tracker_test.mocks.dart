// Mocks generated by Mockito 5.4.4 from annotations
// in talacare/test/core/utils/time_tracker_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:ui' as _i3;

import 'package:flutter/widgets.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:talacare/core/utils/time_tracker.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [TimeTracker].
///
/// See the documentation for Mockito's code generation for more information.
class MockTimeTracker extends _i1.Mock implements _i2.TimeTracker {
  MockTimeTracker() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int get accumulatedTime => (super.noSuchMethod(
        Invocation.getter(#accumulatedTime),
        returnValue: 0,
      ) as int);

  @override
  set accumulatedTime(int? _accumulatedTime) => super.noSuchMethod(
        Invocation.setter(
          #accumulatedTime,
          _accumulatedTime,
        ),
        returnValueForMissingStub: null,
      );

  @override
  void start() => super.noSuchMethod(
        Invocation.method(
          #start,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void stop() => super.noSuchMethod(
        Invocation.method(
          #stop,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void didChangeAppLifecycleState(_i3.AppLifecycleState? state) =>
      super.noSuchMethod(
        Invocation.method(
          #didChangeAppLifecycleState,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void startTimer() => super.noSuchMethod(
        Invocation.method(
          #startTimer,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void resetTimer() => super.noSuchMethod(
        Invocation.method(
          #resetTimer,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void stopTimer() => super.noSuchMethod(
        Invocation.method(
          #stopTimer,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void resetDailyTimeIfNeeded() => super.noSuchMethod(
        Invocation.method(
          #resetDailyTimeIfNeeded,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void loadAccumulatedTime() => super.noSuchMethod(
        Invocation.method(
          #loadAccumulatedTime,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void saveAccumulatedTime() => super.noSuchMethod(
        Invocation.method(
          #saveAccumulatedTime,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<bool> didPopRoute() => (super.noSuchMethod(
        Invocation.method(
          #didPopRoute,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<bool> didPushRoute(String? route) => (super.noSuchMethod(
        Invocation.method(
          #didPushRoute,
          [route],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<bool> didPushRouteInformation(
          _i5.RouteInformation? routeInformation) =>
      (super.noSuchMethod(
        Invocation.method(
          #didPushRouteInformation,
          [routeInformation],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  void didChangeMetrics() => super.noSuchMethod(
        Invocation.method(
          #didChangeMetrics,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void didChangeTextScaleFactor() => super.noSuchMethod(
        Invocation.method(
          #didChangeTextScaleFactor,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void didChangePlatformBrightness() => super.noSuchMethod(
        Invocation.method(
          #didChangePlatformBrightness,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void didChangeLocales(List<_i3.Locale>? locales) => super.noSuchMethod(
        Invocation.method(
          #didChangeLocales,
          [locales],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<_i3.AppExitResponse> didRequestAppExit() => (super.noSuchMethod(
        Invocation.method(
          #didRequestAppExit,
          [],
        ),
        returnValue:
            _i4.Future<_i3.AppExitResponse>.value(_i3.AppExitResponse.exit),
      ) as _i4.Future<_i3.AppExitResponse>);

  @override
  void didHaveMemoryPressure() => super.noSuchMethod(
        Invocation.method(
          #didHaveMemoryPressure,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void didChangeAccessibilityFeatures() => super.noSuchMethod(
        Invocation.method(
          #didChangeAccessibilityFeatures,
          [],
        ),
        returnValueForMissingStub: null,
      );
}