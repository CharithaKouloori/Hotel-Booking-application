import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../widgets/hotel_card.dart';

class HotelsList extends StatefulWidget {
  static const routeName = '/hotels';
  const HotelsList({super.key});

  @override
  State<HotelsList> createState() => _HotelsListState();
}

class _HotelsListState extends State<HotelsList>
    with SingleTickerProviderStateMixin {
  String? filter;
  double minRating = 0;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    // entrance animation for list
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.03), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = sampleHotels.where((h) {
      if (h.rating < minRating) return false;
      if (filter != null && filter!.isNotEmpty && !h.name.toLowerCase().contains(filter!.toLowerCase())) return false;
      return true;
    }).toList();

    return Scaffold(
      // start content below the app bar so controls don't overlap
      appBar: AppBar(
        title: const Text('Explore Hotels'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // attractive background (kept but darker overlay)
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?auto=format&fit=crop&w=1400&q=80',
              fit: BoxFit.cover,
            ),
          ),
          Container(color: Colors.black.withOpacity(0.45)),

          SafeArea(
            child: Column(
              children: [
                // search + filter
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 8)],
                          ),
                          child: TextField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'Search hotels...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                            onChanged: (v) => setState(() => filter = v),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 8)],
                        ),
                        child: IconButton(
                          onPressed: () => _showFilterDialog(context),
                          icon: const Icon(Icons.filter_list),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                // animated list
                Expanded(
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      itemCount: filtered.length,
                      itemBuilder: (context, i) {
                        // small stagger using Delay (simple approach)
                        return AnimatedOpacity(
                          duration: Duration(milliseconds: 400 + (i * 80)),
                          opacity: 1,
                          child: filtered.isEmpty
                              ? const SizedBox.shrink()
                              : HotelCard(hotel: filtered[i]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (c) {
        double temp = minRating;
        return AlertDialog(
          title: const Text('Minimum rating'),
          content: StatefulBuilder(builder: (context, setStateSB) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Slider(value: temp, min: 0, max: 5, divisions: 5, label: temp.toStringAsFixed(1), onChanged: (v) => setStateSB(() => temp = v)),
                const SizedBox(height: 8),
                Text('Showing ${temp >= 1 ? '${temp.toStringAsFixed(1)}+' : 'All'} stars'),
              ],
            );
          }),
          actions: [
            TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() => minRating = temp);
                Navigator.pop(c);
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }
}
