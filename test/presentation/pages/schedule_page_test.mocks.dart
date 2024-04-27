// Mocks generated by Mockito 5.4.4 from annotations
// in talacare/test/presentation/pages/schedule_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:ui' as _i8;

import 'package:get_it/get_it.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;
import 'package:talacare/domain/entities/schedule_entity.dart' as _i7;
import 'package:talacare/domain/repositories/schedule_repository.dart' as _i4;
import 'package:talacare/domain/usecases/schedule_usecase.dart' as _i2;
import 'package:talacare/presentation/providers/schedule_provider.dart' as _i5;

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

class _FakeScheduleUseCase_0 extends _i1.SmartFake
    implements _i2.ScheduleUseCase {
  _FakeScheduleUseCase_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFuture_1<T1> extends _i1.SmartFake implements _i3.Future<T1> {
  _FakeFuture_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeScheduleRepository_2 extends _i1.SmartFake
    implements _i4.ScheduleRepository {
  _FakeScheduleRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ScheduleProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockScheduleProvider extends _i1.Mock implements _i5.ScheduleProvider {
  @override
  _i2.ScheduleUseCase get useCase => (super.noSuchMethod(
        Invocation.getter(#useCase),
        returnValue: _FakeScheduleUseCase_0(
          this,
          Invocation.getter(#useCase),
        ),
        returnValueForMissingStub: _FakeScheduleUseCase_0(
          this,
          Invocation.getter(#useCase),
        ),
      ) as _i2.ScheduleUseCase);

  @override
  bool get isLoading => (super.noSuchMethod(
        Invocation.getter(#isLoading),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  bool get isError => (super.noSuchMethod(
        Invocation.getter(#isError),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: _i6.dummyValue<String>(
          this,
          Invocation.getter(#message),
        ),
        returnValueForMissingStub: _i6.dummyValue<String>(
          this,
          Invocation.getter(#message),
        ),
      ) as String);

  @override
  List<Map<String, String>> get schedules => (super.noSuchMethod(
        Invocation.getter(#schedules),
        returnValue: <Map<String, String>>[],
        returnValueForMissingStub: <Map<String, String>>[],
      ) as List<Map<String, String>>);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  void setLoading(bool? isLoading) => super.noSuchMethod(
        Invocation.method(
          #setLoading,
          [isLoading],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void setError(
    bool? isError, [
    String? message,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #setError,
          [
            isError,
            message,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void setMessage(String? message) => super.noSuchMethod(
        Invocation.method(
          #setMessage,
          [message],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void setSchedules(List<Map<String, String>>? schedules) => super.noSuchMethod(
        Invocation.method(
          #setSchedules,
          [schedules],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListenersWithDelay() => super.noSuchMethod(
        Invocation.method(
          #notifyListenersWithDelay,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<void> createSchedule(_i7.ScheduleEntity? schedule) =>
      (super.noSuchMethod(
        Invocation.method(
          #createSchedule,
          [schedule],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> getSchedulesByUserId() => (super.noSuchMethod(
        Invocation.method(
          #getSchedulesByUserId,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> deleteSchedule(String? scheduleId) => (super.noSuchMethod(
        Invocation.method(
          #deleteSchedule,
          [scheduleId],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  void addListener(_i8.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i8.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [GetIt].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetIt extends _i1.Mock implements _i9.GetIt {
  @override
  set onScopeChanged(void Function(bool)? _onScopeChanged) =>
      super.noSuchMethod(
        Invocation.setter(
          #onScopeChanged,
          _onScopeChanged,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get allowReassignment => (super.noSuchMethod(
        Invocation.getter(#allowReassignment),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  set allowReassignment(bool? _allowReassignment) => super.noSuchMethod(
        Invocation.setter(
          #allowReassignment,
          _allowReassignment,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get skipDoubleRegistration => (super.noSuchMethod(
        Invocation.getter(#skipDoubleRegistration),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  set skipDoubleRegistration(bool? _skipDoubleRegistration) =>
      super.noSuchMethod(
        Invocation.setter(
          #skipDoubleRegistration,
          _skipDoubleRegistration,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get allowRegisterMultipleImplementationsOfoneType => (super.noSuchMethod(
        Invocation.getter(#allowRegisterMultipleImplementationsOfoneType),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  set allowRegisterMultipleImplementationsOfoneType(
          bool? _allowRegisterMultipleImplementationsOfoneType) =>
      super.noSuchMethod(
        Invocation.setter(
          #allowRegisterMultipleImplementationsOfoneType,
          _allowRegisterMultipleImplementationsOfoneType,
        ),
        returnValueForMissingStub: null,
      );

  @override
  void enableRegisteringMultipleInstancesOfOneType() => super.noSuchMethod(
        Invocation.method(
          #enableRegisteringMultipleInstancesOfOneType,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  T get<T extends Object>({
    dynamic param1,
    dynamic param2,
    String? instanceName,
    Type? type,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [],
          {
            #param1: param1,
            #param2: param2,
            #instanceName: instanceName,
            #type: type,
          },
        ),
        returnValue: _i6.dummyValue<T>(
          this,
          Invocation.method(
            #get,
            [],
            {
              #param1: param1,
              #param2: param2,
              #instanceName: instanceName,
              #type: type,
            },
          ),
        ),
        returnValueForMissingStub: _i6.dummyValue<T>(
          this,
          Invocation.method(
            #get,
            [],
            {
              #param1: param1,
              #param2: param2,
              #instanceName: instanceName,
              #type: type,
            },
          ),
        ),
      ) as T);

  @override
  _i3.Future<T> getAsync<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
    Type? type,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAsync,
          [],
          {
            #instanceName: instanceName,
            #param1: param1,
            #param2: param2,
            #type: type,
          },
        ),
        returnValue: _i6.ifNotNull(
              _i6.dummyValueOrNull<T>(
                this,
                Invocation.method(
                  #getAsync,
                  [],
                  {
                    #instanceName: instanceName,
                    #param1: param1,
                    #param2: param2,
                    #type: type,
                  },
                ),
              ),
              (T v) => _i3.Future<T>.value(v),
            ) ??
            _FakeFuture_1<T>(
              this,
              Invocation.method(
                #getAsync,
                [],
                {
                  #instanceName: instanceName,
                  #param1: param1,
                  #param2: param2,
                  #type: type,
                },
              ),
            ),
        returnValueForMissingStub: _i6.ifNotNull(
              _i6.dummyValueOrNull<T>(
                this,
                Invocation.method(
                  #getAsync,
                  [],
                  {
                    #instanceName: instanceName,
                    #param1: param1,
                    #param2: param2,
                    #type: type,
                  },
                ),
              ),
              (T v) => _i3.Future<T>.value(v),
            ) ??
            _FakeFuture_1<T>(
              this,
              Invocation.method(
                #getAsync,
                [],
                {
                  #instanceName: instanceName,
                  #param1: param1,
                  #param2: param2,
                  #type: type,
                },
              ),
            ),
      ) as _i3.Future<T>);

  @override
  Iterable<T> getAll<T extends Object>({
    dynamic param1,
    dynamic param2,
    Type? type,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
          {
            #param1: param1,
            #param2: param2,
            #type: type,
          },
        ),
        returnValue: <T>[],
        returnValueForMissingStub: <T>[],
      ) as Iterable<T>);

  @override
  _i3.Future<Iterable<T>> getAllAsync<T extends Object>({
    dynamic param1,
    dynamic param2,
    Type? type,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllAsync,
          [],
          {
            #param1: param1,
            #param2: param2,
            #type: type,
          },
        ),
        returnValue: _i3.Future<Iterable<T>>.value(<T>[]),
        returnValueForMissingStub: _i3.Future<Iterable<T>>.value(<T>[]),
      ) as _i3.Future<Iterable<T>>);

  @override
  T call<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
    Type? type,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {
            #instanceName: instanceName,
            #param1: param1,
            #param2: param2,
            #type: type,
          },
        ),
        returnValue: _i6.dummyValue<T>(
          this,
          Invocation.method(
            #call,
            [],
            {
              #instanceName: instanceName,
              #param1: param1,
              #param2: param2,
              #type: type,
            },
          ),
        ),
        returnValueForMissingStub: _i6.dummyValue<T>(
          this,
          Invocation.method(
            #call,
            [],
            {
              #instanceName: instanceName,
              #param1: param1,
              #param2: param2,
              #type: type,
            },
          ),
        ),
      ) as T);

  @override
  void registerFactory<T extends Object>(
    _i9.FactoryFunc<T>? factoryFunc, {
    String? instanceName,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerFactory,
          [factoryFunc],
          {#instanceName: instanceName},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void registerFactoryParam<T extends Object, P1, P2>(
    _i9.FactoryFuncParam<T, P1, P2>? factoryFunc, {
    String? instanceName,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerFactoryParam,
          [factoryFunc],
          {#instanceName: instanceName},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void registerFactoryAsync<T extends Object>(
    _i9.FactoryFuncAsync<T>? factoryFunc, {
    String? instanceName,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerFactoryAsync,
          [factoryFunc],
          {#instanceName: instanceName},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void registerFactoryParamAsync<T extends Object, P1, P2>(
    _i9.FactoryFuncParamAsync<T, P1?, P2?>? factoryFunc, {
    String? instanceName,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerFactoryParamAsync,
          [factoryFunc],
          {#instanceName: instanceName},
        ),
        returnValueForMissingStub: null,
      );

  @override
  T registerSingleton<T extends Object>(
    T? instance, {
    String? instanceName,
    bool? signalsReady,
    _i9.DisposingFunc<T>? dispose,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerSingleton,
          [instance],
          {
            #instanceName: instanceName,
            #signalsReady: signalsReady,
            #dispose: dispose,
          },
        ),
        returnValue: _i6.dummyValue<T>(
          this,
          Invocation.method(
            #registerSingleton,
            [instance],
            {
              #instanceName: instanceName,
              #signalsReady: signalsReady,
              #dispose: dispose,
            },
          ),
        ),
        returnValueForMissingStub: _i6.dummyValue<T>(
          this,
          Invocation.method(
            #registerSingleton,
            [instance],
            {
              #instanceName: instanceName,
              #signalsReady: signalsReady,
              #dispose: dispose,
            },
          ),
        ),
      ) as T);

  @override
  void registerSingletonWithDependencies<T extends Object>(
    _i9.FactoryFunc<T>? factoryFunc, {
    String? instanceName,
    Iterable<Type>? dependsOn,
    bool? signalsReady,
    _i9.DisposingFunc<T>? dispose,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerSingletonWithDependencies,
          [factoryFunc],
          {
            #instanceName: instanceName,
            #dependsOn: dependsOn,
            #signalsReady: signalsReady,
            #dispose: dispose,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  void registerSingletonAsync<T extends Object>(
    _i9.FactoryFuncAsync<T>? factoryFunc, {
    String? instanceName,
    Iterable<Type>? dependsOn,
    bool? signalsReady,
    _i9.DisposingFunc<T>? dispose,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerSingletonAsync,
          [factoryFunc],
          {
            #instanceName: instanceName,
            #dependsOn: dependsOn,
            #signalsReady: signalsReady,
            #dispose: dispose,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  void registerLazySingleton<T extends Object>(
    _i9.FactoryFunc<T>? factoryFunc, {
    String? instanceName,
    _i9.DisposingFunc<T>? dispose,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerLazySingleton,
          [factoryFunc],
          {
            #instanceName: instanceName,
            #dispose: dispose,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  void registerLazySingletonAsync<T extends Object>(
    _i9.FactoryFuncAsync<T>? factoryFunc, {
    String? instanceName,
    _i9.DisposingFunc<T>? dispose,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerLazySingletonAsync,
          [factoryFunc],
          {
            #instanceName: instanceName,
            #dispose: dispose,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool isRegistered<T extends Object>({
    Object? instance,
    String? instanceName,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #isRegistered,
          [],
          {
            #instance: instance,
            #instanceName: instanceName,
          },
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i3.Future<void> reset({bool? dispose = true}) => (super.noSuchMethod(
        Invocation.method(
          #reset,
          [],
          {#dispose: dispose},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> resetScope({bool? dispose = true}) => (super.noSuchMethod(
        Invocation.method(
          #resetScope,
          [],
          {#dispose: dispose},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  void pushNewScope({
    void Function(_i9.GetIt)? init,
    String? scopeName,
    _i9.ScopeDisposeFunc? dispose,
    bool? isFinal,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #pushNewScope,
          [],
          {
            #init: init,
            #scopeName: scopeName,
            #dispose: dispose,
            #isFinal: isFinal,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<void> pushNewScopeAsync({
    _i3.Future<void> Function(_i9.GetIt)? init,
    String? scopeName,
    _i9.ScopeDisposeFunc? dispose,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pushNewScopeAsync,
          [],
          {
            #init: init,
            #scopeName: scopeName,
            #dispose: dispose,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> popScope() => (super.noSuchMethod(
        Invocation.method(
          #popScope,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<bool> popScopesTill(
    String? name, {
    bool? inclusive = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #popScopesTill,
          [name],
          {#inclusive: inclusive},
        ),
        returnValue: _i3.Future<bool>.value(false),
        returnValueForMissingStub: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);

  @override
  _i3.Future<void> dropScope(String? scopeName) => (super.noSuchMethod(
        Invocation.method(
          #dropScope,
          [scopeName],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  bool hasScope(String? scopeName) => (super.noSuchMethod(
        Invocation.method(
          #hasScope,
          [scopeName],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i3.Future<void> allReady({
    Duration? timeout,
    bool? ignorePendingAsyncCreation = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #allReady,
          [],
          {
            #timeout: timeout,
            #ignorePendingAsyncCreation: ignorePendingAsyncCreation,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> isReady<T extends Object>({
    Object? instance,
    String? instanceName,
    Duration? timeout,
    Object? callee,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #isReady,
          [],
          {
            #instance: instance,
            #instanceName: instanceName,
            #timeout: timeout,
            #callee: callee,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  bool isReadySync<T extends Object>({
    Object? instance,
    String? instanceName,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #isReadySync,
          [],
          {
            #instance: instance,
            #instanceName: instanceName,
          },
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  bool allReadySync([bool? ignorePendingAsyncCreation = false]) =>
      (super.noSuchMethod(
        Invocation.method(
          #allReadySync,
          [ignorePendingAsyncCreation],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  void signalReady(Object? instance) => super.noSuchMethod(
        Invocation.method(
          #signalReady,
          [instance],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [ScheduleUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockScheduleUseCase extends _i1.Mock implements _i2.ScheduleUseCase {
  @override
  _i4.ScheduleRepository get scheduleRepository => (super.noSuchMethod(
        Invocation.getter(#scheduleRepository),
        returnValue: _FakeScheduleRepository_2(
          this,
          Invocation.getter(#scheduleRepository),
        ),
        returnValueForMissingStub: _FakeScheduleRepository_2(
          this,
          Invocation.getter(#scheduleRepository),
        ),
      ) as _i4.ScheduleRepository);

  @override
  _i3.Future<void> createSchedule(_i7.ScheduleEntity? schedule) =>
      (super.noSuchMethod(
        Invocation.method(
          #createSchedule,
          [schedule],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<List<Map<String, String>>> getSchedulesByUserId() =>
      (super.noSuchMethod(
        Invocation.method(
          #getSchedulesByUserId,
          [],
        ),
        returnValue: _i3.Future<List<Map<String, String>>>.value(
            <Map<String, String>>[]),
        returnValueForMissingStub: _i3.Future<List<Map<String, String>>>.value(
            <Map<String, String>>[]),
      ) as _i3.Future<List<Map<String, String>>>);

  @override
  _i3.Future<void> deleteSchedule(String? scheduleId) => (super.noSuchMethod(
        Invocation.method(
          #deleteSchedule,
          [scheduleId],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
