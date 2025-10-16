class Fine {
  int? id;
  double amount;
  bool isPaid;
  int borrowId;

  Fine({
    this.id,
    required this.amount,
    this.isPaid = false,
    required this.borrowId,
  });

  /// Tạo đối tượng từ JSON
  factory Fine.fromJson(Map<String, dynamic> json) {
    return Fine(
      id: json['id'],
      amount: (json['amount'] is int)
          ? (json['amount'] as int).toDouble()
          : double.parse(json['amount'].toString()),
      isPaid: json['isPaid'] ?? json['is_paid'] ?? false,
      borrowId: json['borrow_id'],
    );
  }

  /// Chuyển đối tượng sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'is_paid': isPaid,
      'borrow_id': borrowId,
    };
  }

  /// Kiểm tra dữ liệu hợp lệ (mô phỏng validate trong Sequelize)
  bool validate() {
    if (amount < 0) {
      throw Exception('Số tiền phạt phải lớn hơn hoặc bằng 0');
    }
    return true;
  }

  List<Fine> fines = [
    Fine(id: 1, amount: 15.50, isPaid: false, borrowId: 101),
    Fine(id: 2, amount: 5.00, isPaid: true, borrowId: 102),
    Fine(id: 3, amount: 25.75, isPaid: false, borrowId: 103),
    Fine(id: 4, amount: 10.00, isPaid: true, borrowId: 104),
    Fine(id: 5, amount: 7.25, isPaid: false, borrowId: 105),
  ];
}
