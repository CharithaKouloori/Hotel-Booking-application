import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';

class ConfirmedBooking extends StatelessWidget {
  static const routeName = '/confirmed';
  const ConfirmedBooking({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = Provider.of<BookingProvider>(context).lastBooking;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Booking Confirmed'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image (same as homepage)
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1400&q=80',
              fit: BoxFit.cover,
            ),
          ),

          // Dark overlay for contrast
          Container(color: Colors.black.withOpacity(0.55)),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
              child: booking == null
                  ? Center(
                child: Card(
                  color: Colors.white.withOpacity(0.95),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('No booking found',
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => Navigator.popUntil(
                              context, ModalRoute.withName('/')),
                          child: const Text('Back to Home'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
                  : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Card(
                    color: Colors.white.withOpacity(0.96),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.indigo.shade50,
                                child: Icon(Icons.check_circle,
                                    size: 36,
                                    color: Colors.green.shade700),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Booking Confirmed!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                          fontWeight:
                                          FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text('Thank you, ${booking.name}',
                                        style: TextStyle(
                                            color: Colors.grey[700])),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Hotel info
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  booking.hotel.imageUrl,
                                  width: 110,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      Container(
                                          width: 110,
                                          height: 80,
                                          color: Colors.grey[300]),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(booking.hotel.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    const SizedBox(height: 6),
                                    Text(booking.hotel.location,
                                        style: const TextStyle(
                                            color: Colors.black54)),
                                    const SizedBox(height: 8),
                                    Text('Room: ${booking.roomType}',
                                        style: const TextStyle(
                                            fontWeight:
                                            FontWeight.w600)),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          // Details grid
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _InfoChip(
                                  icon: Icons.date_range,
                                  label: 'Check-in',
                                  value: _format(booking.checkIn)),
                              _InfoChip(
                                  icon: Icons.date_range,
                                  label: 'Check-out',
                                  value: _format(booking.checkOut)),
                              _InfoChip(
                                  icon: Icons.people,
                                  label: 'Guests',
                                  value: '${booking.guests}'),
                              _InfoChip(
                                  icon: Icons.star,
                                  label: 'Rating',
                                  value:
                                  booking.hotel.rating.toString()),
                            ],
                          ),

                          const SizedBox(height: 18),

                          // Price
                          Row(
                            children: [
                              const Text('Total:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(width: 8),
                              Text(
                                '₹ ${booking.totalPrice.toStringAsFixed(0)}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // ✅ Only the "Done" button remains
                          ElevatedButton(
                            onPressed: () {
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/'));
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(12)),
                              backgroundColor: Colors.indigo,
                            ),
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _format(DateTime d) => '${d.day}/${d.month}/${d.year}';
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoChip(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.indigo),
          const SizedBox(width: 8),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label,
                style: const TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
          ]),
        ],
      ),
    );
  }
}