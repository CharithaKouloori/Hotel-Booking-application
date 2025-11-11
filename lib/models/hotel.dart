class Hotel {
  final String id;
  final String name;
  final String location;
  final double price;
  final double rating;
  final String description;

  // ✅ Now supports multiple images
  final List<String> images;

  // ✅ Keep room types
  final List<String> roomTypes;

  Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.description,
    required this.images,
    required this.roomTypes,
  });

  // ✅ Backward compatibility — still allows you to use hotel.imageUrl
  String get imageUrl => images.first;
}

// ✅ Sample data (3 images per hotel)
List<Hotel> sampleHotels = [
  Hotel(
    id: 'h1',
    name: 'Ocean View Resort',
    location: 'Goa, India',
    price: 4500,
    rating: 3.6,
    description:
    'A beautiful beachfront resort offering stunning sea views and luxury rooms with balconies overlooking the ocean.',
    images: [
      'https://cf.bstatic.com/xdata/images/hotel/max1024x768/612731999.jpg?k=a8dfe6a610273dd8e4b6501a1a897fc53c1cd6495f8f01da3f559fefb1911012&o=',
      'https://pix10.agoda.net/hotelImages/392569/-1/1283a2f110fb49030545e95f6085eb18.jpg?ce=0&s=414x232',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHP-FV-viup_7eilICp-SggNMjUes35-wJ6A&s',
    ],
    roomTypes: ['Standard', 'Deluxe', 'Sea View Suite'],
  ),
  Hotel(
    id: 'h2',
    name: 'Mountain Lodge',
    location: 'Manali, India',
    price: 3500,
    rating: 2.8,
    description:
    'A cozy lodge surrounded by pine forests and snow-capped peaks. Enjoy bonfires, mountain treks, and local cuisine.',
    images: [
      'https://cf.bstatic.com/xdata/images/hotel/max1024x768/217323026.jpg?k=0d4a57bb513611b6831edb48604c96e2254a67f45383ed4f3640120697556820&o=',
      'https://pix10.agoda.net/hotelImages/287/287718/287718_19102316070082388236.jpg?ca=9&ce=1&s=414x232',
      'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/6f/fd/27/sunshine-mountain-lodge.jpg?w=700&h=-1&s=1',
    ],
    roomTypes: ['Standard', 'Family', 'Premium Cabin'],
  ),
  Hotel(
    id: 'h3',
    name: 'Urban Stay',
    location: 'Bengaluru, India',
    price: 3000,
    rating: 4.2,
    description:
    'Modern comfort in the heart of the city. Perfect for business and leisure travelers, with easy access to transit.',
    images: [
      'https://cf.bstatic.com/xdata/images/hotel/max1024x768/95544077.jpg?k=6e27b5ab706fb568f9250842bf9c7c6897da0267488ada6f5e162cbaba70d1d9&o=',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSN_YfrkU1eJbmdYxTCe23ieUMUiuAmZMKJYw&s',
      'https://cf.bstatic.com/xdata/images/hotel/max1024x768/648459585.jpg?k=28ccd2dbffcd50c134ba6f59046ccbdc6a2118a541573e7f5242be3345d2b107&o=',
    ],
    roomTypes: ['Single', 'Double', 'Executive'],
  ),
  Hotel(
    id: 'h4',
    name: 'Royal Heritage Palace',
    location: 'Jaipur, India',
    price: 7000,
    rating: 5.0,
    description:
    'Experience royal luxury and Rajasthani heritage in a grand palace with marble halls and lush courtyards.',
    images: [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQB0CWEKzofhqov62AE8GLS4qissmeYlvnROg&s',
      'https://cf.bstatic.com/xdata/images/hotel/max1024x768/407616931.jpg?k=190329d102a7911c634b7a3b0d3419ee1143eaa78342b0125a40ac1d454f0128&o=',
      'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/07/3c/ac/68/chunda-palace-hotel.jpg?w=700&h=-1&s=1',
    ],
    roomTypes: ['Deluxe', 'Maharaja Suite', 'Royal Villa'],
  ),
  Hotel(
    id: 'h5',
    name: 'Serenity Lake Resort',
    location: 'Ooty, India',
    price: 4200,
    rating: 4.5,
    description:
    'A peaceful lakeside resort surrounded by misty hills. Enjoy paddle boating, gardens, and cozy fireplaces.',
    images: [
      'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/ef/9d/ea/fortune-resort-sullivan.jpg?w=1200&h=-1&s=1',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3pFgCGYEtiAamy28DOaofNQGz1pMYq4-MBg&s',
      'https://cf.bstatic.com/xdata/images/hotel/max1024x768/316694204.jpg?k=b5b969fcf2347c7da711ea948672698c661e96792e08a753b1717c0ccdd90d2a&o=',
    ],
    roomTypes: ['Cottage', 'Lake View Deluxe', 'Garden Villa'],
  ),
  Hotel(
    id: 'h6',
    name: 'Forest Whisper Eco Lodge',
    location: 'Wayanad, India',
    price: 3800,
    rating: 3.9,
    description:
    'An eco-friendly lodge hidden deep in the rainforest, offering treehouses and nature trails for true adventure seekers.',
    images: [
      'https://cf.bstatic.com/xdata/images/hotel/max1024x768/214387130.jpg?k=429a5c8aee50350f6ca0797bfdc2711c98b7863946b7345f0748ecf17647ee2d&o=',
      'https://pix10.agoda.net/property/1061927/0/08d424c2f938b69438a56944758aee4b.jpeg?ce=0&s=414x232',
      'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2c/b0/b8/60/suite-hotels.jpg?w=1200&h=-1&s=1',
    ],
    roomTypes: ['Treehouse', 'Eco Cabin', 'Forest View Suite'],
  ),
];
