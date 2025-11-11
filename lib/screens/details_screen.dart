import 'package:flutter/material.dart';
import '../models/hotel.dart';
import 'booking_form.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/details';
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hotel = ModalRoute.of(context)!.settings.arguments as Hotel;
    final width = MediaQuery.of(context).size.width;
    final isLarge = width > 700;

    final List<String> images = hotel.images;

    return Scaffold(
      appBar: AppBar(title: Text(hotel.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🌅 Image slider section
            SizedBox(
              height: isLarge ? 380 : 250,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    itemCount: images.length,
                    onPageChanged: (index) =>
                        setState(() => _currentIndex = index),
                    itemBuilder: (context, index) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        transitionBuilder: (child, animation) =>
                            SlideTransition(
                              position: Tween<Offset>(
                                  begin: const Offset(1.0, 0.0),
                                  end: Offset.zero)
                                  .animate(animation),
                              child: child,
                            ),
                        child: Hero(
                          tag: '${hotel.id}-$index',
                          child: Image.network(
                            images[index],
                            key: ValueKey(images[index]),
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.indigo),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  // 🌈 Animated dots indicator
                  Positioned(
                    bottom: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                            (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: _currentIndex == index ? 24 : 8,
                          decoration: BoxDecoration(
                            color: _currentIndex == index
                                ? Colors.indigo
                                : Colors.white54,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🏨 Hotel details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(hotel.name,
                            style:
                            Theme.of(context).textTheme.headlineSmall)),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('₹ ${hotel.price.toStringAsFixed(0)}/night',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Row(children: [
                            Icon(Icons.star, color: Colors.amber[700]),
                            const SizedBox(width: 6),
                            Text(hotel.rating.toString())
                          ]),
                        ])
                  ],
                ),
                const SizedBox(height: 12),
                Text(hotel.location,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 12),
                Text(hotel.description),
                const SizedBox(height: 16),
                const Text('Amenities',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(spacing: 8, runSpacing: 8, children: const [
                  Chip(label: Text('Free WiFi')),
                  Chip(label: Text('Breakfast')),
                  Chip(label: Text('Swimming Pool')),
                  Chip(label: Text('Parking')),
                  Chip(label: Text('Gym Access')),
                  Chip(label: Text('Room Service')),
                ]),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.book_online),
                    label: const Text('Book Now'),
                    onPressed: () => Navigator.pushNamed(
                        context, BookingForm.routeName,
                        arguments: hotel),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
