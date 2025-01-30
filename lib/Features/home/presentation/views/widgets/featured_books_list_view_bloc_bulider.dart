import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly/Features/home/presentation/views/widgets/featured_list_view.dart';
import 'package:bookly/core/utils/functions/error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedBooksListViewBlocBulider extends StatefulWidget {
  const FeaturedBooksListViewBlocBulider({super.key});

  @override
  State<FeaturedBooksListViewBlocBulider> createState() =>
      _FeaturedBooksListViewBlocBuliderState();
}

class _FeaturedBooksListViewBlocBuliderState
    extends State<FeaturedBooksListViewBlocBulider> {
  List<BookEntity> books = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeaturedBooksCubit, FeaturedBooksState>(
      listener: (context, state) {
        if (state is FeaturedBooksSuccess) {
          books.addAll(state.books);
        } else if (state is FeaturedBooksPaginationFaliure) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarError(errMessage: state.errMessage),
          );
        }
      },
      builder: (context, state) {
        if (state is FeaturedBooksSuccess ||
            state is FeaturedBooksPaginationLoading ||
            state is FeaturedBooksPaginationFaliure) {
          return FeaturedBooksListView(books: books);
        } else if (state is FeaturedBooksFaliure) {
          return Text(state.errMessage);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
