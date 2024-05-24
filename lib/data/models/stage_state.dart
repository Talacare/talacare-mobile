import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:talacare/data/models/image_pair.dart';

class StageState {
  List<int> starList;
  int stage;
  int score;
  List<ImagePair> images;

  StageState(this.starList, this.stage, this.score, this.images);

  Future<List<ImagePair>> generateImages() async {
    if (images.isEmpty) {
      String filePath = "assets/images/puzzle_images/image_name_pairs.json";
      String jsonContents = await rootBundle.loadString(filePath);
      List<dynamic> jsonData = json.decode(jsonContents);

      List<ImagePair> shuffledPairs = [];
      for (var pair in jsonData) {
        String image = pair["image"];
        String name = pair["name"];
        String voice = pair["voice"];
        shuffledPairs.add(ImagePair(image, name, voice));
      }
      shuffledPairs.shuffle();

      images = shuffledPairs.sublist(0, 4);
    }
    return images;
  }
}
