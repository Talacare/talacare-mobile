import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/data/models/image_pair.dart';

void main() {
  final stageState = StageState([1, 0, 0, 0], 1, 0, []);

  test('Initialization', () {
    expect(stageState.starList, [1, 0, 0, 0]);
    expect(stageState.stage, 1);
    expect(stageState.score, 0);
    expect(stageState.images, []);
  });
}
