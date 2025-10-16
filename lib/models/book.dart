class Book {
  int? id;
  String title;
  String isbn;
  int publishedYear;
  int quantityTotal;
  int quantityAvailable;
  String? description;
  String? imageCover;
  int categoryId;
  int authorId;
  bool isDeleted;

  Book({
    this.id,
    required this.title,
    required this.isbn,
    required this.publishedYear,
    required this.quantityTotal,
    required this.quantityAvailable,
    this.description,
    this.imageCover,
    required this.categoryId,
    required this.authorId,
    this.isDeleted = false,
  });

  // Tạo đối tượng từ JSON
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      isbn: json['isbn'],
      publishedYear: json['published_year'],
      quantityTotal: json['quantity_total'],
      quantityAvailable: json['quantity_available'],
      description: json['description'],
      imageCover: json['image_cover'],
      categoryId: json['category_id'],
      authorId: json['author_id'],
      isDeleted: json['is_deleted'] ?? false,
    );
  }

  // Chuyển đối tượng sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isbn': isbn,
      'published_year': publishedYear,
      'quantity_total': quantityTotal,
      'quantity_available': quantityAvailable,
      'description': description,
      'image_cover': imageCover,
      'category_id': categoryId,
      'author_id': authorId,
      'is_deleted': isDeleted,
    };
  }

  // Hàm kiểm tra dữ liệu hợp lệ (mô phỏng validate trong Sequelize)
  bool validate() {
    final currentYear = DateTime.now().year;

    if (title.isEmpty || title.length < 1 || title.length > 200) {
      throw Exception('Tiêu đề phải từ 1 đến 200 ký tự');
    }
    if (isbn.isEmpty || isbn.length < 10 || isbn.length > 13) {
      throw Exception('ISBN phải từ 10 đến 13 ký tự');
    }
    if (publishedYear < 1500 || publishedYear > currentYear) {
      throw Exception('Năm xuất bản phải trong khoảng 1500–$currentYear');
    }
    if (quantityTotal < 0) {
      throw Exception('Tổng số lượng phải ≥ 0');
    }
    if (quantityAvailable < 0) {
      throw Exception('Số lượng có sẵn phải ≥ 0');
    }
    if (imageCover != null && !Uri.parse(imageCover!).isAbsolute) {
      throw Exception('Ảnh bìa phải là một URL hợp lệ');
    }

    return true;
  }

  List<Book> books = [
    Book(
      id: 1,
      title: 'Chí Phèo',
      isbn: '978-604-969-992-1',
      publishedYear: 1941,
      quantityTotal: 10,
      quantityAvailable: 7,
      description:
          'Tác phẩm kinh điển của văn học hiện thực phê phán Việt Nam.',
      imageCover:
          'https://images.unsplash.com/photo-1593349319623-0a6121b0663f?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      categoryId: 1,
      // Giả sử ID 1 là "Văn học Việt Nam"
      authorId: 1,
      // Giả sử ID 1 là "Nam Cao"
      isDeleted: false,
    ),
    Book(
      id: 2,
      title: 'Trại súc vật',
      isbn: '978-0-452-28423-4',
      publishedYear: 1945,
      quantityTotal: 5,
      quantityAvailable: 5,
      description:
          'Một tiểu thuyết ngụ ngôn về sự nguy hiểm của chủ nghĩa toàn trị.',
      imageCover:
          'https://images.unsplash.com/photo-1593349319623-0a6121b0663f?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      categoryId: 2,
      // Giả sử ID 2 là "Văn học nước ngoài"
      authorId: 3,
      // Giả sử ID 3 là "George Orwell"
      isDeleted: false,
    ),
    Book(
      id: 3,
      title: 'Harry Potter và Hòn đá Phù thủy',
      isbn: '978-0-7475-3269-9',
      publishedYear: 1997,
      quantityTotal: 15,
      quantityAvailable: 11,
      description:
          'Tập đầu tiên trong loạt tiểu thuyết giả tưởng nổi tiếng về cậu bé phù thủy Harry Potter.',
      imageCover:
          'https://images.unsplash.com/photo-1593349319623-0a6121b0663f?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      categoryId: 3,
      // Giả sử ID 3 là "Fantasy"
      authorId: 6,
      // Giả sử ID 6 là "J.K. Rowling"
      isDeleted: false,
    ),
    Book(
      id: 4,
      title: 'Ông già và biển cả',
      isbn: '978-0-684-80122-3',
      publishedYear: 1952,
      quantityTotal: 8,
      quantityAvailable: 3,
      description:
          'Câu chuyện về một ngư dân già người Cuba và cuộc đấu tranh của ông với một con cá marlin khổng lồ.',
      imageCover:
          'https://images.unsplash.com/photo-1593349319623-0a6121b0663f?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      categoryId: 2,
      // Giả sử ID 2 là "Văn học nước ngoài"
      authorId: 5,
      // Giả sử ID 5 là "Ernest Hemingway"
      isDeleted: true, // Ví dụ một cuốn sách đã bị xóa mềm
    ),
    Book(
      id: 5,
      title: 'Vang bóng một thời',
      isbn: '978-604-86-2184-7',
      publishedYear: 1940,
      quantityTotal: 6,
      quantityAvailable: 6,
      description:
          'Tuyển tập truyện ngắn về những vẻ đẹp của văn hóa truyền thống Việt Nam đang dần mai một.',
      imageCover:
          'https://images.unsplash.com/photo-1593349319623-0a6121b0663f?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      categoryId: 1,
      // Giả sử ID 1 là "Văn học Việt Nam"
      authorId: 4,
      // Giả sử ID 4 là "Nguyễn Tuân"
      isDeleted: false,
    ),
  ];
}
