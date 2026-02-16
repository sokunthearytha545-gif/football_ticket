class TicketModel {
  final String bookingID;
  final String location;
  final String date;
  final String time;
  final double ticketPrice;
  final String team1;
  final String team2;
  final String team1VsTeam2;
  final String ticketType;
  final int qty;
  final String status;
  // final String createdAt;
  final String paymentMethod;
  final String accountNumber;
  final String accountName;
  final String referenceNumber;
  TicketModel({
    //this.createdAt = "",
    required this.bookingID,
    required this.location,
    required this.date,
    required this.time,
    required this.ticketPrice,
    required this.team1,
    required this.team2,
    required this.team1VsTeam2,
    required this.ticketType,
    required this.qty,
    required this.status,
    required this.paymentMethod,
    required this.accountNumber,
    required this.accountName,
    required this.referenceNumber,
  });
  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      // createdAt: (json['created_at']),
      bookingID: json['booking_id']?.toString() ?? '',
      location: json['location'] ?? "",
      date: json['date'] ?? "",
      time: json['time'] ?? "",
      ticketPrice: (json['ticket_price'] as num?)?.toDouble() ?? 0.0,
      ticketType: json['ticket_type'] ?? "",
      qty: json['qty'] ?? 0,
      status: json['status'] ?? "",
      team1: json['team1'] ?? "",
      team2: json['team2'] ?? "",
      team1VsTeam2: json['team1_vs_team2'] ?? "",
      paymentMethod: json['payment_method'] ?? "",
      accountNumber: json['account_number'] ?? "",
      accountName: json['account_name'] ?? "",
      referenceNumber: json['reference_number'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingID,
      'location': location,
      'date': date,
      'time': time,
      'ticket_price': ticketPrice,
      'ticket_type': ticketType,
      'qty': qty,
      'status': status,
      'team1': team1,
      'team2': team2,
      'team1_vs_team2': team1VsTeam2,
      'payment_method': paymentMethod,
      'account_number': accountNumber,
      'account_name': accountName,
      'reference_number': referenceNumber,
    };
  }
}
