import 'package:flutter/material.dart';
import 'package:fruti_app/models/product_model.dart';
import 'package:fruti_app/models/review_model.dart';
import 'package:fruti_app/utils/app_colors.dart';
import 'package:fruti_app/widgets/custom_button.dart';
import 'package:fruti_app/widgets/review_widget.dart';
import 'package:provider/provider.dart';
import 'package:fruti_app/providers/cart_provider.dart';
import 'package:fruti_app/widgets/cart_badge.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  int _quantity = 1;
  String _selectedFilter = 'All';
  bool _showAllReviews = false;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    Future.delayed(const Duration(milliseconds: 300), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateQuantity(int change) {
    setState(() {
      if (_quantity + change >= 1) {
        _quantity += change;
      }
    });
  }

  DateTime _parseDate(String dateStr) {
    final parts = dateStr.split('/');
    return DateTime(
        int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    List<Review> filteredReviews;

    switch (_selectedFilter) {
      case 'Latest':
        filteredReviews = List.from(product.reviews)
          ..sort((a, b) => _parseDate(b.date).compareTo(_parseDate(a.date)));
        break;
      case 'Oldest':
        filteredReviews = List.from(product.reviews)
          ..sort((a, b) => _parseDate(a.date).compareTo(_parseDate(b.date)));
        break;
      case '5':
      case '4':
      case '3':
        final rating = int.parse(_selectedFilter);
        filteredReviews =
            product.reviews.where((r) => r.rating.floor() == rating).toList();
        break;
      default: // 'All'
        filteredReviews = product.reviews;
    }

    final reviewsToShow =
        _showAllReviews ? filteredReviews : filteredReviews.take(3).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(product),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductInfo(product),
                  const Divider(height: 32, thickness: 1),
                  _buildRatingAndReviews(
                      context, product, reviewsToShow, filteredReviews.length),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SlideTransition(
        position: _slideAnimation,
        child: _buildAddToCartBar(product),
      ),
    );
  }

  Widget _buildRatingAndReviews(BuildContext context, Product product,
      List<Review> reviewsToShow, int totalFilteredCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rating & Reviews',
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(children: [
          _buildRatingSummary(product),
          const SizedBox(width: 20),
          _buildRatingBars()
        ]),
        const SizedBox(height: 24),
        _buildReviewFilters(),
        const SizedBox(height: 16),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: reviewsToShow.isNotEmpty
                ? reviewsToShow
                    .map((review) => ReviewWidget(review: review))
                    .toList()
                : [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(
                          child: Text("No reviews match this filter.",
                              style:
                                  TextStyle(color: AppColors.textSecondary))),
                    )
                  ],
          ),
        ),
        if (totalFilteredCount > 3)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _showAllReviews = !_showAllReviews;
                  });
                },
                child: Text(
                  _showAllReviews
                      ? 'Show less'
                      : 'View all $totalFilteredCount reviews',
                  style: GoogleFonts.poppins(
                      color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildReviewFilters() {
    final filters = ['All', 'Latest', 'Oldest', '5', '4', '3'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          bool isSelected = _selectedFilter == filter;
          bool isStarFilter = int.tryParse(filter) != null;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              showCheckmark: false,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSelected && !isStarFilter)
                    const Icon(Icons.check, size: 16, color: Colors.white),
                  if (isSelected && !isStarFilter) const SizedBox(width: 4),
                  Text(filter),
                  if (isStarFilter) const SizedBox(width: 2),
                  if (isStarFilter)
                    Icon(
                      Icons.star,
                      size: 14,
                      color: isSelected ? Colors.white70 : Colors.black54,
                    )
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedFilter = filter;
                    _showAllReviews = false;
                  });
                }
              },
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              backgroundColor: Colors.grey[200],
              selectedColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          );
        }).toList(),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(Product product) {
    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: const [
        CartBadge(iconColor: Colors.white),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          product.detailImageUrl,
          fit: BoxFit.cover,
          color: Colors.black.withOpacity(0.4),
          colorBlendMode: BlendMode.darken,
        ),
      ),
    );
  }

  Widget _buildProductInfo(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                product.name,
                style: GoogleFonts.poppins(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'RM ${product.price.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: GoogleFonts.poppins(
              fontSize: 14, color: AppColors.textSecondary, height: 1.5),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Chip(
              label: Text('Featured',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500)),
              backgroundColor: AppColors.primary.withOpacity(0.1),
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            const SizedBox(width: 8),
            Chip(
              label: Text('Local Food',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500)),
              backgroundColor: AppColors.primary.withOpacity(0.1),
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildRatingSummary(Product product) {
    return Column(
      children: [
        Text(
          product.rating.toString(),
          style: GoogleFonts.poppins(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < product.rating.floor()
                  ? Icons.star
                  : index < product.rating
                      ? Icons.star_half
                      : Icons.star_border,
              color: AppColors.starColor,
              size: 20,
            );
          }),
        ),
        const SizedBox(height: 4),
        Text(
          '(${product.reviewCount})',
          style:
              GoogleFonts.poppins(color: AppColors.textSecondary, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildRatingBars() {
    final dummyProgress = [0.8, 0.4, 0.2, 0.1, 0.05];
    return Expanded(
      child: Column(
        children: List.generate(5, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Text('${5 - index}'),
                const SizedBox(width: 4),
                const Icon(Icons.star, color: Colors.grey, size: 14),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: dummyProgress[index],
                      backgroundColor: Colors.grey[200],
                      color: AppColors.primary,
                      minHeight: 8,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAddToCartBar(Product product) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
          .copyWith(bottom: MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10)
        ],
      ),
      child: Row(
        children: [
          _buildQuantityStepper(),
          const SizedBox(width: 16),
          Expanded(
            child: CustomButton(
              text:
                  'Add to cart  RM ${(product.price * _quantity).toStringAsFixed(2)}',
              onPressed: () {
                final cart = Provider.of<CartProvider>(context, listen: false);
                cart.addItem(product, _quantity);

                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added ${product.name} to cart!'),
                    backgroundColor: AppColors.primary,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuantityStepper() {
    return Row(
      children: [
        _buildQuantityButton(Icons.remove, () => _updateQuantity(-1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            _quantity.toString(),
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        _buildQuantityButton(Icons.add, () => _updateQuantity(1)),
      ],
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
    );
  }
}
