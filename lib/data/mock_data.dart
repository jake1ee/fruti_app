import 'package:fruti_app/models/review_model.dart';
import 'package:fruti_app/models/product_model.dart';
import 'package:fruti_app/models/community_post_model.dart';

final List<CommunityPost> mockCommunityPosts = [
  CommunityPost(
    userName: 'FoodieExplorer',
    userAvatarUrl: 'assets/images/review_1.jpeg',
    timeAgo: '15m ago',
    postImageUrl: 'assets/images/food_detalis.jpeg',
    caption:
        'Can’t get enough of this Ayam Kunyit Buttermilk! The sauce is just divine. 🤤 #foodlover #malaysianfood',
    likes: 128,
    comments: 12,
  ),
  CommunityPost(
    userName: 'BurgerQueen',
    userAvatarUrl: 'assets/images/review_2.jpeg',
    timeAgo: '1h ago',
    postImageUrl: 'assets/images/food_2.png',
    caption:
        'Finally tried the Ozzie Burger & Western. Look at that juicy patty! Worth every calorie. 🍔🔥',
    likes: 256,
    comments: 34,
  ),
  CommunityPost(
    userName: 'NoodleLife',
    userAvatarUrl: 'assets/images/review_3.jpeg',
    timeAgo: '3h ago',
    postImageUrl: 'assets/images/food_1.png',
    caption:
        'My go-to comfort food: Bakso Koplo. Nothing beats a warm bowl of noodle soup on a rainy day.',
    likes: 98,
    comments: 8,
  ),
];

final List<Product> mockProducts = [
  Product(
    id: 1,
    name: 'Bakso Koplo Bandar Puteri',
    categories: 'Halal, Noodles, Asian',
    rating: 4.5,
    reviewCount: '1k reviews',
    distance: '2.0 KM',
    imageUrl: 'assets/images/food_1.png', // <-- Changed
    detailImageUrl: 'assets/images/food_1.jpeg', // <-- Added
    price: 12.90,
    description:
        "Crispy, golden chicken coated in a tangy orange glaze. It's battered and fried, then tossed in a sweet and zesty orange sauce.",
    reviews: [
      Review(
          userName: 'Aiman Hakim',
          date: '15/04/2024',
          rating: 4.0,
          comment:
              "The soup was rich and the meatballs were great. A bit spicy for me but still delicious.",
          userImageUrl: 'assets/images/review_1.jpeg'),
      Review(
          userName: 'Chloe Tan',
          date: '12/04/2024',
          rating: 5.0,
          comment:
              "Best bakso in town! The broth is so deep in flavor. Will definitely come back for more.",
          userImageUrl: 'assets/images/review_2.jpeg'),
      Review(
          userName: 'Zul',
          date: '10/04/2024',
          rating: 5.0,
          comment:
              "Authentic taste. Reminds me of the bakso I had in Jakarta. The sambal is power!",
          userImageUrl: 'assets/images/review_3.jpeg'),
    ],
  ),
  Product(
    id: 2,
    name: 'Ozzie Burger & Western',
    categories: 'Halal, Burgers',
    rating: 5.0,
    reviewCount: '3k reviews',
    distance: '2.8 KM',
    imageUrl: 'assets/images/food_2.png', // <-- Changed
    detailImageUrl: 'assets/images/food_2.png', // <-- Added
    price: 18.50,
    description:
        'A juicy beef patty with fresh lettuce, tomatoes, and our secret sauce, all in a toasted brioche bun.',
    reviews: [
      Review(
          userName: 'Ben',
          date: '20/04/2024',
          rating: 5.0,
          comment: "The patty was so juicy and perfectly cooked. 10/10!",
          userImageUrl: 'assets/images/review_3.jpeg'),
      Review(
          userName: 'Jason',
          date: '18/04/2024',
          rating: 5.0,
          comment:
              'The double cheeseburger is a must-try. Huge portions and worth every penny!',
          userImageUrl: 'assets/images/review_1.jpeg'),
      Review(
          userName: 'Emily',
          date: '16/04/2024',
          rating: 5.0,
          comment:
              'Came for the burgers, stayed for the amazing fries. Everything was perfect.',
          userImageUrl: 'assets/images/review_2.jpeg'),
    ],
  ),
  Product(
    id: 3,
    name: 'Kopi Warung Seksyen 7',
    categories: 'Beverages',
    rating: 4.0,
    reviewCount: '6k reviews',
    distance: '3.5 KM',
    imageUrl: 'assets/images/food_3.png', // <-- Changed
    detailImageUrl: 'assets/images/food_3.png', // <-- Added
    price: 5.00,
    description:
        'Authentic Malaysian-style coffee, brewed to perfection. The perfect pick-me-up for any time of day.',
    reviews: [
      Review(
          userName: 'Pak Cik Mail',
          date: '21/04/2024',
          rating: 4.0,
          comment:
              'Kopi O pekat dan sedap. Macam dulu-dulu punya rasa. Roti bakar dia pun padu.',
          userImageUrl: 'assets/images/review_3.jpeg'),
      Review(
          userName: 'Student Lim',
          date: '19/04/2024',
          rating: 5.0,
          comment:
              'Great place to hang out and study. The WiFi is fast and the coffee is cheap and good.',
          userImageUrl: 'assets/images/review_1.jpeg'),
      Review(
          userName: 'Aishah',
          date: '17/04/2024',
          rating: 4.0,
          comment:
              'Nice atmosphere. Their teh tarik is also very good. A bit crowded during lunch hour.',
          userImageUrl: 'assets/images/review_2.jpeg'),
    ],
  ),
  Product(
    id: 4,
    name: 'Ayam Kunyit Buttermilk',
    categories: 'Asian, Rice',
    rating: 4.0,
    reviewCount: '3k reviews',
    distance: '3.0 KM',
    imageUrl: 'assets/images/food_4.png', // <-- Changed
    detailImageUrl: 'assets/images/food_detalis.jpeg', // <-- Added
    price: 15.00,
    description:
        'Tender chicken pieces cooked in a creamy buttermilk sauce with a hint of turmeric and spices.',
    reviews: [
      Review(
          userName: 'Sharifah Amani',
          date: '29/03/2024',
          rating: 5.0,
          comment:
              "Wow, this fried chicken sedap teroks! The chicken is crispy, and the orange sauce is just the right mix of sweet, sour, and a little spicy— perfect!",
          userImageUrl: 'assets/images/review_1.jpeg'),
      Review(
          userName: 'David Lew',
          date: '10/04/2024',
          rating: 4.0,
          comment:
              "Every bite is full of flavor, and it pairs so well with hot rice. Definitely a must-try. Thumbs up!",
          userImageUrl: 'assets/images/review_2.jpeg'),
      Review(
          userName: 'Tiz Zaqyah',
          date: '05/04/2024',
          rating: 5.0,
          comment:
              "Perfect combination of sweet, sour, and spicy is just oomph!! Please order their cheesy onion rings also, sedap sangat!",
          userImageUrl: 'assets/images/review_3.jpeg'),
      Review(
          userName: 'Irfan',
          date: '02/04/2024',
          rating: 5.0,
          comment:
              "The buttermilk sauce is incredible. Creamy and not too sweet. Perfect with the crispy chicken.",
          userImageUrl: 'assets/images/review_1.jpeg'),
      Review(
          userName: 'Siti',
          date: '01/04/2024',
          rating: 5.0,
          comment:
              "My new favorite lunch spot. The portion size is generous and the taste is consistently great.",
          userImageUrl: 'assets/images/review_2.jpeg'),
    ],
  ),
  Product(
    id: 5,
    name: 'Laksa Telur Sarang Labu',
    categories: 'Noodles, Local',
    rating: 4.0,
    reviewCount: '1k reviews',
    distance: '3.5 KM',
    imageUrl: 'assets/images/food_5.png', // <-- Changed
    detailImageUrl: 'assets/images/food_5.png', // <-- Added
    price: 10.00,
    description:
        'A rich and spicy coconut-based noodle soup, topped with a unique crispy egg nest.',
    reviews: [
      Review(
          userName: 'Fatimah',
          date: '22/04/2024',
          rating: 5.0,
          comment:
              'The "telur sarang" is so crispy and unique! The laksa gravy is rich and flavorful. Highly recommended!',
          userImageUrl: 'assets/images/review_3.jpeg'),
      Review(
          userName: 'Kumar',
          date: '20/04/2024',
          rating: 5.0,
          comment:
              'A hidden gem. I have never tasted laksa like this before. The crispy egg on top is a game changer.',
          userImageUrl: 'assets/images/review_1.jpeg'),
      Review(
          userName: 'Mei Ling',
          date: '18/04/2024',
          rating: 4.0,
          comment:
              'Very tasty, but a little bit too spicy for my liking. The portion is big though, so it is worth the price.',
          userImageUrl: 'assets/images/review_2.jpeg'),
      Review(
          userName: 'Danial',
          date: '15/04/2024',
          rating: 5.0,
          comment:
              'Perfect comfort food. The combination of textures is amazing. Will be back next week!',
          userImageUrl: 'assets/images/review_3.jpeg'),
    ],
  ),
];
