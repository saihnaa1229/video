class VideoDetails {
  final int id;
  final String title;
  final String image;
  final String video;
  final bool isFavorite;
  final String overview;

  VideoDetails({
    required this.image,
    required this.video,
    required this.id,
    required this.title,
    required this.isFavorite,
    required this.overview,
  });
}
  