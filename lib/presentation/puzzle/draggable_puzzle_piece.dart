import 'package:flutter/material.dart';
import 'package:talacare/presentation/puzzle/puzzle_piece.dart';
import 'package:talacare/presentation/puzzle/puzzle_piece_pos.dart';

class DraggablePuzzlePiece extends StatefulWidget {
  final Image image;
  final int rows, cols;
  final int rowId, colId;
  final int rowPos, colPos;
  final Function(int, int, int, int) onSwap;
  const DraggablePuzzlePiece({
    super.key,
    required this.image,
    required this.rows,
    required this.cols,
    required this.rowId,
    required this.colId,
    required this.rowPos,
    required this.colPos,
    required this.onSwap,
  });

  @override
  State<DraggablePuzzlePiece> createState() => _DraggablePuzzlePieceState();
}

class _DraggablePuzzlePieceState extends State<DraggablePuzzlePiece> {
  late double pieceHeight, pieceWidth;
  double opacity = 0;

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
          child: Stack(
            children: [
              PuzzlePiece(
                image: widget.image,
                rows: widget.rows,
                cols: widget.cols,
                rowId: widget.rowId,
                colId: widget.colId,
              ),
              Opacity(
                opacity: opacity,
                child: SizedBox(
                  height: pieceHeight,
                  width: pieceWidth,
                  child: const ColoredBox(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        DragTarget<PuzzlePiecePos>(
          onMove: (details) {
            setState(() {
              opacity = 0.8;
            });
          },
          onLeave: (details) {
            setState(() {
              opacity = 0;
            });
          },
          onAcceptWithDetails: (details) {
            widget.onSwap(widget.rowPos, widget.colPos, details.data.rowPos,
                details.data.colPos);
            setState(() {
              opacity = 0;
            });
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