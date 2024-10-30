import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/core/errors/faliure.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<List<BookEntity> , Faliure>> fetchFeaturedBooks({int pageNum=0}) ;
  Future<Either<List<BookEntity> , Faliure>> fetchBestSellerBooks({int pageNum=0}) ;
}