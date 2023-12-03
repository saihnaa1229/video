import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app_flutter/model/video_type.dart';
import 'package:movies_app_flutter/screens/drawer_screen.dart';
import 'package:movies_app_flutter/screens/finder_screen.dart';
import 'package:movies_app_flutter/services/api/index.dart';
import 'package:movies_app_flutter/services/auth/authentication.dart';
import 'package:movies_app_flutter/utils/constants.dart';
import 'package:movies_app_flutter/utils/file_manager.dart' as file;
import 'package:movies_app_flutter/utils/navi.dart' as navi;
import 'package:movies_app_flutter/utils/scroll_top_with_controller.dart'
    as scrollTop;
import 'package:movies_app_flutter/utils/toast_alert.dart' as alert;
import 'package:movies_app_flutter/widgets/bottom_navigation.dart';
import 'package:movies_app_flutter/widgets/bottom_navigation_item.dart';
import 'package:movies_app_flutter/widgets/custom_loading_spin_kit_ring.dart';
import 'package:movies_app_flutter/widgets/custom_main_appbar_content.dart';
import 'package:movies_app_flutter/widgets/movie_card.dart';
import 'package:movies_app_flutter/widgets/movie_card_container.dart';
import 'package:movies_app_flutter/widgets/shadowless_floating_button.dart';
import 'package:sizer/sizer.dart';
import 'package:movies_app_flutter/services/movie.dart';

class HomeScreen extends StatefulWidget {
  final int json;
  // final int corpid;
  // final String token;
  const HomeScreen(this.json, {Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  //for custom drawer opening
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AuthenticationManager _auth = Get.put(AuthenticationManager());
  //for scroll upping
  ScrollController? _scrollController;
  bool showBackToTopButton = false;
  Color? themeColor;
  int? activeInnerPageIndex;
  List<MovieCard>? _movieCards;
  List<VideoType>? _movieTypes;
  int _movieTypesId = 0;
  bool showSlider = true;
  String title = kHomeScreenTitleText;
  int bottomBarIndex = 1;

  Future<void> loadData(int tid) async {
    MovieModel movieModel = MovieModel();

    _movieCards = (bottomBarIndex == 1)
        ? await movieModel.getMovies(
            moviesType: MoviePageType.values[activeInnerPageIndex!],
            themeColor: themeColor!,
            corpid: widget.json,
            vtypeid: tid)
        : await movieModel.getFavorites(
            themeColor: themeColor!, bottomBarIndex: bottomBarIndex);
    setState(() {
      scrollTop.scrollToTop(_scrollController!);
      showBackToTopButton = false;
      print(_movieTypes);

      // print(MoviePageType.popular.index);
      // print(MoviePageType.upcoming.index);
      // print(MoviePageType.top_rated.index);
    });
  }

  Future<void> loadData1() async {
    MovieModel movieModel = MovieModel();

    _movieTypes = await movieModel.getUserMenu(corpid: widget.json);

    setState(() {
      scrollTop.scrollToTop(_scrollController!);
      showBackToTopButton = false;
      // print(MoviePageType.popular.index);
      // print(MoviePageType.upcoming.index);
      // print(MoviePageType.top_rated.index);
    });
  }

  Future<void> loadDataType() async {
    MovieModel movieModel = MovieModel();

    _movieTypesId = await movieModel.getVideoType(corpid: widget.json);
  }

  void pageSwitcher(int index) {
    setState(() {
      bottomBarIndex = (index == 2) ? 2 : 1;
      title = (index == 2) ? kFavoriteScreenTitleText : kHomeScreenTitleText;
      showSlider = !(index == 2);
      _movieCards = null;
      // loadData();
    });
  }

  void movieCategorySwitcher(int index) {
    setState(() {
      activeInnerPageIndex = index;
      _movieCards = null;
      loadData(index);
      loadData1();
    });
  }

  @override
  void initState() {
    super.initState();

    _auth.checkLoginStatus();
    () async {
      MovieModel movieModel = MovieModel();

      _movieTypesId = await movieModel.getVideoType(corpid: widget.json);
      // MovieModel movieModel = MovieModel();

      // _movieTypesId = await movieModel.getVideoType(corpid: widget.json);

      themeColor = await file.currentTheme();
      print(themeColor);
      _scrollController = ScrollController()
        ..addListener(() {
          setState(() {
            showBackToTopButton = (_scrollController!.offset >= 200);
          });
        });
      activeInnerPageIndex = _movieTypesId;
      setState(() {
        loadData(_movieTypesId);
        loadData1();
      });
    }();

    // testGet();
  }

  // void testGet() async {
  //   var res = await ApiService().getRequest('/Videos/vtypecorp/1');
  //   print("************************************0");
  //   print(res.body);

  //   // var res = await ApiService().postRequest('/Videos/vtypecorp/1');
  //   // print(res);
  // }

  @override
  void dispose() {
    if (_scrollController != null) _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (themeColor == null)
        ? CustomLoadingSpinKitRing(loadingColor: themeColor)
        : Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              shadowColor: Colors.transparent.withOpacity(0.1),
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: kAppBarColor,
              bottom: PreferredSize(
                child: CustomMainAppBarContent(
                  videoTypes: _movieTypes,
                  showSlider: showSlider,
                  title: title,
                  activeButtonIndex: activeInnerPageIndex!,
                  activeColor: themeColor!,
                  buttonFistOnPressed: (index) => movieCategorySwitcher(index),
                  buttonSecondOnPressed: (index) =>
                      movieCategorySwitcher(index),
                  buttonThirdOnPressed: (index) => movieCategorySwitcher(index),
                  searchOnPressed: () => navi.newScreen(
                    context: context,
                    newScreen: () => FinderScreen(
                      themeColor: themeColor!,
                    ),
                  ),
                ),
                preferredSize:
                    Size.fromHeight((bottomBarIndex == 1) ? 16.0.h : 7.h),
              ),
            ),
            body: (_movieCards == null)
                ? CustomLoadingSpinKitRing(loadingColor: themeColor)
                : (_movieCards!.length == 0)
                    ? Center(child: Text(k404Text))
                    : MovieCardContainer(
                        scrollController: _scrollController!,
                        themeColor: themeColor!,
                        movieCards: _movieCards!,
                      ),
            bottomNavigationBar: BottomNavigation(
              activeColor: themeColor!,
              index: bottomBarIndex,
              children: [
                BottomNavigationItem(
                  icon: Icon(Icons.more_horiz),
                  iconSize: 35.sp,
                  onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                ),
                BottomNavigationItem(
                  icon: Icon(Icons.videocam),
                  iconSize: 28.sp,
                  onPressed: () {
                    pageSwitcher(1);
                  },
                ),
                BottomNavigationItem(
                    icon: Icon(Icons.bookmark_sharp),
                    iconSize: 23.sp,
                    onPressed: () {
                      pageSwitcher(2);
                    }),
              ],
            ),
            drawerEnableOpenDragGesture: false,
            drawer: DrawerScreen(colorChanged: (color) {
              themeColor = color;
              setState(() {
                alert.toastAlert(
                    message: kAppliedTheme, themeColor: themeColor);
              });
            }),
            floatingActionButton: showBackToTopButton
                ? ShadowlessFloatingButton(
                    iconData: Icons.keyboard_arrow_up_outlined,
                    onPressed: () {
                      setState(() {
                        scrollTop.scrollToTop(_scrollController!);
                      });
                    },
                    backgroundColor: themeColor,
                  )
                : null,
          );
  }
}
