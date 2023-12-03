import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomControlsWidget extends StatefulWidget {
  final VideoPlayerController controller;
  const CustomControlsWidget({required this.controller});

  @override
  State<CustomControlsWidget> createState() => _CustomControlsWidgetState();
}

class _CustomControlsWidgetState extends State<CustomControlsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildButton(Icon(
        Icons.replay_5,
        color: Colors.white,
        size: 30,
      )),
    );
  }

  Widget buildButton(
    Widget child,
  ) {
    return Container(
      height: 50,
      width: 50,
      child: IconButton(
        onPressed: forward5Seconds,
        icon: child,
      ),
    );
  }

  Future forward5Seconds() async {
    goToPosition((currentPosition) => currentPosition - Duration(seconds: 5));
  }

  Future goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = await widget.controller.position;
    final newPosition = builder(currentPosition!);

    await widget.controller.seekTo(newPosition);
  }
}
