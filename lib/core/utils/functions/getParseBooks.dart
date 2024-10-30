import 'package:bookly/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly/Features/home/domain/entites/book_entity.dart';

List<BookEntity> getParseBooks({required Map <String,dynamic> data}){ 
  List<BookEntity> books = [] ;

    for (var book in data['items'] ) {
      books.add(BookModel.fromJson(book)) ;
    }
    return books ;
}