import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movies_app_flutter/model/movie_details.dart';
import 'package:movies_app_flutter/model/video_details.dart';
import 'package:movies_app_flutter/widgets/video_player_widget.dart';
import 'package:movies_app_flutter/services/movie.dart';
import 'package:movies_app_flutter/utils/constants.dart';
import 'package:movies_app_flutter/widgets/custom_loading_spin_kit_ring.dart';
import 'package:sizer/sizer.dart';
import 'package:movies_app_flutter/utils/star_calculator.dart'
    as starCalculator;
import 'package:movies_app_flutter/utils/file_manager.dart' as file;
import 'package:movies_app_flutter/utils/toast_alert.dart' as alert;
import 'package:video_player/video_player.dart';

class DetailsScreen extends StatefulWidget {
  final String id;
  final Color themeColor;
  final String vurl;
  final int userId;
  DetailsScreen(
      {required this.id,
      required this.themeColor,
      required this.vurl,
      required this.userId});
  @override
  _DetailsScreenState createState() => _DetailsScreenState();

  // Future<MovieDetails> getMovieDetails() async {
  //   MovieModel movieModel = MovieModel();
  //   MovieDetails temp = await movieModel.getMovieDetails(movieID: id);
  //   return temp;
  // }
  Future<VideoDetails> getMovieDetails() async {
    MovieModel videoModel = MovieModel();
    VideoDetails temp =
        await videoModel.getMovieDetails(movieID: int.parse(id), year: vurl);
    // print(temp.);
    return temp;
  }
}

// late VideoPlayerController _controller;

class _DetailsScreenState extends State<DetailsScreen> {
  VideoDetails? videoDetails;
  // List<Widget>? stars;
  bool isFavorite = false;
  bool backButtonPressed = false;

  // final videoTest = ("assets/videos/third.mp4");

  @override
  void initState() {
    // _controller = VideoPlayerController.asset(videoTest)
    //   ..initialize().then((_) {
    //     // setState(() {
    //     // _controller.play();
    //     // });
    //   });
    print('ttttttttttttttttttt');
    super.initState();
    () async {
      VideoDetails temp = await widget.getMovieDetails();

      print("object");
      // List<Widget> temp2 = starCalculator.getStars(rating: 5, starSize: 15.sp);

      setState(() {
        // isFavorite = temp.isFavorite;
        videoDetails = temp;
        // stars = temp2;
        print('+++++++++');
      });
    }();
  }

  saveFavorite() async {
    if (await file.addFavorite(movieID: widget.id)) {
      alert.toastAlert(
        message: kFavoriteAddedText,
        themeColor: widget.themeColor,
      );
    }
    setState(() {
      isFavorite = true;
      // print(videoDetails!.video);
    });
  }

  removeFavorite() async {
    if (await file.removeFavorite(movieID: widget.id)) {
      alert.toastAlert(
        message: kFavoriteRemovedText,
        themeColor: widget.themeColor,
      );
    }
    setState(() {
      isFavorite = false;
    });
  }

  Future<bool> backButton() async {
    setState(() {
      print('clicked');
      backButtonPressed = true;
    });
    return backButtonPressed;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body
            // : (stars == null)
            //     ? CustomLoadingSpinKitRing(loadingColor: Colors.blue)
            : CustomScrollView(
          slivers: [
            SliverAppBar(
              shadowColor: Colors.transparent.withOpacity(0.1),
              elevation: 0,
              backgroundColor: kPrimaryColor,
              leading: Padding(
                padding: EdgeInsets.only(left: 3.w),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      backButton();
                      // Navigator.pop(context);
                      print('backButtonClicked');
                      print(backButtonPressed);
                    });
                  },
                ),
              ),
              automaticallyImplyLeading: false,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 29.0.h,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        (!isFavorite) ? saveFavorite() : removeFavorite();
                      });
                    },
                    icon: Icon((isFavorite)
                        ? Icons.bookmark_sharp
                        : Icons.bookmark_border_sharp),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(kDetailsScreenTitleText),
                background: Container(
                    // child: CachedNetworkImage(
                    //   fit: BoxFit.cover,
                    //   placeholder: (context, url) => SafeArea(
                    //     child: Container(
                    //       height: 22.h,
                    //       child: CustomLoadingSpinKitRing(
                    //           loadingColor: widget.themeColor),
                    //     ),
                    //   ),
                    //   imageUrl: videoDetails!.image,
                    //   errorWidget: (context, url, error) => SafeArea(
                    //     child: Container(
                    //       height: 22.h,
                    //       child: CustomLoadingSpinKitRing(
                    //           loadingColor: widget.themeColor),
                    //     ),
                    //   ),
                    // ),
                    // child: Image.asset(videoDetails!.image),
                    child: FittedBox(
                  fit: BoxFit.fill,
                  child: Container(
                    // height: double.maxFinite,
                    child: VideoPlayerWidget(
                      userId: widget.userId,
                      text: widget.vurl,
                      vId: widget.id,
                    ),
                  ),
                )),
              ),
            ),
            SliverFillRemaining(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.h),
                        child: Wrap(
                          children: [
                            Text(
                              "${videoDetails!.title} ",
                              style: kDetailScreenBoldTitle,
                            ),
                            // Text(
                            //   (videoDetails!.year == "")
                            //       ? ""
                            //       : "(${videoDetails!.year})",
                            //   style: kDetailScreenRegularTitle,
                            // )
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 4.h),
                      //   child: Row(children: stars!),
                      // ),
                      SizedBox(height: 3.h),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.h),
                          // child: Row(
                          //     children:
                          //     videoDetails!.getGenresList(context),
                          //     ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                    ],
                  ),
                  if (videoDetails!.overview == "")
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.h, vertical: 3.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: 1.h,
                                left: 1.h,
                                bottom: 1.h,
                              ),
                              child: Container(
                                child: Text(kStoryLineTitleText,
                                    style: kSmallTitleTextStyle),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: 1.h,
                                    left: 1.h,
                                    top: 1.h,
                                    bottom: 4.h),
                                child: Text(
                                  videoDetails!.overview,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Color(0xFFC9C9C9)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildVideo() => OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        return Stack(
          fit: isPortrait ? StackFit.loose : StackFit.loose,
          children: [
            // buildVideoPlayer(),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(
                  Icons.fullscreen,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         LandScapePage(controller: widget.controller),
                  //   ),
                  // );
                },
              ),
            )
            // LandScapePage(controller: widget.controller)
            // fullScreen(
            //   controller: widget.controller,
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
            //     controller: widget.controller,
            //     onClickedFullScreen: () {
            //       if (isPortrait) {
            //         AutoOrientation.landscapeRightMode();
            //       } else {
            //         AutoOrientation.portraitUpMode();
            //       }
            //     }))
            // Buttons(controller: widget.controller)
            // buildPlay(),
            // Positioned.fill(
            //     child: BasicOverlayWidget(controller: widget.controller))
          ],
        );
      },
    );
