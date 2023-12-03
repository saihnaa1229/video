import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import 'video_player_fullscreen_widget.dart';

class LandScapePage extends StatefulWidget {
  final VideoPlayerController controller;
  const LandScapePage({Key? key, required this.controller}) : super(key: key);

  @override
  State<LandScapePage> createState() => _LandScapePageState();
}

class _LandScapePageState extends State<LandScapePage> {
  @override
  void initState() {
    super.initState();

    setLandscape();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    setAllOrientations();

    super.dispose();
  }

  Future setLandscape() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    await Wakelock.enable();
  }

  Future setAllOrientations() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    await Wakelock.disable();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: VideoPlayerFullScreenWidget(controller: widget.controller),
      );
}
