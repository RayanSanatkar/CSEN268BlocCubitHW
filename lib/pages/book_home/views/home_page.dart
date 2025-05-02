import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/book.dart';
import '../../../widgets/book_widgets.dart';
import '../cubit/book_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookCubit()..init(),
      child: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) {
          if (state is BookShimmer) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is BookDetailView) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.read<BookCubit>().goBackToList();
                  },
                ),
                title: Text(state.book.title),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BookDetailCard(book: state.book),
              ),
            );
          }

          if (state is BookLoaded) {
            final sortType = state.sortType;

            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {}, // Non-functional
                ),
                title: const Text(
                  "Book Club Home",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.account_circle),
                    onPressed: () {}, // Non-functional
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.sort, size: 20),
                        const SizedBox(width: 6),
                        const Text("Sort by", style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 12),
                        ChoiceChip(
                          label: const Text("Author"),
                          selected: sortType == SortType.author,
                          onSelected: (_) =>
                              context.read<BookCubit>().sortByAuthor(),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text("Title"),
                          selected: sortType == SortType.title,
                          onSelected: (_) =>
                              context.read<BookCubit>().sortByTitle(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Books",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 180, // Adjust this height as needed
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: state.books.map((book) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                onTap: () {
                                  context.read<BookCubit>().showBookDetail(book);
                                },
                                child: BookImage(imageUrl: book.imageUrl),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Scaffold(
            body: Center(child: Text("Initializing...")),
          );
        },
      ),
    );
  }
}
