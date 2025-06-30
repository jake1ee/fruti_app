import 'package:flutter/material.dart';
import 'package:fruti_app/providers/cart_provider.dart';
import 'package:fruti_app/utils/app_colors.dart';
import 'package:fruti_app/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          // Clear cart button
          if (cart.items.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Clear Cart'),
                    content: const Text(
                        'Are you sure you want to remove all items from your cart?'),
                    actions: [
                      TextButton(
                        child: const Text('No'),
                        onPressed: () => Navigator.of(ctx).pop(),
                      ),
                      TextButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .clearCart();
                          Navigator.of(ctx).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            )
        ],
      ),
      body: cart.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text('Your cart is empty',
                      style: GoogleFonts.poppins(
                          fontSize: 18, color: Colors.grey)),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (ctx, i) {
                      final cartItem = cart.items.values.toList()[i];
                      return _buildCartItem(context, cartItem);
                    },
                  ),
                ),
                _buildTotalSection(context, cart.totalPrice),
              ],
            ),
    );
  }

  Widget _buildCartItem(BuildContext context, dynamic cartItem) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(cartItem.product.imageUrl,
                  width: 70, height: 70, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.product.name,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('RM ${cartItem.product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(color: AppColors.primary)),
                ],
              ),
            ),
            // Quantity controls
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline,
                      color: Colors.red),
                  onPressed: () =>
                      Provider.of<CartProvider>(context, listen: false)
                          .updateQuantity(
                              cartItem.product.id, cartItem.quantity - 1),
                ),
                Text(cartItem.quantity.toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon:
                      const Icon(Icons.add_circle_outline, color: Colors.green),
                  onPressed: () =>
                      Provider.of<CartProvider>(context, listen: false)
                          .updateQuantity(
                              cartItem.product.id, cartItem.quantity + 1),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSection(BuildContext context, double totalPrice) {
    return Container(
      padding: const EdgeInsets.all(16)
          .copyWith(bottom: MediaQuery.of(context).padding.bottom + 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10)
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total:',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Text('RM ${totalPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Checkout',
            onPressed: () {
              // Checkout logic would go here
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Checkout feature not implemented yet.')));
            },
          ),
        ],
      ),
    );
  }
}
