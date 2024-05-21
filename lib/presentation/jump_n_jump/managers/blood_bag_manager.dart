import 'package:flame/components.dart';
import 'package:talacare/presentation/jump_n_jump/managers/object_manager.dart';
import 'package:talacare/presentation/jump_n_jump/sprites/sprites.dart';
import '../sprites/blood_bag.dart';

class BloodBagManager extends ObjectManager<BloodBag> {
  BloodBagManager()
      : super(2500, 1900);

  @override
  BloodBag createItem(Vector2 position) {
    return BloodBag(position: position);
  }
}