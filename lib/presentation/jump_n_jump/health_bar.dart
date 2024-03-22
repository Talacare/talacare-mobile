import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';

class HealthBar extends StatefulWidget {
  final ValueNotifier<double> currentValue;
  final double maxValue;

  const HealthBar({
    super.key,
    required this.currentValue,
    this.maxValue = 100,
  });

  @override
  State<HealthBar> createState() => _HealthBarState();
}

class _HealthBarState extends State<HealthBar>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: widget.currentValue.value,
      end: widget.currentValue.value,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    widget.currentValue.addListener(_onValueChanged);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.currentValue.removeListener(_onValueChanged);
    super.dispose();
  }

  void _onValueChanged() {
    _animation = Tween<double>(
      begin: _animation.value,
      end: widget.currentValue.value,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final double widthFactor = _animation.value / widget.maxValue;
    final bool isFullWidth = widthFactor == 1.0;

    return Row(
      children: <Widget>[
        SizedBox(
          height: 60,
          width: 60,
          child: Image.asset('assets/images/jump_n_jump/blood_bag.png'),
        ),
        Expanded(
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.violet,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 6),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: widthFactor,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.dustyRed,
                      borderRadius: isFullWidth
                          ? null
                          : const BorderRadius.horizontal(
                              right: Radius.circular(20)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
