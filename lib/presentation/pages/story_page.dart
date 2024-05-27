import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:talacare/core/enums/button_color_scheme_enum.dart';
import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/presentation/pages/choose_character_page.dart';
import 'package:talacare/presentation/pages/puzzle_page.dart';
import 'package:talacare/presentation/widgets/button.dart';
import 'package:talacare/presentation/widgets/home_button.dart';

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
  late List<String> sfxs;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _setGifsAndSfxs();
    playSound(sfxs[currentGif]);
  }

  void _setGifsAndSfxs() {
    if (widget.storyType.contains('JUMP_N_JUMP')) {
      gifs = widget.storyType.contains('Start')
          ? [
              'assets/images/story/jump_n_jump/start/story0.gif',
              'assets/images/story/jump_n_jump/start/story1.gif',
              'assets/images/story/jump_n_jump/start/story2.gif',
              'assets/images/story/jump_n_jump/start/story3.gif',
              'assets/images/story/jump_n_jump/start/story4.gif',
            ]
          : [
              'assets/images/story/jump_n_jump/end/story0.gif',
              'assets/images/story/jump_n_jump/end/story1.gif',
            ];
      sfxs = widget.storyType.contains('Start')
          ? [
              'audio/story/jump_n_jump/start/narration0.mp3',
              'audio/story/jump_n_jump/start/narration1.mp3',
              'audio/story/jump_n_jump/start/narration2.mp3',
              'audio/story/jump_n_jump/start/narration3.mp3',
              'audio/story/jump_n_jump/start/narration4.mp3'
            ]
          : [
              'audio/story/jump_n_jump/end/narration0.mp3',
              'audio/story/jump_n_jump/end/narration1.mp3'
            ];
    } else if (widget.storyType.contains('PUZZLE')) {
      gifs = widget.storyType.contains('Start')
          ? [
              'assets/images/story/puzzle/start/story0.gif',
              'assets/images/story/puzzle/start/story1.gif',
              'assets/images/story/puzzle/start/story2.gif',
            ]
          : [
              'assets/images/story/puzzle/end/story0.gif',
              'assets/images/story/puzzle/end/story1.gif',
            ];
      sfxs = widget.storyType.contains('Start')
          ? [
              'audio/story/puzzle/start/narration0.mp3',
              'audio/story/puzzle/start/narration1.mp3',
              'audio/story/puzzle/start/narration2.mp3',
            ]
          : [
              'audio/story/puzzle/end/narration0.mp3',
              'audio/story/puzzle/end/narration1.mp3',
            ];
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void nextGif() {
    if (currentGif < gifs.length - 1) {
      setState(() => currentGif++);
      playSound(sfxs[currentGif]);
    } else {
      finishStory();
    }
  }

  Future<void> playSound(String path) {
    return _audioPlayer.play(AssetSource(path));
  }

  void stopSound() {
    _audioPlayer.stop();
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
    stopSound();
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
                      HomeButton(
                        onTap: () {
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/'));
                          stopSound();
                        },
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
                  currentGif < gifs.length - 1 &&
                          widget.storyType.contains('Start')
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
