import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/Features/home/domain/repos/home_repo.dart';
import 'package:bookly/core/errors/faliure.dart';
import 'package:bookly/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';

class FetchFeaturedBooksUseCase extends UseCase<List<BookEntity>,int>  {
  final HomeRepo homeRepo ;

  FetchFeaturedBooksUseCase(this.homeRepo);

    @override
      Future<Either<List<BookEntity> , Faliure>> call({int param = 0}) async {
      // check permission
      
      // TODO code to run
      
      return await homeRepo.fetchFeaturedBooks(pageNum: param) ;
    }

}