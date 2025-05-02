part of 'book_cubit.dart';

abstract class BookState {}

class BookInitial extends BookState {}

class BookShimmer extends BookState {}

class BookLoaded extends BookState {
  final List<Book> books;
  final SortType sortType;

  BookLoaded({required this.books, required this.sortType});
}

class BookDetailView extends BookState {
  final Book book;

  BookDetailView({required this.book});
}
