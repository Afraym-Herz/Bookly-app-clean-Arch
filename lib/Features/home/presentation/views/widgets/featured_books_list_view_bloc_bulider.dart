import 'package:bookly/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly/Features/home/presentation/views/widgets/featured_list_view.dart';
import 'package:bookly/core/errors/faliure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedBooksListViewBlocBulider extends StatelessWidget {
  const FeaturedBooksListViewBlocBulider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedBooksCubit, FeaturedBooksState >(
      builder: (context, state) {
        if(state is FeaturedBooksSuccess){
          return  FeaturedBooksListView(books: state.books ,) ;
        }
        else if (state is FeaturedBooksFaliure){
         return Text(state.errMessage);
        }
        else {
          return const CircularProgressIndicator();
        }
      },
    ) ;
  }
}