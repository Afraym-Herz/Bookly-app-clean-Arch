import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/core/errors/faliure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Param> {
  Future<Either<List<BookEntity> , Faliure>> call ({int param =0}) ;
}

