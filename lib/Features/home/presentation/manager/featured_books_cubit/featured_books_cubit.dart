import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/Features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import 'package:bookly/core/errors/faliure.dart';
import 'package:meta/meta.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.featuredBooksUseCase) : super(FeaturedBooksInitial());
  final FetchFeaturedBooksUseCase featuredBooksUseCase;
  Future<void> fetchFeaturedBooks({int pageNum = 0}) async {
    emit(FeaturedBooksLoading());
    
    var result = await featuredBooksUseCase.call(pageNum);

    result.fold((books) => emit(FeaturedBooksSuccess(books: books)) , 
               (faliure) => emit(FeaturedBooksFaliure(faliure.errMessage ))  );
  }
}
