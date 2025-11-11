import 'package:flutter/foundation.dart';
import '../models/hotel.dart';

class Booking {
  final Hotel hotel;
  final String name;
  final String email;
  final String roomType;
  final int guests;
  final DateTime checkIn;
  final DateTime checkOut;
  final double totalPrice;

  Booking({
    required this.hotel,
    required this.name,
    required this.email,
    required this.roomType,
    required this.guests,
    required this.checkIn,
    required this.checkOut,
    required this.totalPrice,
  });
}

class BookingProvider extends ChangeNotifier {
  Booking? _lastBooking;

  // ✅ Add this variable to fix your error
  String? _selectedRoomType;

  Booking? get lastBooking => _lastBooking;

  // ✅ Getter and setter for selected room type
  String? get selectedRoomType => _selectedRoomType;

  void selectRoomType(String type) {
    _selectedRoomType = type;
    notifyListeners();
  }

  void clearSelectedRoom() {
    _selectedRoomType = null;
    notifyListeners();
  }

  void createBooking({
    required Hotel hotel,
    required String name,
    required String email,
    required String roomType,
    required int guests,
    required DateTime checkIn,
    required DateTime checkOut,
  }) {
    final nights = checkOut.difference(checkIn).inDays;
    final nightsSafe = nights > 0 ? nights : 1;

    // adjust total price (simple example)
    final totalPrice = hotel.price * nightsSafe * guests;

    _lastBooking = Booking(
      hotel: hotel,
      name: name,
      email: email,
      roomType: roomType,
      guests: guests,
      checkIn: checkIn,
      checkOut: checkOut,
      totalPrice: totalPrice,
    );

    notifyListeners();
  }

  void clear() {
    _lastBooking = null;
    _selectedRoomType = null;
    notifyListeners();
  }
}
