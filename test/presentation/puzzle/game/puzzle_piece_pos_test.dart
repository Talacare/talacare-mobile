import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/puzzle/game/puzzle_piece_pos.dart';

void main() {
  group('PuzzlePiecePos Tests', () {
    testWidgets('PuzzlePiecePos Test', (WidgetTester tester) async {
      const puzzlePiecePos = PuzzlePiecePos(rowPos: 0, colPos: 0);

      expect(puzzlePiecePos.rowPos, 0);
      expect(puzzlePiecePos.colPos, 0);
    });
  });
}
