import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/booking_provider.dart';
import 'screens/home_screen.dart';
import 'screens/hotels_list.dart';
import 'screens/details_screen.dart';
import 'screens/booking_form.dart';
import 'screens/confirmed_booking.dart';
//import 'screens/profile_screen.dart';
import 'screens/contact_us.dart';
//import 'screens/about_us.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: const HotelBookingApp(),
    ),
  );
}

class HotelBookingApp extends StatelessWidget {
  const HotelBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HotelBook - UI',

      // ✅ Simple, clean Material Theme (no cardTheme)
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),

      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),

      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        HotelsList.routeName: (_) => const HotelsList(),
        DetailsScreen.routeName: (_) => const DetailsScreen(),
        BookingForm.routeName: (_) => const BookingForm(),
        ConfirmedBooking.routeName: (_) => const ConfirmedBooking(),
       // ProfileScreen.routeName: (_) => const ProfileScreen(),
        ContactUs.routeName: (_) => const ContactUs(),
       // AboutUs.routeName: (_) => const AboutUs(),
      },
    );
  }
}
