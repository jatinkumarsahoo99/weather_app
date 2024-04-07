import 'package:flutter/material.dart';
class MovingCloud extends StatefulWidget {
  final Widget cloud; // The cloud image widget
  final double width;  // Width of the cloud image
  final double speed;   // Speed of cloud movement (pixels per second)

  const MovingCloud({
    Key? key,
    required this.cloud,
    required this.width,
    required this.speed,
  }) : super(key: key);

  @override
  State<MovingCloud> createState() => _MovingCloudState();
}

class _MovingCloudState extends State<MovingCloud> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  double _currentPosition = 0.0; // Current position of the cloud

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: (widget.width / widget.speed).round()), // Use round()
    )..addListener(() {
      setState(() {
        _currentPosition = _animation.value.dx;
      });
    });
    _animation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(-widget.width, 0.0),
    ).animate(_controller);

    _controller.forward().then((_) => _controller.reverse()); // Start animation, then reverse
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack( // Ensure AnimatedPositioned is inside a Stack
      children: [
        AnimatedPositioned( // Wrap AnimatedPositioned with Stack
          left: _currentPosition,
          top: 0.0,
          duration: Duration(seconds: (widget.width / widget.speed).round()),
          child: widget.cloud,
        ),
      ],
    );
  }
}

class CloudList extends StatelessWidget {
  final List<Widget> clouds; // List of cloud widgets
  final double cloudSpacing;  // Spacing between clouds

  const CloudList({
    Key? key,
    required this.clouds,
    required this.cloudSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var cloud in clouds) ...[
          cloud,
          SizedBox(width: cloudSpacing),
        ],
      ],
    );
  }
}

