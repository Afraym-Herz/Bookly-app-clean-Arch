import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/Features/home/domain/repos/home_repo.dart';
import 'package:bookly/core/errors/faliure.dart';
import 'package:dartz/dartz.dart';

class FetchBestSellerBooksUseCase {
  final HomeRepo homeRepo ;

  FetchBestSellerBooksUseCase(this.homeRepo);

    Future<Either<List<BookEntity> , Faliure>> call() async {
      // check permission
      
      // TODO code to run
      
      return await homeRepo.fetchBestSellerBooks() ;
    }

}