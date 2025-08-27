class PaymentResponse {
  final int id;
  final int bookingId;
  final String status;
  final int amount;
  // Add other fields as per PaymentOut schema

  PaymentResponse({
    required this.id,
    required this.bookingId,
    required this.status,
    required this.amount,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      id: json['id'],
      bookingId: json['booking_id'],
      status: json['status'],
      amount: json['amount'],
    );
  }
}
