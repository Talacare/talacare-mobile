import 'package:flame/components.dart';
import 'package:talacare/presentation/jump_n_jump/managers/object_manager.dart';
import 'package:talacare/presentation/jump_n_jump/sprites/food.dart';

class FoodManager extends ObjectManager<Food> {
  FoodManager()
      : super(650, 350);

  @override
  Food createItem(Vector2 position) {
    return Food(position: position);
  }
}