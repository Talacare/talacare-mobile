// Mocks generated by Mockito 5.4.4 from annotations
// in talacare/test/presentation/jump_n_jump/managers/game_manager_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i18;
import 'dart:ui' as _i7;

import 'package:flame/cache.dart' as _i9;
import 'package:flame/collisions.dart' as _i13;
import 'package:flame/components.dart' as _i14;
import 'package:flame/game.dart' as _i6;
import 'package:flame/input.dart' as _i20;
import 'package:flame/src/components/component.dart' as _i19;
import 'package:flame/src/components/component_set.dart' as _i8;
import 'package:flame/src/components/position_type.dart' as _i17;
import 'package:flame/src/game/game_render_box.dart' as _i11;
import 'package:flame/src/game/overlay_manager.dart' as _i10;
import 'package:flutter/material.dart' as _i12;
import 'package:flutter/rendering.dart' as _i21;
import 'package:flutter/services.dart' as _i22;
import 'package:mockito/mockito.dart' as _i1;
import 'package:talacare/presentation/jump_n_jump/interface/audio_manager_interface.dart'
    as _i16;
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart' as _i15;
import 'package:talacare/presentation/jump_n_jump/managers/game_manager.dart'
    as _i2;
import 'package:talacare/presentation/jump_n_jump/managers/managers.dart'
    as _i4;
import 'package:talacare/presentation/jump_n_jump/sprites/sprites.dart' as _i5;
import 'package:talacare/presentation/jump_n_jump/world.dart' as _i3;

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

class _FakeGameManager_0 extends _i1.SmartFake implements _i2.GameManager {
  _FakeGameManager_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWorldGame_1 extends _i1.SmartFake implements _i3.WorldGame {
  _FakeWorldGame_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePlatformManager_2 extends _i1.SmartFake
    implements _i4.PlatformManager {
  _FakePlatformManager_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBloodBagManager_3 extends _i1.SmartFake
    implements _i4.BloodBagManager {
  _FakeBloodBagManager_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePlayer_4 extends _i1.SmartFake implements _i5.Player {
  _FakePlayer_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCamera_5 extends _i1.SmartFake implements _i6.Camera {
  _FakeCamera_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeVector2_6 extends _i1.SmartFake implements _i6.Vector2 {
  _FakeVector2_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeProjector_7 extends _i1.SmartFake implements _i6.Projector {
  _FakeProjector_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeColor_8 extends _i1.SmartFake implements _i7.Color {
  _FakeColor_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeComponentSet_9 extends _i1.SmartFake implements _i8.ComponentSet {
  _FakeComponentSet_9(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePaint_10 extends _i1.SmartFake implements _i7.Paint {
  _FakePaint_10(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTextPaint_11 extends _i1.SmartFake implements _i6.TextPaint {
  _FakeTextPaint_11(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeImages_12 extends _i1.SmartFake implements _i9.Images {
  _FakeImages_12(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAssetsCache_13 extends _i1.SmartFake implements _i9.AssetsCache {
  _FakeAssetsCache_13(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOverlayManager_14 extends _i1.SmartFake
    implements _i10.OverlayManager {
  _FakeOverlayManager_14(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGameRenderBox_15 extends _i1.SmartFake
    implements _i11.GameRenderBox {
  _FakeGameRenderBox_15(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString(
          {_i12.DiagnosticLevel? minLevel = _i12.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeMouseCursor_16 extends _i1.SmartFake implements _i12.MouseCursor {
  _FakeMouseCursor_16(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString(
          {_i12.DiagnosticLevel? minLevel = _i12.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeCollisionDetection_17<T extends _i13.Hitbox<T>> extends _i1.SmartFake
    implements _i13.CollisionDetection<T> {
  _FakeCollisionDetection_17(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSprite_18 extends _i1.SmartFake implements _i14.Sprite {
  _FakeSprite_18(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSpriteAnimation_19 extends _i1.SmartFake
    implements _i14.SpriteAnimation {
  _FakeSpriteAnimation_19(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [JumpNJump].
///
/// See the documentation for Mockito's code generation for more information.
class MockJumpNJump extends _i1.Mock implements _i15.JumpNJump {
  MockJumpNJump() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set audioManager(_i16.IAudioManager? _audioManager) => super.noSuchMethod(
        Invocation.setter(
          #audioManager,
          _audioManager,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.GameManager get gameManager => (super.noSuchMethod(
        Invocation.getter(#gameManager),
        returnValue: _FakeGameManager_0(
          this,
          Invocation.getter(#gameManager),
        ),
      ) as _i2.GameManager);

  @override
  set gameManager(_i2.GameManager? _gameManager) => super.noSuchMethod(
        Invocation.setter(
          #gameManager,
          _gameManager,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.WorldGame get world => (super.noSuchMethod(
        Invocation.getter(#world),
        returnValue: _FakeWorldGame_1(
          this,
          Invocation.getter(#world),
        ),
      ) as _i3.WorldGame);

  @override
  _i4.PlatformManager get platformManager => (super.noSuchMethod(
        Invocation.getter(#platformManager),
        returnValue: _FakePlatformManager_2(
          this,
          Invocation.getter(#platformManager),
        ),
      ) as _i4.PlatformManager);

  @override
  set platformManager(_i4.PlatformManager? _platformManager) =>
      super.noSuchMethod(
        Invocation.setter(
          #platformManager,
          _platformManager,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.BloodBagManager get bloodBagManager => (super.noSuchMethod(
        Invocation.getter(#bloodBagManager),
        returnValue: _FakeBloodBagManager_3(
          this,
          Invocation.getter(#bloodBagManager),
        ),
      ) as _i4.BloodBagManager);

  @override
  set bloodBagManager(_i4.BloodBagManager? _bloodBagManager) =>
      super.noSuchMethod(
        Invocation.setter(
          #bloodBagManager,
          _bloodBagManager,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.Player get dash => (super.noSuchMethod(
        Invocation.getter(#dash),
        returnValue: _FakePlayer_4(
          this,
          Invocation.getter(#dash),
        ),
      ) as _i5.Player);

  @override
  set dash(_i5.Player? _dash) => super.noSuchMethod(
        Invocation.setter(
          #dash,
          _dash,
        ),
        returnValueForMissingStub: null,
      );

  @override
  int get screenBufferSpace => (super.noSuchMethod(
        Invocation.getter(#screenBufferSpace),
        returnValue: 0,
      ) as int);

  @override
  set screenBufferSpace(int? _screenBufferSpace) => super.noSuchMethod(
        Invocation.setter(
          #screenBufferSpace,
          _screenBufferSpace,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Camera get camera => (super.noSuchMethod(
        Invocation.getter(#camera),
        returnValue: _FakeCamera_5(
          this,
          Invocation.getter(#camera),
        ),
      ) as _i6.Camera);

  @override
  _i6.Vector2 get size => (super.noSuchMethod(
        Invocation.getter(#size),
        returnValue: _FakeVector2_6(
          this,
          Invocation.getter(#size),
        ),
      ) as _i6.Vector2);

  @override
  _i6.Projector get viewportProjector => (super.noSuchMethod(
        Invocation.getter(#viewportProjector),
        returnValue: _FakeProjector_7(
          this,
          Invocation.getter(#viewportProjector),
        ),
      ) as _i6.Projector);

  @override
  _i6.Projector get projector => (super.noSuchMethod(
        Invocation.getter(#projector),
        returnValue: _FakeProjector_7(
          this,
          Invocation.getter(#projector),
        ),
      ) as _i6.Projector);

  @override
  bool get debugMode => (super.noSuchMethod(
        Invocation.getter(#debugMode),
        returnValue: false,
      ) as bool);

  @override
  set debugMode(bool? _debugMode) => super.noSuchMethod(
        Invocation.setter(
          #debugMode,
          _debugMode,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i7.Color get debugColor => (super.noSuchMethod(
        Invocation.getter(#debugColor),
        returnValue: _FakeColor_8(
          this,
          Invocation.getter(#debugColor),
        ),
      ) as _i7.Color);

  @override
  set debugColor(_i7.Color? _debugColor) => super.noSuchMethod(
        Invocation.setter(
          #debugColor,
          _debugColor,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i17.PositionType get positionType => (super.noSuchMethod(
        Invocation.getter(#positionType),
        returnValue: _i17.PositionType.game,
      ) as _i17.PositionType);

  @override
  set positionType(_i17.PositionType? _positionType) => super.noSuchMethod(
        Invocation.setter(
          #positionType,
          _positionType,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get isLoading => (super.noSuchMethod(
        Invocation.getter(#isLoading),
        returnValue: false,
      ) as bool);

  @override
  bool get isLoaded => (super.noSuchMethod(
        Invocation.getter(#isLoaded),
        returnValue: false,
      ) as bool);

  @override
  bool get isMounted => (super.noSuchMethod(
        Invocation.getter(#isMounted),
        returnValue: false,
      ) as bool);

  @override
  bool get isRemoving => (super.noSuchMethod(
        Invocation.getter(#isRemoving),
        returnValue: false,
      ) as bool);

  @override
  _i18.Future<void> get loaded => (super.noSuchMethod(
        Invocation.getter(#loaded),
        returnValue: _i18.Future<void>.value(),
      ) as _i18.Future<void>);

  @override
  _i18.Future<void> get mounted => (super.noSuchMethod(
        Invocation.getter(#mounted),
        returnValue: _i18.Future<void>.value(),
      ) as _i18.Future<void>);

  @override
  set parent(_i19.Component? newParent) => super.noSuchMethod(
        Invocation.setter(
          #parent,
          newParent,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i8.ComponentSet get children => (super.noSuchMethod(
        Invocation.getter(#children),
        returnValue: _FakeComponentSet_9(
          this,
          Invocation.getter(#children),
        ),
      ) as _i8.ComponentSet);

  @override
  bool get hasChildren => (super.noSuchMethod(
        Invocation.getter(#hasChildren),
        returnValue: false,
      ) as bool);

  @override
  int get priority => (super.noSuchMethod(
        Invocation.getter(#priority),
        returnValue: 0,
      ) as int);

  @override
  set priority(int? newPriority) => super.noSuchMethod(
        Invocation.setter(
          #priority,
          newPriority,
        ),
        returnValueForMissingStub: null,
      );

  @override
  get lifecycle => throw UnsupportedError(
      r'"lifecycle" cannot be used without a mockito fallback generator.');

  @override
  bool get hasPendingLifecycleEvents => (super.noSuchMethod(
        Invocation.getter(#hasPendingLifecycleEvents),
        returnValue: false,
      ) as bool);

  @override
  _i7.Paint get debugPaint => (super.noSuchMethod(
        Invocation.getter(#debugPaint),
        returnValue: _FakePaint_10(
          this,
          Invocation.getter(#debugPaint),
        ),
      ) as _i7.Paint);

  @override
  _i6.TextPaint get debugTextPaint => (super.noSuchMethod(
        Invocation.getter(#debugTextPaint),
        returnValue: _FakeTextPaint_11(
          this,
          Invocation.getter(#debugTextPaint),
        ),
      ) as _i6.TextPaint);

  @override
  _i9.Images get images => (super.noSuchMethod(
        Invocation.getter(#images),
        returnValue: _FakeImages_12(
          this,
          Invocation.getter(#images),
        ),
      ) as _i9.Images);

  @override
  set images(_i9.Images? _images) => super.noSuchMethod(
        Invocation.setter(
          #images,
          _images,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i9.AssetsCache get assets => (super.noSuchMethod(
        Invocation.getter(#assets),
        returnValue: _FakeAssetsCache_13(
          this,
          Invocation.getter(#assets),
        ),
      ) as _i9.AssetsCache);

  @override
  set assets(_i9.AssetsCache? _assets) => super.noSuchMethod(
        Invocation.setter(
          #assets,
          _assets,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set projector(_i6.Projector? _projector) => super.noSuchMethod(
        Invocation.setter(
          #projector,
          _projector,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set viewportProjector(_i6.Projector? _viewportProjector) =>
      super.noSuchMethod(
        Invocation.setter(
          #viewportProjector,
          _viewportProjector,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set pauseEngineFn(_i7.VoidCallback? _pauseEngineFn) => super.noSuchMethod(
        Invocation.setter(
          #pauseEngineFn,
          _pauseEngineFn,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set resumeEngineFn(_i7.VoidCallback? _resumeEngineFn) => super.noSuchMethod(
        Invocation.setter(
          #resumeEngineFn,
          _resumeEngineFn,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i10.OverlayManager get overlays => (super.noSuchMethod(
        Invocation.getter(#overlays),
        returnValue: _FakeOverlayManager_14(
          this,
          Invocation.getter(#overlays),
        ),
      ) as _i10.OverlayManager);

  @override
  List<_i7.VoidCallback> get gameStateListeners => (super.noSuchMethod(
        Invocation.getter(#gameStateListeners),
        returnValue: <_i7.VoidCallback>[],
      ) as List<_i7.VoidCallback>);

  @override
  _i11.GameRenderBox get renderBox => (super.noSuchMethod(
        Invocation.getter(#renderBox),
        returnValue: _FakeGameRenderBox_15(
          this,
          Invocation.getter(#renderBox),
        ),
      ) as _i11.GameRenderBox);

  @override
  bool get isAttached => (super.noSuchMethod(
        Invocation.getter(#isAttached),
        returnValue: false,
      ) as bool);

  @override
  _i6.Vector2 get canvasSize => (super.noSuchMethod(
        Invocation.getter(#canvasSize),
        returnValue: _FakeVector2_6(
          this,
          Invocation.getter(#canvasSize),
        ),
      ) as _i6.Vector2);

  @override
  bool get hasLayout => (super.noSuchMethod(
        Invocation.getter(#hasLayout),
        returnValue: false,
      ) as bool);

  @override
  bool get paused => (super.noSuchMethod(
        Invocation.getter(#paused),
        returnValue: false,
      ) as bool);

  @override
  set paused(bool? value) => super.noSuchMethod(
        Invocation.setter(
          #paused,
          value,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i12.MouseCursor get mouseCursor => (super.noSuchMethod(
        Invocation.getter(#mouseCursor),
        returnValue: _FakeMouseCursor_16(
          this,
          Invocation.getter(#mouseCursor),
        ),
      ) as _i12.MouseCursor);

  @override
  set mouseCursor(_i12.MouseCursor? value) => super.noSuchMethod(
        Invocation.setter(
          #mouseCursor,
          value,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i13.CollisionDetection<_i13.ShapeHitbox> get collisionDetection =>
      (super.noSuchMethod(
        Invocation.getter(#collisionDetection),
        returnValue: _FakeCollisionDetection_17<_i13.ShapeHitbox>(
          this,
          Invocation.getter(#collisionDetection),
        ),
      ) as _i13.CollisionDetection<_i13.ShapeHitbox>);

  @override
  set collisionDetection(_i13.CollisionDetection<_i13.ShapeHitbox>? cd) =>
      super.noSuchMethod(
        Invocation.setter(
          #collisionDetection,
          cd,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i18.Future<void> onLoad() => (super.noSuchMethod(
        Invocation.method(
          #onLoad,
          [],
        ),
        returnValue: _i18.Future<void>.value(),
        returnValueForMissingStub: _i18.Future<void>.value(),
      ) as _i18.Future<void>);

  @override
  void update(double? dt) => super.noSuchMethod(
        Invocation.method(
          #update,
          [dt],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void initializeGame() => super.noSuchMethod(
        Invocation.method(
          #initializeGame,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i7.Color backgroundColor() => (super.noSuchMethod(
        Invocation.method(
          #backgroundColor,
          [],
        ),
        returnValue: _FakeColor_8(
          this,
          Invocation.method(
            #backgroundColor,
            [],
          ),
        ),
      ) as _i7.Color);

  @override
  void startGame() => super.noSuchMethod(
        Invocation.method(
          #startGame,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void reset() => super.noSuchMethod(
        Invocation.method(
          #reset,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onLose() => super.noSuchMethod(
        Invocation.method(
          #onLose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onRestartGame() => super.noSuchMethod(
        Invocation.method(
          #onRestartGame,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onBackToMenu() => super.noSuchMethod(
        Invocation.method(
          #onBackToMenu,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void render(_i7.Canvas? canvas) => super.noSuchMethod(
        Invocation.method(
          #render,
          [canvas],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void renderTree(_i7.Canvas? canvas) => super.noSuchMethod(
        Invocation.method(
          #renderTree,
          [canvas],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void updateTree(double? dt) => super.noSuchMethod(
        Invocation.method(
          #updateTree,
          [dt],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onGameResize(_i6.Vector2? canvasSize) => super.noSuchMethod(
        Invocation.method(
          #onGameResize,
          [canvasSize],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i18.Future<void> ready() => (super.noSuchMethod(
        Invocation.method(
          #ready,
          [],
        ),
        returnValue: _i18.Future<void>.value(),
        returnValueForMissingStub: _i18.Future<void>.value(),
      ) as _i18.Future<void>);

  @override
  bool containsLocalPoint(_i6.Vector2? p) => (super.noSuchMethod(
        Invocation.method(
          #containsLocalPoint,
          [p],
        ),
        returnValue: false,
      ) as bool);

  @override
  double currentTime() => (super.noSuchMethod(
        Invocation.method(
          #currentTime,
          [],
        ),
        returnValue: 0.0,
      ) as double);

  @override
  _i8.ComponentSet createComponentSet() => (super.noSuchMethod(
        Invocation.method(
          #createComponentSet,
          [],
        ),
        returnValue: _FakeComponentSet_9(
          this,
          Invocation.method(
            #createComponentSet,
            [],
          ),
        ),
      ) as _i8.ComponentSet);

  @override
  Iterable<_i19.Component> ancestors({bool? includeSelf = false}) =>
      (super.noSuchMethod(
        Invocation.method(
          #ancestors,
          [],
          {#includeSelf: includeSelf},
        ),
        returnValue: <_i19.Component>[],
      ) as Iterable<_i19.Component>);

  @override
  Iterable<_i19.Component> descendants({
    bool? includeSelf = false,
    bool? reversed = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #descendants,
          [],
          {
            #includeSelf: includeSelf,
            #reversed: reversed,
          },
        ),
        returnValue: <_i19.Component>[],
      ) as Iterable<_i19.Component>);

  @override
  bool propagateToChildren<T extends _i19.Component>(
    bool Function(T)? handler, {
    bool? includeSelf = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #propagateToChildren,
          [handler],
          {#includeSelf: includeSelf},
        ),
        returnValue: false,
      ) as bool);

  @override
  bool contains(_i19.Component? c) => (super.noSuchMethod(
        Invocation.method(
          #contains,
          [c],
        ),
        returnValue: false,
      ) as bool);

  @override
  void onMount() => super.noSuchMethod(
        Invocation.method(
          #onMount,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onRemove() => super.noSuchMethod(
        Invocation.method(
          #onRemove,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i18.Future<void>? add(_i19.Component? component) => (super.noSuchMethod(
        Invocation.method(
          #add,
          [component],
        ),
        returnValueForMissingStub: _i18.Future<void>.value(),
      ) as _i18.Future<void>?);

  @override
  _i18.Future<void> addAll(Iterable<_i19.Component>? components) =>
      (super.noSuchMethod(
        Invocation.method(
          #addAll,
          [components],
        ),
        returnValue: _i18.Future<void>.value(),
        returnValueForMissingStub: _i18.Future<void>.value(),
      ) as _i18.Future<void>);

  @override
  _i18.Future<void>? addToParent(_i19.Component? parent) => (super.noSuchMethod(
        Invocation.method(
          #addToParent,
          [parent],
        ),
        returnValueForMissingStub: _i18.Future<void>.value(),
      ) as _i18.Future<void>?);

  @override
  void remove(_i19.Component? component) => super.noSuchMethod(
        Invocation.method(
          #remove,
          [component],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeAll(Iterable<_i19.Component>? components) => super.noSuchMethod(
        Invocation.method(
          #removeAll,
          [components],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeFromParent() => super.noSuchMethod(
        Invocation.method(
          #removeFromParent,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void changeParent(_i19.Component? newParent) => super.noSuchMethod(
        Invocation.method(
          #changeParent,
          [newParent],
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool containsPoint(_i6.Vector2? point) => (super.noSuchMethod(
        Invocation.method(
          #containsPoint,
          [point],
        ),
        returnValue: false,
      ) as bool);

  @override
  Iterable<_i19.Component> componentsAtPoint(
    _i6.Vector2? point, [
    List<_i6.Vector2>? nestedPoints,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #componentsAtPoint,
          [
            point,
            nestedPoints,
          ],
        ),
        returnValue: <_i19.Component>[],
      ) as Iterable<_i19.Component>);

  @override
  void changePriorityWithoutResorting(int? priority) => super.noSuchMethod(
        Invocation.method(
          #changePriorityWithoutResorting,
          [priority],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void reorderChildren() => super.noSuchMethod(
        Invocation.method(
          #reorderChildren,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void processPendingLifecycleEvents() => super.noSuchMethod(
        Invocation.method(
          #processPendingLifecycleEvents,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void handleResize(_i6.Vector2? size) => super.noSuchMethod(
        Invocation.method(
          #handleResize,
          [size],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void setMounted() => super.noSuchMethod(
        Invocation.method(
          #setMounted,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void renderDebugMode(_i7.Canvas? canvas) => super.noSuchMethod(
        Invocation.method(
          #renderDebugMode,
          [canvas],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Vector2 eventPosition(_i20.PositionInfo<dynamic>? info) =>
      (super.noSuchMethod(
        Invocation.method(
          #eventPosition,
          [info],
        ),
        returnValue: _FakeVector2_6(
          this,
          Invocation.method(
            #eventPosition,
            [info],
          ),
        ),
      ) as _i6.Vector2);

  @override
  _i18.Future<void>? toBeLoaded() => (super.noSuchMethod(
        Invocation.method(
          #toBeLoaded,
          [],
        ),
        returnValueForMissingStub: _i18.Future<void>.value(),
      ) as _i18.Future<void>?);

  @override
  void assertHasLayout() => super.noSuchMethod(
        Invocation.method(
          #assertHasLayout,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void lifecycleStateChange(_i7.AppLifecycleState? state) => super.noSuchMethod(
        Invocation.method(
          #lifecycleStateChange,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void attach(
    _i21.PipelineOwner? owner,
    _i11.GameRenderBox? gameRenderBox,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #attach,
          [
            owner,
            gameRenderBox,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onAttach() => super.noSuchMethod(
        Invocation.method(
          #onAttach,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void detach() => super.noSuchMethod(
        Invocation.method(
          #detach,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onDetach() => super.noSuchMethod(
        Invocation.method(
          #onDetach,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Vector2 convertGlobalToLocalCoordinate(_i6.Vector2? point) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertGlobalToLocalCoordinate,
          [point],
        ),
        returnValue: _FakeVector2_6(
          this,
          Invocation.method(
            #convertGlobalToLocalCoordinate,
            [point],
          ),
        ),
      ) as _i6.Vector2);

  @override
  _i6.Vector2 convertLocalToGlobalCoordinate(_i6.Vector2? point) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertLocalToGlobalCoordinate,
          [point],
        ),
        returnValue: _FakeVector2_6(
          this,
          Invocation.method(
            #convertLocalToGlobalCoordinate,
            [point],
          ),
        ),
      ) as _i6.Vector2);

  @override
  _i18.Future<_i14.Sprite> loadSprite(
    String? path, {
    _i6.Vector2? srcSize,
    _i6.Vector2? srcPosition,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadSprite,
          [path],
          {
            #srcSize: srcSize,
            #srcPosition: srcPosition,
          },
        ),
        returnValue: _i18.Future<_i14.Sprite>.value(_FakeSprite_18(
          this,
          Invocation.method(
            #loadSprite,
            [path],
            {
              #srcSize: srcSize,
              #srcPosition: srcPosition,
            },
          ),
        )),
      ) as _i18.Future<_i14.Sprite>);

  @override
  _i18.Future<_i14.SpriteAnimation> loadSpriteAnimation(
    String? path,
    _i14.SpriteAnimationData? data,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadSpriteAnimation,
          [
            path,
            data,
          ],
        ),
        returnValue:
            _i18.Future<_i14.SpriteAnimation>.value(_FakeSpriteAnimation_19(
          this,
          Invocation.method(
            #loadSpriteAnimation,
            [
              path,
              data,
            ],
          ),
        )),
      ) as _i18.Future<_i14.SpriteAnimation>);

  @override
  void pauseEngine() => super.noSuchMethod(
        Invocation.method(
          #pauseEngine,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void resumeEngine() => super.noSuchMethod(
        Invocation.method(
          #resumeEngine,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addGameStateListener(_i7.VoidCallback? callback) => super.noSuchMethod(
        Invocation.method(
          #addGameStateListener,
          [callback],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeGameStateListener(_i7.VoidCallback? callback) =>
      super.noSuchMethod(
        Invocation.method(
          #removeGameStateListener,
          [callback],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void refreshWidget() => super.noSuchMethod(
        Invocation.method(
          #refreshWidget,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i12.KeyEventResult onKeyEvent(
    _i12.RawKeyEvent? event,
    Set<_i22.LogicalKeyboardKey>? keysPressed,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #onKeyEvent,
          [
            event,
            keysPressed,
          ],
        ),
        returnValue: _i12.KeyEventResult.handled,
      ) as _i12.KeyEventResult);
}