import 'package:hive/hive.dart';
part 'book_entity.g.dart';

@HiveType(typeId: 0)
class BookEntity {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final num? price;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final String? author;
  @HiveField(5)
  final String bookId;
  @HiveField(6)
  final int pageCount;

  BookEntity(
      {required this.bookId,
      required this.title,
      this.description,
      this.price,
      this.image,
      this.author,
      required this.pageCount});
}
