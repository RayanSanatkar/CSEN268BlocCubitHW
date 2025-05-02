import 'package:flutter/material.dart';
import '../model/book.dart';

/// Displays only the book cover
class BookImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  const BookImage({super.key, required this.imageUrl, this.height = 150, this.width = 100,});

  @override
  Widget build(BuildContext context) {
    return Image.asset(imageUrl, height: height, width: width, fit: BoxFit.cover,);
  }
}

/// Displays the full book information
class BookDetailCard extends StatelessWidget {
  final Book book;

  const BookDetailCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookImage(imageUrl: book.imageUrl, height: 200, width: 130),
        const SizedBox(height: 10),
        Text(book.title,style: Theme.of(context).textTheme.titleLarge,),
        Text("by ${book.author}", style: Theme.of(context).textTheme.bodyMedium,),
        const SizedBox(height: 8),
        Text(book.description, style: Theme.of(context).textTheme.bodySmall,),
      ],
    );
  }
}
