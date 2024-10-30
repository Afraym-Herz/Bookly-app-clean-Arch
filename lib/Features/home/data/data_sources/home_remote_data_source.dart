import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/constants.dart';
import 'package:bookly/core/utils/api_services.dart';
import 'package:bookly/core/utils/functions/saveBooksData.dart';
import 'package:bookly/core/utils/functions/getParseBooks.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNum = 0}) ;
  Future<List<BookEntity>> fetchBestSellerBooks({int pageNum = 0}) ;
}


class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiServices apiServices ;

  HomeRemoteDataSourceImpl(this.apiServices);
  
  @override
  Future<List<BookEntity>> fetchBestSellerBooks ({int pageNum = 0}) async {
    var data = await apiServices.get(endPoint: 'volumes?Filtering=free-ebooks&q=computer science&startIndex=${pageNum*10}') ;
    List<BookEntity> books = getParseBooks(data: data);
    saveBooksData(books , kBestSellerBooks);
    return books ;
  }
  

  @override
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNum = 0})async {
   var data = await apiServices.get(endPoint: 'volumes?Filtering=free-ebooks&Sorting=newest&q=programming&startIndex=${pageNum*10}' ) ;
    List<BookEntity> books = getParseBooks(data: data);
    saveBooksData(books, kFeaturedBooks) ;
    return books ;
  }

}
