import 'package:flutter/material.dart';
import 'package:fruti_app/data/mock_data.dart';
import 'package:fruti_app/utils/app_colors.dart';
import 'package:fruti_app/widgets/produst_list_item.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  void _showNotImplementedSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Category navigation is not implemented yet.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.primary,
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Discover Deals',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              background: Image.asset('assets/images/food_details.jpeg',
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.5),
                  colorBlendMode: BlendMode.darken),
            ),
          ),
          _buildSectionHeader('Top Categories'),
          _buildCategoryGrid(context),
          _buildSectionHeader('Popular Near You'),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ProductListItem(product: mockProducts[index]),
              childCount: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
        child: Text(title,
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context) {
    final categories = [
      {'icon': Icons.fastfood, 'label': 'Burgers'},
      {'icon': Icons.local_pizza, 'label': 'Pizza'},
      {'icon': Icons.ramen_dining, 'label': 'Noodles'},
      {'icon': Icons.cake, 'label': 'Desserts'},
      {'icon': Icons.local_drink, 'label': 'Drinks'},
      {'icon': Icons.rice_bowl, 'label': 'Rice'},
    ];

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return InkWell(
              onTap: () {
                _showNotImplementedSnackBar(context);
              },
              borderRadius: BorderRadius.circular(12),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(categories[index]['icon'] as IconData,
                        size: 32, color: AppColors.primary),
                    const SizedBox(height: 8),
                    Text(categories[index]['label'] as String,
                        style: GoogleFonts.poppins(fontSize: 12)),
                  ],
                ),
              ),
            );
          },
          childCount: categories.length,
        ),
      ),
    );
  }
}
