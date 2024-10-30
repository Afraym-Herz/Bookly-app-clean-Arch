part of 'best_seller_books_cubit.dart';

@immutable
abstract class BestSellerBooksState {}

 class BestSellerBooksInitial extends BestSellerBooksState {}
 class BestSellerBooksLoading extends BestSellerBooksState {}
 class BestSellerBooksFaliure extends BestSellerBooksState {
  final String errMessage ;

  BestSellerBooksFaliure(this.errMessage);
 }
 class BestSellerBooksSuccess extends BestSellerBooksState {
  final List<BookEntity> books;

  BestSellerBooksSuccess({required this.books});
 }
