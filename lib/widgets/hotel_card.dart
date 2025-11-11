import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../screens/details_screen.dart';

class HotelCard extends StatelessWidget {
  final Hotel hotel;
  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isLarge = width > 600;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DetailsScreen.routeName,
        arguments: hotel,
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Hero(
              tag: hotel.id,
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                child: Image.network(
                  hotel.imageUrl,
                  width: isLarge ? 220 : 120,
                  height: isLarge ? 150 : 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _HotelCardContent(hotel: hotel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HotelCardContent extends StatelessWidget {
  final Hotel hotel;
  const _HotelCardContent({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hotel.name, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.location_on, size: 14),
            const SizedBox(width: 4),
            Expanded(child: Text(hotel.location)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.star, size: 16, color: Colors.amber.shade700),
            const SizedBox(width: 6),
            Text(hotel.rating.toString()),
            const Spacer(),
            Text('₹ ${hotel.price.toStringAsFixed(0)}/night',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
