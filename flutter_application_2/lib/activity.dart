import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  final String imageUrl;
  final String title;
  final String category;
  final String location;
  final int minParticipants;
  final double price;

  Activity({
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.location,
    required this.minParticipants,
    required this.price,
  });

  static Activity fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Activity(
      imageUrl: data['url'],
      title: data['title'],
      location: data['place'],
      price: data['price'],
      category: data['category'],
      minParticipants: data['minpeople'],
    );
  }
}
