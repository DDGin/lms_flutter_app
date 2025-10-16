class Account {
  int? id;
  String username;
  String password;
  String? role; // "Admin", "Librarian" hoặc "Reader"
  int? userId;

  Account({
    this.id,
    required this.username,
    required this.password,
    this.role,
    this.userId,
  });

  // Tạo từ JSON (ví dụ khi lấy từ API hoặc DB)
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      role: json['role'],
      userId: json['user_id'],
    );
  }

  // Chuyển sang JSON (ví dụ khi gửi API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'role': role,
      'user_id': userId,
    };
  }

  // Có thể thêm validate giống Sequelize
  bool validate() {
    if (username.isEmpty || username.length < 3 || username.length > 25) {
      throw Exception('Tên đăng nhập phải từ 3–25 ký tự');
    }
    if (password.isEmpty || password.length < 6 || password.length > 100) {
      throw Exception('Mật khẩu phải từ 6–100 ký tự');
    }
    return true;
  }

  // Lưu ý: Trong một ứng dụng thực tế, bạn nên lưu trữ mật khẩu đã được băm.
  // Ví dụ: 'hashed_password_123' là một chuỗi đại diện cho mật khẩu đã băm.

  List<Account> accounts = [
    Account(
      id: 1,
      username: 'admin_user',
      password: 'hashed_password_for_admin',
      role: 'Admin',
      userId: 1,
    ),
    Account(
      id: 2,
      username: 'librarian_jane',
      password: 'hashed_password_for_jane',
      role: 'Librarian',
      userId: 2,
    ),
    Account(
      id: 3,
      username: 'reader_peter',
      password: 'hashed_password_for_peter',
      role: 'Reader',
      userId: 3,
    ),
    Account(
      id: 4,
      username: 'reader_mary',
      password: 'hashed_password_for_mary',
      role: 'Reader',
      userId: 4,
    ),
    Account(
      id: 5,
      username: 'lib_david',
      password: 'hashed_password_for_david',
      role: 'Librarian',
      userId: 5,
    ),
  ];
}
