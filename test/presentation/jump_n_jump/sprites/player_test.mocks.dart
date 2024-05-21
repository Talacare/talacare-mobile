// Mocks generated by Mockito 5.4.4 from annotations
// in talacare/test/presentation/jump_n_jump/sprites/player_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mockito/mockito.dart' as _i1;
import 'package:talacare/presentation/jump_n_jump/interface/audio_manager_interface.dart'
    as _i2;

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

/// A class which mocks [IAudioManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockAudioManagerForPlayerTest extends _i1.Mock
    implements _i2.IAudioManager {
  MockAudioManagerForPlayerTest() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void playBackgroundMusic(
    String? fileName,
    double? volume,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #playBackgroundMusic,
          [
            fileName,
            volume,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void stopBackgroundMusic() => super.noSuchMethod(
        Invocation.method(
          #stopBackgroundMusic,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void playSoundEffect(
    String? fileName,
    double? volume,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #playSoundEffect,
          [
            fileName,
            volume,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void pauseBackgroundMusic() => super.noSuchMethod(
        Invocation.method(
          #pauseBackgroundMusic,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void resumeBackgroundMusic() => super.noSuchMethod(
        Invocation.method(
          #resumeBackgroundMusic,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
