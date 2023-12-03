import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AdvancedOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onClickedFullScreen;

  const AdvancedOverlayWidget(
      {required this.controller, required this.onClickedFullScreen});

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () =>
            controller.value.isPlaying ? controller.pause() : controller.play(),
        child: Stack(
          children: <Widget>[
            buildPlay(),
            // Buttons(controller: controller),
            Positioned(
              bottom: 0,
              right: 0,
              child: Row(
                children: [
                  // Expanded(child: buildIndicator()),
                  const SizedBox(width: 12),
                  GestureDetector(
                    child: Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                      size: 28,
                    ),
                    onTap: onClickedFullScreen,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildIndicator() => Container(
        margin: EdgeInsets.all(8).copyWith(right: 0),
        height: 16,
        child: VideoProgressIndicator(
          controller,
          allowScrubbing: true,
        ),
      );

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          color: Colors.black26,
          child: Center(
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 70,
            ),
          ),
        );
}
