import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/puzzle/state/complete_state.dart';
import 'package:talacare/presentation/puzzle/state/time_left_state.dart';
import 'package:talacare/presentation/puzzle/state/timer_state.dart';

class CircleTimer extends StatefulWidget {
  const CircleTimer({super.key});

  @override
  State<CircleTimer> createState() => _CircleTimerState();
}

class _CircleTimerState extends State<CircleTimer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final int _start = 60;

  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _start),
    )
      ..reverse(from: 1.0)
      ..addListener(() {
        if (_controller.value == 0.0) {
          final completeState = Provider.of<CompleteState>(context, listen: false);
          completeState.value = true;

          final timeLeftState = Provider.of<TimeLeftState>(context, listen: false);
          timeLeftState.value = 0;
        }
      });
    
    // Pass all the callbacks for the transitions you want to listen to
    _listener = AppLifecycleListener(
      onInactive: stopTimer,
      onResume: resumeTimer,
    );
  }

  void stopTimer() {
    _controller.stop();
  }

  void resumeTimer() {
    _controller.reverse(from: _controller.value);
  }

  @override
  Widget build(BuildContext context) {
    final isComplete = Provider.of<CompleteState>(context);
    final timePause = Provider.of<TimerState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final remainingTime = (_start * _controller.value).ceil();

            if (isComplete.value) {
              _controller.stop();

              final timeLeftState = Provider.of<TimeLeftState>(context, listen: false);
              timeLeftState.value = remainingTime;
            } else {
              if (timePause.value) {
              stopTimer();
              } else {
                resumeTimer();
              }
            }

            

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
    _listener.dispose();
    super.dispose();
  }
}
