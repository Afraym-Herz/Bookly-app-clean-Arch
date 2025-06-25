import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/constants.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchFeaturedBooks({int pageNum = 0});
  List<BookEntity> fetchBestSellerBooks({int pageNum = 0});
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<BookEntity> fetchBestSellerBooks({int pageNum = 0}) {
    int startIndex , endIndex ;
    startIndex = pageNum * 10 ;
    var box = Hive.box<BookEntity>(kBestSellerBooks);
    endIndex = (pageNum+1)*10 ;
    if (startIndex >= box.length || endIndex >= box.length ){
      return [] ;
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }

  @override
  List<BookEntity> fetchFeaturedBooks({int pageNum = 0}) {
    int startIndex , endIndex ;
    startIndex = pageNum * 10 ;
    var box = Hive.box<BookEntity>(kFeaturedBooks);
    endIndex = (pageNum+1)*10 ;
    if (startIndex >= box.length || endIndex >= box.length ){
      return [] ;
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }
}
