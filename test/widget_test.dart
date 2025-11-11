import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelbooking1/main.dart';

void main() {
  testWidgets('App loads and shows home screen', (WidgetTester tester) async {
    // Build the app and trigger a frame
    await tester.pumpWidget(const HotelBookingApp());

    // Verify that the home screen loads and contains key UI elements
    expect(find.text('HotelBook'), findsOneWidget);
    expect(find.text('Hotels'), findsWidgets); // finds multiple "Hotels" (e.g., drawer/list)
    expect(find.text('Contact'), findsWidgets); // matches "Contact" or "Contact Us"
  });
}
