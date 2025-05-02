import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/book.dart';

part 'book_state.dart';

enum SortType { author, title }

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookInitial());

  List<Book> _books = [];

  void init() {
    _books = [
      Book(
        title: "Don't Look Back",
        author: "Isaac Nelson",
        imageUrl: "assets/books/look.JPG",
        description: "Book number 1 description",
      ),
      Book(
        title: "the big deal",
        author: "Hishan Al Guro",
        imageUrl: "assets/books/the_big_deal.JPG",
        description: "Book number 2 description",
      ),
      Book(
        title: "A Clockword Orange",
        author: "Anthony Burgess",
        imageUrl: "assets/books/clockwork.JPG",
        description: "Book number 3 description",
      ),
      Book(
        title: "little gods",
        author: "Meng Jin",
        imageUrl: "assets/books/little_gods.JPG",
        description: "Book number 4 description",
      ),
      Book(
        title: "James and the Giant Peach",
        author: "Roald Dahl",
        imageUrl: "assets/books/James_and_the_Giant_Peach.JPG",
        description: "Book number 5 description",
      ),
      Book(
        title: "The Imperfections of Memory",
        author: "Angelina Aludo", 
        imageUrl: "assets/books/The_Imperfections_of_Memory.JPG",
        description: "Book number 6 description",
      ),
      Book(
        title: "Carmer and the Grits",
        author: "Sarah Jean Horowitz", 
        imageUrl: "assets/books/Carmer_and_the_Grits.JPG",
        description: "Book number 7 description",
      ),
    ];
    emit(BookLoaded(books: _books, sortType: SortType.title));
  }

  void sortByTitle() {
    emit(BookShimmer());
    _books.sort((a, b) => a.title.compareTo(b.title));
    emit(BookLoaded(books: List.from(_books), sortType: SortType.title));
  }

  void sortByAuthor() {
    emit(BookShimmer());
    _books.sort((a, b) => a.author.compareTo(b.author));
    emit(BookLoaded(books: List.from(_books), sortType: SortType.author));
  }

  void showBookDetail(Book book) {
    emit(BookDetailView(book: book));
  }

  void goBackToList() {
    emit(BookLoaded(books: List.from(_books), sortType: SortType.title));
  }
}
