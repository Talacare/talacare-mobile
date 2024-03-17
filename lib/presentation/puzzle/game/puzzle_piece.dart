import 'package:flutter/material.dart';

class PuzzlePiece extends StatefulWidget {
  final Image image;
  final int rows, cols;
  final int rowId, colId;
  const PuzzlePiece({
    super.key,
    required this.image,
    required this.rows,
    required this.cols,
    required this.rowId,
    required this.colId,
  });

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
            width: 1,
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