import 'package:flutter/material.dart';
import 'hotels_list.dart';
import 'contact_us.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLarge = size.width > 600;

    return Scaffold(
      body: Stack(
        children: [
          // 🌆 Background Image
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1350&q=80',
              fit: BoxFit.cover,
            ),
          ),
          // 🖤 Dark overlay for better contrast
          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          // 🌟 Content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ✨ App Title
                  Text(
                    'TranquilStay Hotels',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isLarge ? 48 : 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.6),
                          blurRadius: 6,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Find your perfect getaway with ease.',
                    style: TextStyle(
                      fontSize: isLarge ? 20 : 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // 🏨 View Hotels Button
                  _buildGradientButton(
                    context,
                    label: 'View Hotels',
                    icon: Icons.hotel,
                    onPressed: () =>
                        Navigator.pushNamed(context, HotelsList.routeName),
                  ),

                  const SizedBox(height: 20),

                  // 📞 Contact Us Button
                  _buildGradientButton(
                    context,
                    label: 'Contact Us',
                    icon: Icons.contact_mail,
                    onPressed: () =>
                        Navigator.pushNamed(context, ContactUs.routeName),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🌈 Gradient button builder
  Widget _buildGradientButton(BuildContext context,
      {required String label,
        required IconData icon,
        required VoidCallback onPressed}) {
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(3, 3),
          )
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        icon: Icon(icon, size: 26, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
