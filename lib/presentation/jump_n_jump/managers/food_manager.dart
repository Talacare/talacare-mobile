import 'dart:math';

import 'package:flame/components.dart';
import 'package:talacare/presentation/jump_n_jump/managers/object_manager.dart';
import 'package:talacare/presentation/jump_n_jump/sprites/food.dart';
import 'package:talacare/presentation/jump_n_jump/sprites/sprites.dart';
import '../jump_n_jump.dart';
import '../sprites/blood_bag.dart';

class FoodManager extends ObjectManager<Food> {
  FoodManager()
      : super(650, 350);

  @override
  Food createItem(Vector2 position) {
    return Food(position: position);
  }
}