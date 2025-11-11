import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  static const routeName = '/contact';
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _email, _message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLarge = size.width > 700;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Contact Us'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 🌅 Background image (same as homepage)
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1400&q=80',
              fit: BoxFit.cover,
            ),
          ),
          Container(color: Colors.black.withOpacity(0.5)), // dark overlay

          // 🌟 Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🏨 Organization Info Card
                  Card(
                    color: Colors.white.withOpacity(0.9),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            'TranquilStay Hotels',
                            style: TextStyle(
                              fontSize: isLarge ? 28 : 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo[900],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Your trusted partner for luxury stays across India.\nWe ensure comfort, elegance, and unforgettable memories.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black87),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.location_on, color: Colors.redAccent),
                              SizedBox(width: 6),
                              Text('123 Beach Avenue, Goa, India'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.phone, color: Colors.green),
                              SizedBox(width: 6),
                              Text('+91 98765 43210'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.email, color: Colors.blueAccent),
                              SizedBox(width: 6),
                              Text('support@tranquilstay.com'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.facebook, color: Colors.blue),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.camera_alt, color: Colors.purple),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.travel_explore,
                                    color: Colors.indigo),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 📝 Feedback Form Title
                  const Text(
                    'We’d love to hear from you!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 📨 Feedback Form
                  Card(
                    color: Colors.white.withOpacity(0.95),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Name',
                                prefixIcon: const Icon(Icons.person),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (v) =>
                              v == null || v.isEmpty ? 'Enter your name' : null,
                              onSaved: (v) => _name = v,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: const Icon(Icons.email),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (v) => (v == null || !v.contains('@'))
                                  ? 'Enter a valid email'
                                  : null,
                              onSaved: (v) => _email = v,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              maxLines: 4,
                              decoration: InputDecoration(
                                labelText: 'Message / Feedback',
                                prefixIcon: const Icon(Icons.message),
                                alignLabelWithHint: true,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (v) =>
                              v == null || v.isEmpty ? 'Enter a message' : null,
                              onSaved: (v) => _message = v,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton.icon(
                                onPressed: _submit,
                                icon: const Icon(Icons.send),
                                label: const Text(
                                  'Send Message',
                                  style: TextStyle(fontSize: 18,color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: Colors.indigo[600],
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
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

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you for your feedback!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
    _formKey.currentState!.reset();
  }
}
