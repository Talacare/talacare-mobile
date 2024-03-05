import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/puzzle/timer_state.dart';

class CircleTimer extends StatefulWidget {
  const CircleTimer({Key? key}) : super(key: key);

  @override
  State<CircleTimer> createState() => _CircleTimerState();
}

class _CircleTimerState extends State<CircleTimer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final int _start = 60;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _start),
    );
    _controller.reverse(from: 1.0);
    _controller.addListener(() {
      if (_controller.value == 0.0) {
        final timerState = Provider.of<TimerState>(context, listen: false);
        timerState.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final remainingTime = (_start * _controller.value).ceil();

            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    value: _controller.value,
                    strokeWidth: 3,
                    backgroundColor: AppColors.purple,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                Text(
                  '$remainingTime',
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Digitalt'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
