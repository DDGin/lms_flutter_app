class Author {
  int? id;
  String name;

  Author({this.id, required this.name});

  // Tạo đối tượng từ JSON
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(id: json['id'], name: json['name']);
  }

  // Chuyển đối tượng sang JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  // Hàm kiểm tra dữ liệu hợp lệ (giống validate trong Sequelize)
  bool validate() {
    if (name.isEmpty || name.length < 3 || name.length > 100) {
      throw Exception('Tên tác giả phải từ 3 đến 100 ký tự');
    }
    return true;
  }

  List<Author> authors = [
    Author(id: 1, name: 'Nam Cao'), // [3]
    Author(id: 2, name: 'William Shakespeare'), // [2]
    Author(id: 3, name: 'George Orwell'), // [1]
    Author(id: 4, name: 'Nguyễn Tuân'), // [3]
    Author(id: 5, name: 'Ernest Hemingway'), // [8]
    Author(id: 6, name: 'J.K. Rowling'), // [4, 7]
    Author(id: 7, name: 'Victor Hugo'), // [2, 8]
  ];
}
