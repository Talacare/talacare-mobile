import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:talacare/presentation/puzzle/state/complete_state.dart';
import 'package:talacare/presentation/puzzle/game/draggable_puzzle_piece.dart';
import 'package:talacare/presentation/puzzle/game/puzzle_piece_pos.dart';

class PuzzleWidget extends StatefulWidget {
  final Image image;
  final int rows, cols;
  const PuzzleWidget({
    super.key,
    required this.image,
    required this.rows,
    required this.cols,
  });

  @override
  State<PuzzleWidget> createState() => PuzzleWidgetState();
}

@visibleForTesting
class PuzzleWidgetState extends State<PuzzleWidget> {
  late double pieceHeight, pieceWidth;

  List<List<DraggablePuzzlePiece>> pieces = [];

  bool isGameSolved = false;

  void _generatePieces() {
    List<PuzzlePiecePos> shuffledPieces = [];

    for (int i = 0; i < widget.rows; i++) {
      for (int j = 0; j < widget.cols; j++) {
        shuffledPieces.add(
          PuzzlePiecePos(
            rowPos: i,
            colPos: j,
          ),
        );
      }
    }

    while (!_checkShuffled(shuffledPieces)) {
      shuffledPieces.shuffle();
    }

    for (var i = 0; i < widget.rows; i++) {
      List<DraggablePuzzlePiece> tempPieces = [];
      for (var j = 0; j < widget.cols; j++) {
        int idx = i * widget.cols + j;
        tempPieces.add(
          DraggablePuzzlePiece(
            image: widget.image,
            rows: widget.rows,
            cols: widget.cols,
            rowId: shuffledPieces[idx].rowPos,
            colId: shuffledPieces[idx].colPos,
            rowPos: i,
            colPos: j,
            onSwap: swapPieces,
          ),
        );
      }
      pieces.add(tempPieces);
    }
  }

  bool _checkShuffled(List<PuzzlePiecePos> shuffledPieces) {
    bool isShuffled = false;

    for (var i = 0; i < widget.rows; i++) {
      for (var j = 0; j < widget.cols; j++) {
        int idx = i * widget.cols + j;
        if (!(shuffledPieces[idx].rowPos == i &&
            shuffledPieces[idx].colPos == j)) {
          isShuffled = true;
        }
      }
    }

    return isShuffled;
  }

  void swapPieces(int rowPos, int colPos, int rowPos2, int colPos2) {
    final audioPlayer = AudioPlayer();
    audioPlayer.play(AssetSource('audio/puzzle/move_piece.mp3'));
    setState(() {
      if (!(rowPos == rowPos2 && colPos == colPos2)) {
        DraggablePuzzlePiece temp = pieces[rowPos][colPos];
        pieces[rowPos][colPos] = DraggablePuzzlePiece(
          image: widget.image,
          rows: widget.rows,
          cols: widget.cols,
          rowId: pieces[rowPos2][colPos2].rowId,
          colId: pieces[rowPos2][colPos2].colId,
          rowPos: rowPos,
          colPos: colPos,
          onSwap: swapPieces,
        );
        pieces[rowPos2][colPos2] = DraggablePuzzlePiece(
          image: widget.image,
          rows: widget.rows,
          cols: widget.cols,
          rowId: temp.rowId,
          colId: temp.colId,
          rowPos: rowPos2,
          colPos: colPos2,
          onSwap: swapPieces,
        );
      }
    });

    if (_checkSolved()) {
      final finishState = Provider.of<CompleteState>(context, listen: false);
      finishState.value = true;

      setState(() {
        isGameSolved = true;
      });
    }
  }

  _checkSolved() {
    bool isSolved = true;

    for (var i = 0; i < widget.rows; i++) {
      for (var j = 0; j < widget.cols; j++) {
        if (!(pieces[i][j].rowId == i && pieces[i][j].colId == j)) {
          isSolved = false;
        }
      }
    }

    return isSolved;
  }

  @override
  Widget build(BuildContext context) {
    pieceHeight = widget.image.height! / widget.rows;
    pieceWidth = widget.image.width! / widget.cols;

    final isComplete = Provider.of<CompleteState>(context);

    if (isComplete.value) {
      setState(() {
        isGameSolved = true;
      });
    }

    _generatePieces();

    return Stack(
      children: [
        SizedBox(
          height: widget.image.height,
          width: widget.image.width,
          child: ListView.builder(
            itemCount: widget.rows,
            scrollDirection: Axis.vertical,
            itemBuilder: (_, row) => SizedBox(
              height: pieceHeight,
              child: ListView.builder(
                itemCount: widget.cols,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, col) => pieces[row][col],
              ),
            ),
          ),
        ),
        if (isGameSolved)
          Opacity(
            opacity: 0,
            child: SizedBox(
              height: widget.image.height,
              width: widget.image.width,
              child: const ColoredBox(
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
