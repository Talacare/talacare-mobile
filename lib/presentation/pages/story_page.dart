import 'package:flutter/material.dart';
import 'package:talacare/core/enums/button_color_scheme_enum.dart';
import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/presentation/pages/choose_character_page.dart';
import 'package:talacare/presentation/pages/puzzle_page.dart';
import 'package:talacare/presentation/widgets/button.dart';

class StoryPage extends StatefulWidget {
  final String storyType;

  const StoryPage({
    super.key,
    required this.storyType,
  });

  @override
  // ignore: library_private_types_in_public_api
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int currentGif = 0;
  late List<String> gifs;

  @override
  void initState() {
    super.initState();
    gifs = [
      'assets/images/story/jump_n_jump/start/story0.gif',
      'assets/images/story/jump_n_jump/start/story1.gif'
    ];
  }

  void nextGif() {
    if (currentGif < gifs.length - 1) {
      setState(() => currentGif++);
    } else {
      finishStory();
    }
  }

  void finishStory() {
    if (widget.storyType.contains('Ending')) {
      Navigator.popUntil(context, ModalRoute.withName('/'));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => widget.storyType.contains('JUMP_N_JUMP')
                ? const ChooseCharacterPage()
                : PuzzlePage(stageState: StageState([1, 0, 0, 0], 1, 0, []))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Image.asset('assets/images/story/home.png'),
                        iconSize: 30,
                        onPressed: () => Navigator.of(context)
                            .popUntil(ModalRoute.withName('/')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          '${currentGif + 1}/${gifs.length}',
                          style: const TextStyle(
                            fontFamily: 'Digitalt',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  currentGif < gifs.length - 1
                      ? Button(
                          text: 'Lewati',
                          onTap: finishStory,
                          width: 120,
                        )
                      : const SizedBox(width: 120),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(gifs[currentGif], fit: BoxFit.contain),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Button(
                text: currentGif == gifs.length - 1
                    ? (widget.storyType.contains('Ending')
                        ? 'Selesai'
                        : 'Mainkan')
                    : 'Lanjut',
                colorScheme: ButtonColorScheme.purple,
                onTap: nextGif,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
