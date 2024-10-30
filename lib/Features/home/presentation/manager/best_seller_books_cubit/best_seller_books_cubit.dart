import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/Features/home/domain/use_cases/fetch_best_seller_books_use_case.dart';
import 'package:meta/meta.dart';

part 'best_seller_books_state.dart';

class BestSellerBooksCubit extends Cubit<BestSellerBooksState> {
  BestSellerBooksCubit(this.bestSellerBooksUseCase) : super(BestSellerBooksInitial());
  final FetchBestSellerBooksUseCase bestSellerBooksUseCase;
  Future<void> fetchBestSellerBooks() async {
    emit(BestSellerBooksLoading());
    
    var result = await bestSellerBooksUseCase.call();

    result.fold((books) => emit(BestSellerBooksSuccess(books: books)) , 
               (faliure) => emit(BestSellerBooksFaliure(faliure.errMessage ))  );
  }
}
