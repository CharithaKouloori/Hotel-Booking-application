import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/hotel.dart';
import '../providers/booking_provider.dart';

class BookingForm extends StatefulWidget {
  static const routeName = '/booking';
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  int _guests = 1;
  DateTime? _checkIn;
  DateTime? _checkOut;

  // local selected room (keeps UI responsive)
  String? _localSelectedRoom;

  @override
  Widget build(BuildContext context) {
    final hotel = ModalRoute.of(context)!.settings.arguments as Hotel?;
    final provider = Provider.of<BookingProvider>(context, listen: false);

    // Use provider-selected room if present, otherwise local or hotel's first room or 'Standard'
    final String selectedRoom = provider.selectedRoomType ?? _localSelectedRoom ?? (hotel?.roomTypes.first ?? 'Standard');

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Book - ${hotel?.name ?? ''}'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image (same look as home)
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1400&q=80',
              fit: BoxFit.cover,
            ),
          ),
          // dark overlay for contrast
          Container(color: Colors.black.withOpacity(0.55)),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Column(
                children: [
                  // Top info card with hotel summary
                  Card(
                    color: Colors.white.withOpacity(0.95),
                    elevation: 6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              hotel?.imageUrl ?? '',
                              width: 110,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(width: 110, height: 80, color: Colors.grey[300]),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(hotel?.name ?? 'Selected Hotel', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6),
                                Text(hotel?.location ?? '', style: const TextStyle(color: Colors.black54)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Text('Room: ', style: TextStyle(fontWeight: FontWeight.w600)),
                                    const SizedBox(width: 8),
                                    // Room type dropdown shown here as a compact chip-like control
                                    _buildRoomTypeDropdown(hotel, provider, selectedRoom),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Form card
                  Card(
                    color: Colors.white.withOpacity(0.95),
                    elevation: 6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Full Name',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
                              onSaved: (v) => _name = v?.trim(),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) return 'Enter email';
                                if (!v.contains('@') || !v.contains('.')) return 'Enter valid email';
                                return null;
                              },
                              onSaved: (v) => _email = v?.trim(),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(child: _datePickerField('Check-in', _checkIn, onPick: (d) => setState(() => _checkIn = d))),
                                const SizedBox(width: 8),
                                Expanded(child: _datePickerField('Check-out', _checkOut, onPick: (d) => setState(() => _checkOut = d))),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Text('Guests:', style: TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(width: 12),
                                DropdownButton<int>(
                                  value: _guests,
                                  items: List.generate(6, (i) => i + 1).map((g) => DropdownMenuItem(value: g, child: Text('$g'))).toList(),
                                  onChanged: (v) => setState(() => _guests = v ?? 1),
                                )
                              ],
                            ),

                            const SizedBox(height: 18),

                            // Attractive gradient confirm button (full width)
                            _buildConfirmButton(context, hotel, selectedRoom),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomTypeDropdown(Hotel? hotel, BookingProvider provider, String selectedRoom) {
    final types = hotel?.roomTypes ?? ['Standard'];
    // small container to house DropdownButton
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
      child: DropdownButton<String>(
        value: selectedRoom,
        underline: const SizedBox(),
        items: types.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
        onChanged: (newType) {
          if (newType == null) return;
          // update provider and local state
          Provider.of<BookingProvider>(context, listen: false).selectRoomType(newType);
          setState(() => _localSelectedRoom = newType);
        },
      ),
    );
  }

  Widget _datePickerField(String label, DateTime? value, {required void Function(DateTime) onPick}) {
    return InkWell(
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(context: context, initialDate: value ?? now, firstDate: now, lastDate: DateTime(now.year + 2));
        if (picked != null) onPick(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        child: Text(value == null ? 'Select' : '${value.day}/${value.month}/${value.year}'),
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context, Hotel? hotel, String roomType) {
    return GestureDetector(
      onTap: () => _submit(context, hotel, roomType),
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF6A11CB), Color(0xFF2575FC)]),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 6))],
        ),
        child: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.book_online, color: Colors.white),
              SizedBox(width: 10),
              Text('Confirm Booking', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context, Hotel? hotel, String roomType) {
    if (!_formKey.currentState!.validate()) return;
    if (_checkIn == null || _checkOut == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pick check-in and check-out dates')));
      return;
    }
    if (_checkOut!.isBefore(_checkIn!)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Check-out must be after check-in')));
      return;
    }
    _formKey.currentState!.save();
    if (hotel == null) return;

    final provider = Provider.of<BookingProvider>(context, listen: false);
    // create booking with chosen roomType
    provider.createBooking(
      hotel: hotel,
      name: _name!,
      email: _email!,
      guests: _guests,
      checkIn: _checkIn!,
      checkOut: _checkOut!,
      roomType: roomType,
    );

    Navigator.pushNamed(context, '/confirmed');
  }
}