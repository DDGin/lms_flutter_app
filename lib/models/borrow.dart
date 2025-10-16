class Borrow {
  int? id;
  DateTime borrowDate;
  DateTime? returnDate;
  DateTime? pickupDate;
  DateTime dueDate;
  String
  status; // REQUESTED, APPROVED, BORROWED, RETURNED, EXPIRED, REJECTED, CANCELLED
  int bookId;
  int borrowId;
  int? approverId;

  Borrow({
    this.id,
    required this.borrowDate,
    this.returnDate,
    this.pickupDate,
    required this.dueDate,
    this.status = 'REQUESTED',
    required this.bookId,
    required this.borrowId,
    this.approverId,
  });

  /// Tạo đối tượng từ JSON
  factory Borrow.fromJson(Map<String, dynamic> json) {
    return Borrow(
      id: json['id'],
      borrowDate: DateTime.parse(json['borrow_date']),
      returnDate: json['return_date'] != null
          ? DateTime.parse(json['return_date'])
          : null,
      pickupDate: json['pickup_date'] != null
          ? DateTime.parse(json['pickup_date'])
          : null,
      dueDate: DateTime.parse(json['due_date']),
      status: json['status'] ?? 'REQUESTED',
      bookId: json['book_id'],
      borrowId: json['borrow_id'],
      approverId: json['approver_id'],
    );
  }

  /// Chuyển đối tượng sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'borrow_date': borrowDate.toIso8601String(),
      'return_date': returnDate?.toIso8601String(),
      'pickup_date': pickupDate?.toIso8601String(),
      'due_date': dueDate.toIso8601String(),
      'status': status,
      'book_id': bookId,
      'borrow_id': borrowId,
      'approver_id': approverId,
    };
  }

  /// Kiểm tra hợp lệ (mô phỏng phần validate trong Sequelize)
  bool validate() {
    final now = DateTime.now();

    if (dueDate.isBefore(borrowDate)) {
      throw Exception('Ngày đến hạn phải sau ngày mượn');
    }

    if (returnDate != null && returnDate!.isBefore(borrowDate)) {
      throw Exception('Ngày trả phải sau ngày mượn');
    }

    if (pickupDate != null && pickupDate!.isBefore(borrowDate)) {
      throw Exception('Ngày lấy phải sau ngày mượn');
    }

    const allowedStatuses = [
      'REQUESTED',
      'APPROVED',
      'BORROWED',
      'RETURNED',
      'EXPIRED',
      'REJECTED',
      'CANCELLED',
    ];
    if (!allowedStatuses.contains(status)) {
      throw Exception('Trạng thái không hợp lệ: $status');
    }

    if (bookId <= 0) throw Exception('book_id không hợp lệ');
    if (borrowId <= 0) throw Exception('borrow_id không hợp lệ');

    if (borrowDate.isAfter(now)) {
      throw Exception('Ngày mượn không hợp lệ (trong tương lai)');
    }

    return true;
  }

  List<Borrow> borrows = [
    // 1. Yêu cầu vừa được tạo
    Borrow(
      id: 1,
      borrowDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 14)),
      status: 'REQUESTED',
      bookId: 1,
      // Chí Phèo
      borrowId: 3, // reader_peter
    ),

    // 2. Yêu cầu đã được duyệt, đang chờ lấy sách
    Borrow(
      id: 2,
      borrowDate: DateTime.now().subtract(const Duration(days: 1)),
      pickupDate: DateTime.now().add(const Duration(days: 2)),
      // Hạn chót để lấy sách
      dueDate: DateTime.now().add(const Duration(days: 15)),
      status: 'APPROVED',
      bookId: 3,
      // Harry Potter
      borrowId: 4,
      // reader_mary
      approverId: 2, // librarian_jane
    ),

    // 3. Sách đang được mượn
    Borrow(
      id: 3,
      borrowDate: DateTime.now().subtract(const Duration(days: 5)),
      pickupDate: DateTime.now().subtract(const Duration(days: 4)),
      // Đã lấy sách
      dueDate: DateTime.now().add(const Duration(days: 9)),
      status: 'BORROWED',
      bookId: 5,
      // Vang bóng một thời
      borrowId: 3,
      // reader_peter
      approverId: 5, // lib_david
    ),

    // 4. Sách đã được trả
    Borrow(
      id: 4,
      borrowDate: DateTime.parse('2025-09-01T10:00:00Z'),
      pickupDate: DateTime.parse('2025-09-02T11:00:00Z'),
      returnDate: DateTime.parse('2025-09-14T15:30:00Z'),
      dueDate: DateTime.parse('2025-09-15T10:00:00Z'),
      status: 'RETURNED',
      bookId: 2,
      // Trại súc vật
      borrowId: 4,
      // reader_mary
      approverId: 2, // librarian_jane
    ),

    // 5. Yêu cầu bị từ chối
    Borrow(
      id: 5,
      borrowDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 14)),
      status: 'REJECTED',
      bookId: 1,
      // Chí Phèo
      borrowId: 4,
      // reader_mary
      approverId: 5, // lib_david
    ),

    // 6. Yêu cầu đã hết hạn (không đến lấy sách)
    Borrow(
      id: 6,
      borrowDate: DateTime.now().subtract(const Duration(days: 4)),
      pickupDate: DateTime.now().subtract(const Duration(days: 1)),
      // Hạn chót để lấy sách đã qua
      dueDate: DateTime.now().add(const Duration(days: 10)),
      status: 'EXPIRED',
      bookId: 3,
      // Harry Potter
      borrowId: 3,
      // reader_peter
      approverId: 2, // librarian_jane
    ),
  ];
}
