import 'review_model.dart';

class Product {
  final int id;
  final String name;
  final String categories;
  final double rating;
  final String reviewCount;
  final String distance;
  final String imageUrl;
  final String detailImageUrl;
  final String description;
  final double price;
  final List<Review> reviews;

  Product({
    required this.id,
    required this.name,
    required this.categories,
    required this.rating,
    required this.reviewCount,
    required this.distance,
    required this.imageUrl,
    required this.detailImageUrl,
    required this.description,
    required this.price,
    required this.reviews,
  });
}
