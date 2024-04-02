// Mocks generated by Mockito 5.4.4 from annotations
// in talacare/test/presentation/pages/login_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:ui' as _i7;

import 'package:get_it/get_it.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i9;
import 'package:talacare/domain/entities/user_entity.dart' as _i5;
import 'package:talacare/domain/repositories/auth_repository.dart' as _i4;
import 'package:talacare/domain/usecases/auth_usecase.dart' as _i2;
import 'package:talacare/presentation/providers/auth_provider.dart' as _i6;

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

class _FakeAuthUseCase_0 extends _i1.SmartFake implements _i2.AuthUseCase {
  _FakeAuthUseCase_0(
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

class _FakeAuthRepository_2 extends _i1.SmartFake
    implements _i4.AuthRepository {
  _FakeAuthRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUserEntity_3 extends _i1.SmartFake implements _i5.UserEntity {
  _FakeUserEntity_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthProvider extends _i1.Mock implements _i6.AuthProvider {
  @override
  _i2.AuthUseCase get useCase => (super.noSuchMethod(
        Invocation.getter(#useCase),
        returnValue: _FakeAuthUseCase_0(
          this,
          Invocation.getter(#useCase),
        ),
        returnValueForMissingStub: _FakeAuthUseCase_0(
          this,
          Invocation.getter(#useCase),
        ),
      ) as _i2.AuthUseCase);

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
  void setUser(_i5.UserEntity? user) => super.noSuchMethod(
        Invocation.method(
          #setUser,
          [user],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<void> signInWithGoogle() => (super.noSuchMethod(
        Invocation.method(
          #signInWithGoogle,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> getLocalStoredUser() => (super.noSuchMethod(
        Invocation.method(
          #getLocalStoredUser,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  void maybeDispatchObjectCreation() => super.noSuchMethod(
        Invocation.method(
          #maybeDispatchObjectCreation,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i7.VoidCallback? listener) => super.noSuchMethod(
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
class MockGetIt extends _i1.Mock implements _i8.GetIt {
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
        returnValue: _i9.dummyValue<T>(
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
        returnValueForMissingStub: _i9.dummyValue<T>(
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
        returnValue: _i9.ifNotNull(
              _i9.dummyValueOrNull<T>(
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
        returnValueForMissingStub: _i9.ifNotNull(
              _i9.dummyValueOrNull<T>(
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
        returnValue: _i9.dummyValue<T>(
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
        returnValueForMissingStub: _i9.dummyValue<T>(
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
    _i8.FactoryFunc<T>? factoryFunc, {
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
    _i8.FactoryFuncParam<T, P1, P2>? factoryFunc, {
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
    _i8.FactoryFuncAsync<T>? factoryFunc, {
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
    _i8.FactoryFuncParamAsync<T, P1?, P2?>? factoryFunc, {
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
    _i8.DisposingFunc<T>? dispose,
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
        returnValue: _i9.dummyValue<T>(
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
        returnValueForMissingStub: _i9.dummyValue<T>(
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
    _i8.FactoryFunc<T>? factoryFunc, {
    String? instanceName,
    Iterable<Type>? dependsOn,
    bool? signalsReady,
    _i8.DisposingFunc<T>? dispose,
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
    _i8.FactoryFuncAsync<T>? factoryFunc, {
    String? instanceName,
    Iterable<Type>? dependsOn,
    bool? signalsReady,
    _i8.DisposingFunc<T>? dispose,
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
    _i8.FactoryFunc<T>? factoryFunc, {
    String? instanceName,
    _i8.DisposingFunc<T>? dispose,
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
    _i8.FactoryFuncAsync<T>? factoryFunc, {
    String? instanceName,
    _i8.DisposingFunc<T>? dispose,
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
    void Function(_i8.GetIt)? init,
    String? scopeName,
    _i8.ScopeDisposeFunc? dispose,
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
    _i3.Future<void> Function(_i8.GetIt)? init,
    String? scopeName,
    _i8.ScopeDisposeFunc? dispose,
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

/// A class which mocks [AuthUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthUseCase extends _i1.Mock implements _i2.AuthUseCase {
  @override
  _i4.AuthRepository get authRepository => (super.noSuchMethod(
        Invocation.getter(#authRepository),
        returnValue: _FakeAuthRepository_2(
          this,
          Invocation.getter(#authRepository),
        ),
        returnValueForMissingStub: _FakeAuthRepository_2(
          this,
          Invocation.getter(#authRepository),
        ),
      ) as _i4.AuthRepository);

  @override
  _i3.Future<_i5.UserEntity> signInGoogle() => (super.noSuchMethod(
        Invocation.method(
          #signInGoogle,
          [],
        ),
        returnValue: _i3.Future<_i5.UserEntity>.value(_FakeUserEntity_3(
          this,
          Invocation.method(
            #signInGoogle,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i5.UserEntity>.value(_FakeUserEntity_3(
          this,
          Invocation.method(
            #signInGoogle,
            [],
          ),
        )),
      ) as _i3.Future<_i5.UserEntity>);

  @override
  _i3.Future<_i5.UserEntity?> getLocalStoredUser() => (super.noSuchMethod(
        Invocation.method(
          #getLocalStoredUser,
          [],
        ),
        returnValue: _i3.Future<_i5.UserEntity?>.value(),
        returnValueForMissingStub: _i3.Future<_i5.UserEntity?>.value(),
      ) as _i3.Future<_i5.UserEntity?>);
}
