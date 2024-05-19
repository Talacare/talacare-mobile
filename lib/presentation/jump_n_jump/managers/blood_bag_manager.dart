import 'dart:math';

import 'package:flame/components.dart';
import 'package:talacare/presentation/jump_n_jump/managers/object_manager.dart';
import 'package:talacare/presentation/jump_n_jump/sprites/sprites.dart';
import '../jump_n_jump.dart';
import '../sprites/blood_bag.dart';

class BloodBagManager extends ObjectManager<BloodBag> {
  BloodBagManager()
      : super(1000, 600);

  @override
  BloodBag createItem(Vector2 position) {
    return BloodBag(position: position);
  }
}