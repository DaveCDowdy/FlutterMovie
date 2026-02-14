class Movie {
  final int id;
  final String title;
  final String image;
  final String genre;
  final String rating;
  final int imageResId;

  Movie({
    required this.id,
    required this.title,
    required this.image,
    required this.genre,
    required this.rating,
    this.imageResId = 0,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      genre: json['genre'] as String,
      rating: json['rating'] as String,
      imageResId: json['imageResId'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'genre': genre,
      'rating': rating,
      'imageResId': imageResId,
    };
  }
}

