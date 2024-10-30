import 'package:bookly/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:bookly/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/Features/home/domain/repos/home_repo.dart';
import 'package:bookly/core/errors/faliure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl(
      {required this.homeRemoteDataSource, required this.homeLocalDataSource});
  @override
  Future<Either<List<BookEntity>, Faliure>> fetchBestSellerBooks({int pageNum = 0}) async {
    try {
      List<BookEntity> books = homeLocalDataSource.fetchBestSellerBooks(pageNum: pageNum);
      if (books.isNotEmpty) {
        return left(books);
      }
      var remoteBooks = await homeRemoteDataSource.fetchBestSellerBooks(pageNum: pageNum);
      return left(remoteBooks);
    } catch (e) {
      if (e is DioException) {
        return right(ServerFaliure.fromDioError(e));
      }
      return right(ServerFaliure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<List<BookEntity>, Faliure>> fetchFeaturedBooks({int pageNum = 0}) async {
    try {
      List<BookEntity> books = homeLocalDataSource.fetchFeaturedBooks();
      if (books.isNotEmpty) {
        return left(books);
      }
      var remoteBooks = await homeRemoteDataSource.fetchFeaturedBooks(pageNum: pageNum);
      return left(remoteBooks);
    } catch (e) {
      if (e is DioException) {
        return right(ServerFaliure.fromDioError(e));
      }
      return right(ServerFaliure(errMessage: e.toString()));
    }
  }
}
