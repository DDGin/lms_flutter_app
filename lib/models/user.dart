class User {
  int? id;
  String fullname;
  String email;
  String address;
  String phone;

  User({
    this.id,
    required this.fullname,
    required this.email,
    required this.address,
    required this.phone,
  });

  /// Tạo đối tượng từ JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
    );
  }

  /// Chuyển đối tượng sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'address': address,
      'phone': phone,
    };
  }

  /// Kiểm tra dữ liệu hợp lệ (mô phỏng validate trong Sequelize)
  bool validate() {
    if (fullname.isEmpty || fullname.length < 3 || fullname.length > 100) {
      throw Exception('Họ tên phải từ 3 đến 100 ký tự');
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      throw Exception('Email không hợp lệ');
    }

    if (address.isEmpty || address.length < 5 || address.length > 200) {
      throw Exception('Địa chỉ phải từ 5 đến 200 ký tự');
    }

    final phoneRegex = RegExp(r'^[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(phone)) {
      throw Exception('Số điện thoại không hợp lệ (phải gồm 10–15 chữ số)');
    }

    return true;
  }

  List<User> users = [
    User(
      id: 1,
      fullname: 'John Doe',
      email: 'john.doe@example.com',
      address: '123 Main St, Anytown, USA',
      phone: '555-123-4567',
    ),
    User(
      id: 2,
      fullname: 'Jane Smith',
      email: 'jane.smith@example.com',
      address: '456 Oak Ave, Sometown, USA',
      phone: '555-987-6543',
    ),
    User(
      id: 3,
      fullname: 'Peter Jones',
      email: 'peter.jones@example.com',
      address: '789 Pine Ln, Yourtown, USA',
      phone: '555-555-1212',
    ),
    User(
      id: 4,
      fullname: 'Mary Johnson',
      email: 'mary.j@example.com',
      address: '101 Maple Dr, Heretown, USA',
      phone: '555-222-3344',
    ),
    User(
      id: 5,
      fullname: 'David Williams',
      email: 'd.williams@example.com',
      address: '212 Birch Rd, Their-town, USA',
      phone: '555-867-5309',
    ),
  ];
}
