class MoviePreview {
  final String id;
  final String title;
  final String? imageUrl;
  final String year;
  final bool isFavorite;
  final double rating;
  final int userId;
  String overview;

  MoviePreview({
    required this.userId,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.year,
    required this.isFavorite,
    required this.overview,
    required this.rating,
  });
}
