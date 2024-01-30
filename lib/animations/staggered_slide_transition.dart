import 'package:flutter/material.dart';
import 'package:bedtime_story_ai/animations/animation_controller_state.dart';

class StaggeredSlideTransition extends StatefulWidget {
  const StaggeredSlideTransition(
      {super.key, required this.index, required this.child, required this.width});
  final int index;
  final Widget child;
  final double width;

  @override
  State<StaggeredSlideTransition> createState() =>
      _StaggeredSlideTransitionState();
}

class _StaggeredSlideTransitionState
    extends AnimationControllerState<StaggeredSlideTransition> {
  _StaggeredSlideTransitionState() : super(const Duration(milliseconds: 3500));
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(widget.width, 0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.1 * widget.index,
        0.5 + 0.1 * widget.index,
        curve: Curves.easeInOutCubicEmphasized,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
            position: _offsetAnimation,
            child: widget.child,
          );
  }
}