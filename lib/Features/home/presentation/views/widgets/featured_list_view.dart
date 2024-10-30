import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_book_item.dart';

class FeaturedBooksListView extends StatefulWidget {
  const FeaturedBooksListView({Key? key, required this.books})
      : super(key: key);
  final List<BookEntity> books;

  @override
  State<FeaturedBooksListView> createState() => _FeaturedBooksListViewState();
}

class _FeaturedBooksListViewState extends State<FeaturedBooksListView> {
  late final ScrollController _scrollController ;
  int nextPage = 1 ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController() ;
    _scrollController.addListener(_scrollListner); 
    
  } 

  void _scrollListner (){
    if (_scrollController.position.pixels >= 0.7* _scrollController.position.maxScrollExtent ){
      BlocProvider.of<FeaturedBooksCubit>(context).fetchFeaturedBooks(pageNum: nextPage++) ;
    }
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    _scrollController.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.books.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomBookImage(
              image: widget.books[index].image??'',
            ),
          );
        },
      ),
    );
  }
}
