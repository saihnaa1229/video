import 'package:movies_app_flutter/model/movie_details.dart';
import 'package:movies_app_flutter/model/movie_preview.dart';
import 'package:movies_app_flutter/secret/the_moviedb_api.dart' as secret;
import 'package:movies_app_flutter/utils/constants.dart';
import 'package:movies_app_flutter/utils/file_manager.dart';
import 'package:movies_app_flutter/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import '../api/environment.dart';
import '../model/video_details.dart';
import '../model/video_type.dart';
import 'networking.dart';

enum MoviePageType {
  popular,
  upcoming,
  top_rated,
}

List<VideoDetails> listItems = [
  VideoDetails(
    id: 0,
    image: 'assets/images/animation.jpg',
    video:
        'https://assets.mixkit.co/videos/preview/mixkit-group-of-friends-partying-happily-4640-large.mp4',
    isFavorite: true,
    overview:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also ",
    title:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also ",
  ),
  VideoDetails(
    id: 1,
    image: 'assets/images/beach.jpg',
    video:
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 2,
    image: 'assets/images/butterfly.jpg',
    video:
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 3,
    image: 'assets/images/helicopter.jpg',
    video: '/assets/videos/6S.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 4,
    image: 'assets/images/ocean.jpg',
    video: '/assets/images/ocean.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 5,
    image: 'assets/images/snow.jpg',
    video: '/assets/images/snow.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 6,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 7,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 7,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 7,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 7,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 7,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 7,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 7,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 7,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 7,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 7,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 7,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 7,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 7,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 7,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  ),
  VideoDetails(
    id: 7,
    image: 'assets/images/teatr.jpg',
    video: '/assets/images/teatr.jpg',
    isFavorite: false,
    overview: '',
    title: '',
  )
];

class ApiEndPoints {
  static final String baseUrl = '${Environment.apiUrl}';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'authaccount/registration';
  final String loginEmail = '/Users/login';
}

class MovieModel {
  Future _getData({required String url}) async {
    NetworkHelper networkHelper = NetworkHelper(Uri.parse(url));
    var data = await networkHelper.getData();
    //
    return data;
  }

  Future<List<MovieCard>> getMovies({
    required int corpid,
    required MoviePageType moviesType,

    // required MoviePageType moviesType,
    required Color themeColor,
    required int vtypeid,
  }) async {
    List<MovieCard> temp = [];
    String mTypString =
        moviesType.toString().substring(14, moviesType.toString().length);

    var data = await _getData(
      url: '$kThemoviedbURL/$mTypString?api_key=${secret.themoviedbApi}',
    );
    var data1 = await _getData(
      url: '${Environment.apiUrl}/Videos/getvideo/${corpid}/${vtypeid}',
    );
    // for (int i = 0; i < temp.length; i++){
    //     temp.add(
    //       MovieCard(
    //         moviePreview: MoviePreview(
    //           isFavorite:
    //               await isMovieInFavorites(movieID: temp[i]["id"].toString()),
    //           year: (temp[i]["release_date"].toString().length > 4)
    //               ? temp[i]["release_date"].toString().substring(0, 4)
    //               : "",
    //           imageUrl: listtemp[i]s[i].image,
    //           title: temp[i]["title"],
    //           id: temp[i]["id"].toString(),
    //           rating: temp[i]["vote_average"].toDouble(),
    //           overview: temp[i]["overview"],
    //         ),
    //         themeColor: themeColor,
    //       ),
    //     );
    // }
    for (int i = 0; i < data1.length; i++) {
      // for (int i = 0; i < temp.length; i++) {
      // print(data1[i]["id"]);
      // print('++++++++++++++++++++++++=');
      if (data1[i]["vtypeid"] == moviesType.index) {
        temp.add(
          MovieCard(
            moviePreview: MoviePreview(
              userId: corpid,
              isFavorite: true,
              year: data1[i]["vurl"],
              imageUrl: data1[i]["img"],
              title: data1[i]["vtitle"],
              id: data1[i]["id"].toString(),
              rating: data1[i]["id"].toDouble(),
              overview: data1[i]["vdesc"],
            ),
            themeColor: themeColor,
          ),
        );
      }
    }
    return Future.value(temp);
  }

  Future<List<MovieCard>> getGenreWiseMovies({
    required int genreId,
    required Color themeColor,
  }) async {
    List<MovieCard> temp = [];

    var data = await _getData(
      url:
          '$kThemovieDiscoverdbURL?api_key=${secret.themoviedbApi}&sort_by=popularity.desc&with_genres=$genreId',
    );

    for (var item in data["results"]) {
      temp.add(
        MovieCard(
          moviePreview: MoviePreview(
            userId: 1,
            isFavorite:
                await isMovieInFavorites(movieID: item["id"].toString()),
            year: (item["release_date"].toString().length > 4)
                ? item["release_date"].toString().substring(0, 4)
                : "",
            imageUrl: "$kThemoviedbImageURL${item["poster_path"]}",
            title: item["title"],
            id: item["id"].toString(),
            rating: item["vote_average"].toDouble(),
            overview: item["overview"],
          ),
          themeColor: themeColor,
        ),
      );
    }
    return Future.value(temp);
  }

  Future<List<MovieCard>> searchMovies({
    required String movieName,
    required Color themeColor,
  }) async {
    List<MovieCard> temp = [];

    var data = await _getData(
      url:
          '$kThemoviedbSearchURL/?api_key=${secret.themoviedbApi}&language=en-US&page=1&include_adult=false&query=$movieName',
    );

    for (var item in data["results"]) {
      try {
        temp.add(
          MovieCard(
            moviePreview: MoviePreview(
              userId: 1,
              isFavorite:
                  await isMovieInFavorites(movieID: item["id"].toString()),
              year: (item["release_date"].toString().length > 4)
                  ? item["release_date"].toString().substring(0, 4)
                  : "",
              imageUrl: "https://image.tmdb.org/t/p/w500${item["poster_path"]}",
              title: item["title"],
              id: item["id"].toString(),
              rating: item["vote_average"].toDouble(),
              overview: item["overview"],
            ),
            themeColor: themeColor,
          ),
        );
      } catch (e, s) {
        print(s);
        print(item["release_date"]);
      }
    }
    return Future.value(temp);
  }

  Future<List<VideoType>> getUserMenu({required int corpid}) async {
    var data = await _getData(
      url: '${Environment.apiUrl}/Videos/vtypecorp/${corpid}',
    );

    List<VideoType> temp = [];

    for (int i = 0; i < data.length; i++) {
      // print(data);
      temp.add(
        VideoType(
          id: data[i]["id"],
          title: data[i]["typename"],
        ),
      );
      // print(temp[i].title);
      // print(temp[i].id);
    }
    return Future.value(temp);
  }

  Future<int> getVideoType({required int corpid}) async {
    var data = await _getData(
      url: '${Environment.apiUrl}/Videos/vtypecorp/${corpid}',
    );

    int temp = data[0]["id"];

    // for (int i = 0; i < data.length; i++) {
    //   // print(data);
    //   temp.add(
    //     VideoType(
    //       id: data[i]["id"],
    //       title: data[i]["typename"],
    //     ),
    //   );
    //   // print(temp[i].title);
    //   // print(temp[i].id);
    // }
    return Future.value(temp);
  }

  Future<VideoDetails> getMovieDetails({
    required int movieID,
    required String year,
  }) async {
    // var data = await _getData(
    //   url:
    //       '$kThemoviedbURL/$movieID?api_key=${secret.themoviedbApi}&language=en-US',
    // );
    // print(data);

    var data = await _getData(
      url: '${Environment.apiUrl}/Videos/getvideo1/${movieID}',
    );

    List<String> temp = [];
    List<int> genreIdsTemp = [];
    for (var item in listItems) {
      temp.add(item.image);
      // genreIdsTemp.add(item["id"]);
    }
    return Future.value(
      VideoDetails(
        id: movieID,
        image: 'img',
        isFavorite: false,
        overview: '',
        video: data[0]["vurl"],
        title: '',
      ),
    );

    // return Future.value(
    //   MovieDetails(
    //     backgroundURL:
    //         "https://image.tmdb.org/t/p/w500${data["backdrop_path"]}",
    //     title: data["title"],
    //     year: (data["release_date"].toString().length > 4)
    //         ? data["release_date"].toString().substring(0, 4)
    //         : "",
    //     isFavorite: await isMovieInFavorites(movieID: data["id"].toString()),
    //     rating: data["vote_average"].toDouble(),
    //     genres: Map.fromIterables(temp, genreIdsTemp),
    //     overview: data["overview"],
    //   ),
    // );
  }

  Future<List<MovieCard>> getFavorites(
      {required Color themeColor, required int bottomBarIndex}) async {
    List<MovieCard> temp = [];
    List<String> favoritesID = await getFavoritesID();
    for (var item in favoritesID) {
      if (item != "") {
        var data = await _getData(
          url:
              '$kThemoviedbURL/$item?api_key=${secret.themoviedbApi}&language=en-US',
        );

        temp.add(
          MovieCard(
            contentLoadedFromPage: bottomBarIndex,
            themeColor: themeColor,
            moviePreview: MoviePreview(
              userId: 1,
              isFavorite:
                  await isMovieInFavorites(movieID: data["id"].toString()),
              year: (data["release_date"].toString().length > 4)
                  ? data["release_date"].toString().substring(0, 4)
                  : "",
              imageUrl: "https://image.tmdb.org/t/p/w500${data["poster_path"]}",
              title: data["title"],
              id: data["id"].toString(),
              rating: data["vote_average"].toDouble(),
              overview: data["overview"],
            ),
          ),
        );
      }
    }
    return temp;
  }
}
