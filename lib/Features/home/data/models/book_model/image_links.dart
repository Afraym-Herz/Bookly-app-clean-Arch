class ImageLinks {
 final String smallThumbnail;
 final String thumbnail;

  ImageLinks({required this.smallThumbnail,required  this.thumbnail});

  factory ImageLinks.fromJson(Map<String, dynamic> json) => ImageLinks(
        smallThumbnail: json['smallThumbnail'] as String,
        thumbnail: json['thumbnail'] as String,
      );

  Map<String, dynamic> toJson() => {
        'smallThumbnail': smallThumbnail,
        'thumbnail': thumbnail,
      };
}
