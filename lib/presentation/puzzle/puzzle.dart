import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  final String puzzleImg = 'assets/images/perawat.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 50),
              child: PuzzleWidget(
                image: Image.asset(
                  puzzleImg,
                  height: 300,
                  width: 300,
                ),
                rows: 3,
                cols: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PuzzleWidget extends StatefulWidget {
  final Image image;
  final int rows, cols;
  const PuzzleWidget({Key? key, required this.image, required this.rows, required this.cols}) : super(key: key);

  @override
  State<PuzzleWidget> createState() => _PuzzleWidgetState();
}

class _PuzzleWidgetState extends State<PuzzleWidget> {
  late double pieceHeight, pieceWidth;

  List<List<PuzzlePiece>> pieces = [];

  void generatePieces() {
    List<PuzzlePiece> shuffledPieces = [];

    for(int i = 0; i < widget.rows; i++) {
      for(int j = 0; j < widget.cols; j++) {
        shuffledPieces.add(PuzzlePiece(
            image: widget.image,
            rows: widget.rows,
            cols: widget.cols,
            rowId: i,
            colId: j,
        ));
      }
    }

    shuffledPieces.shuffle();

    for(var i = 0; i < widget.rows; i++) {
      List<PuzzlePiece> tempPieces = [];
      for(var j = 0; j < widget.cols; j++) {
        int idx = i * widget.cols + j;
        tempPieces.add(shuffledPieces[idx]);
      }
      pieces.add(tempPieces);
    }
  }

  @override
  Widget build(BuildContext context) {
    pieceHeight = widget.image.height! / widget.rows;
    pieceWidth = widget.image.width! / widget.cols;

    generatePieces();

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

class PuzzlePiece extends StatefulWidget {
  final Image image;
  final int rows, cols;
  final int rowId, colId;
  const PuzzlePiece({Key? key, required this.image, required this.rows, required this.cols, required this.rowId, required this.colId}) : super(key: key);

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