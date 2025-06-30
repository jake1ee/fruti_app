import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fruti_app/data/mock_data.dart';
import 'package:fruti_app/models/product_model.dart';
import 'package:fruti_app/utils/app_colors.dart';
import 'package:fruti_app/widgets/cart_badge.dart';
import 'package:fruti_app/widgets/produst_list_item.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String _currentLocation = 'PFCC Puchong..';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> displayedProducts;
    if (_searchQuery.isEmpty) {
      displayedProducts = mockProducts;
    } else {
      displayedProducts = mockProducts.where((product) {
        final nameMatches =
            product.name.toLowerCase().contains(_searchQuery.toLowerCase());
        final categoryMatches = product.categories
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
        return nameMatches || categoryMatches;
      }).toList();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          _buildAnimatedProductList(displayedProducts),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      pinned: true,
      floating: true,
      expandedHeight: 140.0,
      automaticallyImplyLeading: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      title: GestureDetector(
        onTap: _showLocationSelectionDialog, // <-- Call our new method on tap
        child: Row(
          children: [
            const Icon(Icons.location_on_outlined, size: 20),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DELIVER TO',
                  style:
                      GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
                ),
                Row(
                  children: [
                    Text(
                      _currentLocation, // <-- Use the state variable here
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Favorite function is not implemented yet.'),
                  backgroundColor: Colors.grey,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.favorite_border_outlined)),
        const CartBadge(iconColor: Colors.black),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(top: 90.0),
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            alignment: Alignment.bottomCenter,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search food ',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedProductList(List<Product> products) {
    if (products.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No results found for "${_searchController.text}"',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 18, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try searching for something else.',
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
      );
    }

    return AnimationLimiter(
      child: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: ProductListItem(product: products[index]),
                ),
              ),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }

  void _showLocationSelectionDialog() {
    final List<String> locations = [
      'PFCC Puchong..',
      'Sunway Pyramid',
      'Mid Valley Megamall',
      'KLCC',
      '1 Utama Shopping Centre',
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Select a Delivery Location',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: locations.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final location = locations[index];
                return ListTile(
                  leading: const Icon(Icons.location_on_outlined,
                      color: AppColors.primary),
                  title: Text(location),
                  trailing: _currentLocation == location
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onTap: () {
                    setState(() {
                      _currentLocation = location;
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
