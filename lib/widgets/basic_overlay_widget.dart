import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BasicOverlayWidget extends StatefulWidget {
  final VideoPlayerController controller;
  const BasicOverlayWidget({ required this.controller});

  @override
  State<BasicOverlayWidget> createState() => _BasicOverlayWidgetState();
}

class _BasicOverlayWidgetState extends State<BasicOverlayWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack();
  }
}
