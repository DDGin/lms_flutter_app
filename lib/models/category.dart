class Category {
  int? id;
  String name;

  Category({this.id, required this.name});

  /// Tạo đối tượng từ JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name']);
  }

  /// Chuyển đối tượng sang JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  /// Kiểm tra dữ liệu hợp lệ (tương đương validate trong Sequelize)
  bool validate() {
    if (name.isEmpty || name.length < 3 || name.length > 100) {
      throw Exception('Tên danh mục phải từ 3 đến 100 ký tự');
    }
    return true;
  }

  List<Category> categories = [
    Category(id: 1, name: 'Văn học Việt Nam'),
    Category(id: 2, name: 'Văn học nước ngoài'),
    Category(id: 3, name: 'Fantasy'),
    Category(id: 4, name: 'Khoa học viễn tưởng'),
    Category(id: 5, name: 'Sách thiếu nhi'),
    Category(id: 6, name: 'Lịch sử'),
    Category(id: 7, name: 'Kinh dị'),
  ];
}
