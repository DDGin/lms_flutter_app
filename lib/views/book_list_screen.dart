import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/book_list_viewmodel.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookListViewModel()..fetchBooks(),
      child: Consumer<BookListViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.books.isEmpty) {
            return const Center(child: Text('Không có sách nào'));
          }
          return ListView.builder(
            itemCount: vm.books.length,
            itemBuilder: (context, index) {
              final book = vm.books[index];
              return ListTile(
                leading: Image.network(book.imageCover ?? ''),
                title: Text(book.title),
                subtitle: Text('ISBN: ${book.isbn}'),
              );
            },
          );
        },
      ),
    );
  }
}
