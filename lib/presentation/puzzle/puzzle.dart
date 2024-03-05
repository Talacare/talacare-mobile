import 'package:flutter/material.dart';

class PuzzleWidget extends StatefulWidget {
  final Image image;
  final int rows, cols;
  final VoidCallback onSolved;
  const PuzzleWidget({
    Key? key,
    required this.image,
    required this.rows,
    required this.cols,
    required this.onSolved,
  }) : super(key: key);

  @override
  State<PuzzleWidget> createState() => _PuzzleWidgetState();
}

class _PuzzleWidgetState extends State<PuzzleWidget> {
  late double pieceHeight, pieceWidth;

  List<List<DraggablePuzzlePiece>> pieces = [];

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
            onSwap: _swapPieces,
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
        if (!(shuffledPieces[idx].rowPos == i && shuffledPieces[idx].colPos == j)) {
          isShuffled = true;
        }
      }
    }
    
    return isShuffled;
  }
  
  void _swapPieces(int rowPos, int colPos, int rowPos2, int colPos2) {
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
            onSwap: _swapPieces,
        );
        pieces[rowPos2][colPos2] = DraggablePuzzlePiece(
            image: widget.image,
            rows: widget.rows,
            cols: widget.cols,
            rowId: temp.rowId,
            colId: temp.colId,
            rowPos: rowPos2,
            colPos: colPos2,
            onSwap: _swapPieces,
        );
      }
    });
    
    if (_checkSolved()) {
      widget.onSolved();
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

    _generatePieces();

    return SizedBox(
      height: widget.image.height,
      width: widget.image.width,
      child:  ListView.builder(
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
    );
  }
}

class DraggablePuzzlePiece extends StatefulWidget {
  final Image image;
  final int rows, cols;
  final int rowId, colId;
  final int rowPos, colPos;
  final Function(int, int, int, int) onSwap;
  const DraggablePuzzlePiece({
    Key? key,
    required this.image,
    required this.rows,
    required this.cols,
    required this.rowId,
    required this.colId,
    required this.rowPos,
    required this.colPos,
    required this.onSwap,
  }) : super(key: key);

  @override
  State<DraggablePuzzlePiece> createState() => _DraggablePuzzlePieceState();
}

class _DraggablePuzzlePieceState extends State<DraggablePuzzlePiece> {
  late double pieceHeight, pieceWidth;

  @override
  Widget build(BuildContext context) {
    pieceHeight = widget.image.height! / widget.rows;
    pieceWidth = widget.image.width! / widget.cols;

    return Stack(
      children: [
        Draggable<PuzzlePiecePos>(
          data: PuzzlePiecePos(
            rowPos: widget.rowPos,
            colPos: widget.colPos,
          ),
          feedback: PuzzlePiece(
            image: widget.image,
            rows: widget.rows,
            cols: widget.cols,
            rowId: widget.rowId,
            colId: widget.colId,
          ),
          childWhenDragging: SizedBox(
            height: pieceHeight,
            width: pieceWidth,
          ),
          child: PuzzlePiece(
            image: widget.image,
            rows: widget.rows,
            cols: widget.cols,
            rowId: widget.rowId,
            colId: widget.colId,
          ),
        ),
        DragTarget<PuzzlePiecePos>(
          onAcceptWithDetails: (details) {
            widget.onSwap(widget.rowPos, widget.colPos, details.data.rowPos, details.data.colPos);
          },
          builder: (context, candidates, rejects) => SizedBox(
            height: pieceHeight,
            width: pieceWidth,
          ),
        ),
      ],
    );
  }
}

class PuzzlePiece extends StatefulWidget {
  final Image image;
  final int rows, cols;
  final int rowId, colId;
  const PuzzlePiece({
    Key? key,
    required this.image,
    required this.rows,
    required this.cols,
    required this.rowId,
    required this.colId,
  }) : super(key: key);

  @override
  State<PuzzlePiece> createState() => _PuzzlePieceState();
}

class _PuzzlePieceState extends State<PuzzlePiece> {
  late double pieceHeight, pieceWidth;
  late double offsetX, offsetY;

  @override
  Widget build(BuildContext context) {
    pieceHeight = widget.image.height! / widget.rows;
    pieceWidth = widget.image.width! / widget.cols;

    offsetX = widget.colId.toDouble() * 2 / (widget.cols - 1) - 1;
    offsetY = widget.rowId.toDouble() * 2 / (widget.rows - 1) - 1;

    return SizedBox(
      height: pieceHeight,
      width: pieceWidth,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.black,
          ),
        ),
        child: ClipRect(
          child: FittedBox(
            fit: BoxFit.none,
            alignment: Alignment(offsetX, offsetY),
            child: widget.image,
          ),
        ),
      ),
    );
  }
}

class PuzzlePiecePos {
  final int rowPos, colPos;
  const PuzzlePiecePos({required this.rowPos, required this.colPos});
}