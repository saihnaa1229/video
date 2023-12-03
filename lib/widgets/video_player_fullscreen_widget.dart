import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'advanced_button.dart';
import 'basic_overlay_widget.dart';
import 'custom_controls_widget.dart';

class VideoPlayerFullScreenWidget extends StatefulWidget {
  final VideoPlayerController controller;
  const VideoPlayerFullScreenWidget({required this.controller});

  @override
  State<VideoPlayerFullScreenWidget> createState() =>
      _VideoPlayerFullScreenWidgetState();
}

class _VideoPlayerFullScreenWidgetState
    extends State<VideoPlayerFullScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: widget.controller.value.isInitialized
            ? Container(alignment: Alignment.topCenter, child: buildVideo())
            : Container(
                child: Image.asset("assets/videos/table2.png"),
              ),
      ),
    );
  }

  Widget buildVideo() => OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;
          return Stack(
            fit: isPortrait ? StackFit.loose : StackFit.loose,
            children: [
              buildVideoPlayer(isPortrait),
              Positioned.fill(
                  child: AdvancedOverlayWidget(
                      controller: widget.controller,
                      onClickedFullScreen: () {
                        if (isPortrait) {
                          AutoOrientation.landscapeRightMode();
                        } else {
                          AutoOrientation.portraitUpMode();
                        }
                      })),
              // buildPlay(),
              Positioned.fill(
                  child: BasicOverlayWidget(controller: widget.controller))
            ],
          );
        },
      );

  Widget buildVideoPlayer(bool isPortrait) => BuildFullScreen(
        isPortrait,
        child: AspectRatio(
          aspectRatio: widget.controller.value.aspectRatio,
          child: Stack(
            fit: StackFit.loose,
            children: [
              VideoPlayer(widget.controller),
              // buildPlay(),
              // Buttons(controller: widget.controller),
            ],
          ),
        ),
      );

  Widget buildPlay() {
    return widget.controller.value.isPlaying
        ? Container()
        : Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 80,
            ),
          );
  }

 
  Widget BuildFullScreen(
    bool isPortrait, {
    required Widget child,
  }) {
    final size;
    isPortrait
        ? size = widget.controller.value.size
        : size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
