class BookingService {
  final String? userId;
  final String? userName;
  final String? userEmail;
  final String? userPhoneNumber;
  final String? serviceId;
  final String serviceName;
  final int serviceDuration;
  final double? servicePrice;
  final DateTime bookingStart;
  final DateTime bookingEnd;

  BookingService({
    this.userId,
    this.userName,
    this.userEmail,
    this.userPhoneNumber,
    this.serviceId,
    required this.serviceName,
    required this.serviceDuration,
    this.servicePrice,
    required this.bookingStart,
    required this.bookingEnd,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userPhoneNumber': userPhoneNumber,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'serviceDuration': serviceDuration,
      'servicePrice': servicePrice,
      'bookingStart': bookingStart.toIso8601String(),
      'bookingEnd': bookingEnd.toIso8601String(),
    };
  }
}
