// Mocks generated by Mockito 5.4.4 from annotations
// in talacare/test/presentation/providers/auth_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:talacare/domain/entities/user_entity.dart' as _i3;
import 'package:talacare/domain/repositories/auth_repository.dart' as _i2;
import 'package:talacare/domain/usecases/auth_usecase.dart' as _i4;

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

class _FakeAuthRepository_0 extends _i1.SmartFake
    implements _i2.AuthRepository {
  _FakeAuthRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUserEntity_1 extends _i1.SmartFake implements _i3.UserEntity {
  _FakeUserEntity_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthUseCase extends _i1.Mock implements _i4.AuthUseCase {
  @override
  _i2.AuthRepository get authRepository => (super.noSuchMethod(
        Invocation.getter(#authRepository),
        returnValue: _FakeAuthRepository_0(
          this,
          Invocation.getter(#authRepository),
        ),
        returnValueForMissingStub: _FakeAuthRepository_0(
          this,
          Invocation.getter(#authRepository),
        ),
      ) as _i2.AuthRepository);

  @override
  _i5.Future<_i3.UserEntity> signInGoogle() => (super.noSuchMethod(
        Invocation.method(
          #signInGoogle,
          [],
        ),
        returnValue: _i5.Future<_i3.UserEntity>.value(_FakeUserEntity_1(
          this,
          Invocation.method(
            #signInGoogle,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.UserEntity>.value(_FakeUserEntity_1(
          this,
          Invocation.method(
            #signInGoogle,
            [],
          ),
        )),
      ) as _i5.Future<_i3.UserEntity>);

  @override
  _i5.Future<_i3.UserEntity?> getLocalStoredUser() => (super.noSuchMethod(
        Invocation.method(
          #getLocalStoredUser,
          [],
        ),
        returnValue: _i5.Future<_i3.UserEntity?>.value(),
        returnValueForMissingStub: _i5.Future<_i3.UserEntity?>.value(),
      ) as _i5.Future<_i3.UserEntity?>);
}
