import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:movies_app_flutter/services/api/index.dart';
import 'package:movies_app_flutter/widgets/advanced_button.dart';
import 'package:video_player/video_player.dart';
import 'package:movies_app_flutter/widgets/custom_controls_widget.dart';
import 'package:intl/intl.dart';

import 'landscape.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String text;
  final String vId;
  final int userId;

  const VideoPlayerWidget({
    Key? key,
    required this.text,
    required this.vId,
    required this.userId,
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

extension on Duration {
  String format() => '$this'.split('.')[0].padLeft(8, '0');
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;
  int stime = 0;

  @override
  void initState() {
    controller = VideoPlayerController.network(widget.text)
      // _initializeVideoPlayerFuture = _controller.initialize();
      // _controller.setLooping(true);
      // _controller.setVolume(1.0);
      ..initialize().then((_) {
        setState(() {
          startTime();
          // stime = 20;
          // controller.seekTo(Duration(seconds: stime));
          print("htnjgrkmfleoprjtnkmflekr");

          controller.play();
          print(widget.text);
        });
      });
    super.initState();
    _initializeVideoPlayerFuture = controller.initialize();
    controller.setVolume(1.0);
    // setLandscape();
  }

  void startTime() async {
    final res = await ApiService()
        .getRequest('/Videos/getvideostime/${widget.userId}/${widget.vId}');
    var data = jsonDecode(res.body);
    print(data[0]["ftime"]);
    if (data[0]["ftime"] != null) {
      stime = int.parse(data[0]["ftime"]);
      print('***************************************');
    } else {
      stime = int.parse(data[0]["stime"]);
      print('***************************************');
    }
    controller.seekTo(Duration(seconds: stime));
  }

  void test() async {
    String time =
        Duration(seconds: controller.value.position.inSeconds).format();
    Map body = {
      'stime': controller.value.isPlaying
          ? controller.value.position.inSeconds
          : null,
      'ftime': controller.value.isPlaying
          ? null
          : controller.value.position.inSeconds,
      'vid': widget.vId,
      'customerID': widget.userId,
    };

    var res = await ApiService()
        .postRequest('/Videos/postVideolog', body: body, isAuth: false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          print('test clicked');
          test();
          return true;
        },
        child: GestureDetector(
          onTap: () {
            setState(
              () {
                controller.value.isPlaying
                    ? controller.pause()
                    : controller.play();
                // print(controller.value.position.inSeconds);
                // print(Duration(seconds: controller.value.position.inSeconds)
                //     .format());
                // print(DateTime.now());
                // print(widget.vId);
                // print(widget.userId);
                test();
              },
            );
          },
          child: Column(
            children: [
              Container(
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (controller.value.isInitialized) {
                      return buildVideo();
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),

                //  controller.value.isInitialized
                //     ? Container(
                //         alignment: Alignment.topCenter, child: buildVideo())
                //     : Container(
                //         child: CircularProgressIndicator(),
                //       ),
              ),
            ],
          ),
        ),
      );

  Widget buildVideo() => OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;
          return Stack(
            fit: isPortrait ? StackFit.loose : StackFit.loose,
            children: [
              buildVideoPlayer(),
              buttons(),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(
                    Icons.fullscreen,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    // child:
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            LandScapePage(controller: controller),
                      ),
                    );
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //   ),
                    // );
                  },
                ),
              ),
              Positioned(bottom: 0, left: 0, right: 0, child: buildIndicator())
              // LandScapePage(controller: controller)
              // fullScreen(
              //   controller: controller,
              //   onClickedFullScreen: () {
              //     if (isPortrait) {
              //       AutoOrientation.landscapeRightMode();
              //     } else {
              //       AutoOrientation.portraitUpMode();
              //     }
              //   },
              // )

              // Positioned.fill(
              // child: AdvancedOverlayWidget(
              //     controller: controller,
              //     onClickedFullScreen: () {
              //       if (isPortrait) {
              //         AutoOrientation.landscapeRightMode();
              //       } else {
              //         AutoOrientation.portraitUpMode();
              //       }
              //     }))
              // Buttons(controller: controller)
              // buildPlay(),
              // Positioned.fill(
              //     child: BasicOverlayWidget(controller: controller))
            ],
          );
        },
      );

  Widget buildVideoPlayer() => buildFullScreen(
        child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(fit: StackFit.expand, children: [
              VideoPlayer(controller),
              buildPlay(),
            ])),
      );

  Widget buttons() {
    final isMuted = controller.value.volume == 0;
    return Positioned(
      bottom: 0,
      left: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    controller.setVolume(isMuted ? 1 : 0);
                    setState(() {});
                  },
                  icon: Icon(
                    isMuted ? Icons.volume_mute : Icons.volume_up,
                    size: 30,
                  ),
                ),
                CustomControlsWidget(controller: controller),
                IconButton(
                  onPressed: () {
                    setState(
                      () {
                        controller.value.isPlaying
                            ? controller.pause()
                            : controller.play();
                      },
                    );
                  },
                  icon: Icon(
                    controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPlay() {
    return controller.value.isPlaying
        ? Container()
        : Container(
            alignment: Alignment.center,
            color: Colors.black26,
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 80,
            ),
          );
  }

  buildIndicator() {
    return VideoProgressIndicator(
      controller,
      allowScrubbing: false,
    );
  }

  Widget buildFullScreen({required Widget child}) {
    final size = controller.value.size;
    final size1 = MediaQuery.of(context).size;

    final Width = size.width;
    final height = size.height;

    return FittedBox(
      fit: BoxFit.fitHeight,
      child: SizedBox(
        child: child,
        height: height,
        width: Width,
      ),
    );
  }
}
