import 'package:flutter/material.dart';
import 'package:fruti_app/providers/cart_provider.dart';
import 'package:fruti_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

class CartBadge extends StatelessWidget {
  final Color iconColor;
  const CartBadge({super.key, this.iconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) => Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: iconColor),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.cart);
            },
          ),
          if (cart.itemCount > 0)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  cart.itemCount.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
