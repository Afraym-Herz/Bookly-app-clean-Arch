part of 'featured_books_cubit.dart';

@immutable
abstract class FeaturedBooksState {}

 class FeaturedBooksInitial extends FeaturedBooksState {}
 class FeaturedBooksLoading extends FeaturedBooksState {}
 class FeaturedBooksFaliure extends FeaturedBooksState {
  final String errMessage ;

  FeaturedBooksFaliure(this.errMessage);
 }
 class FeaturedBooksSuccess extends FeaturedBooksState {
  final List<BookEntity> books;

  FeaturedBooksSuccess({required this.books});
 }
