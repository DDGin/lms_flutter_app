import 'package:flutter/foundation.dart';
import '../models/book.dart';

class BookListViewModel extends ChangeNotifier {
  List<Book> books = [];
  bool isLoading = false;

  Future<void> fetchBooks() async {
    isLoading = true;
    notifyListeners();

    // Giả lập lấy dữ liệu (hoặc gọi API ở đây)
    await Future.delayed(Duration(seconds: 1));
    books = books;

    isLoading = false;
    notifyListeners();
  }

  void searchBooks(String query) {
    books = books
        .where((b) => b.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
