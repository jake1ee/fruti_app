import 'package:flutter/material.dart';
import 'package:fruti_app/providers/cart_provider.dart';
import 'package:fruti_app/screens/cart_screen.dart';
import 'package:fruti_app/screens/login_screen.dart';
import 'package:fruti_app/screens/main_screen.dart';
import 'package:fruti_app/screens/product_detail_screen.dart';
import 'package:fruti_app/screens/product_list_screen.dart';
import 'package:fruti_app/screens/spalsh_screen.dart';
import 'package:fruti_app/utils/app_colors.dart';
import 'package:fruti_app/utils/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.textPrimary),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.main:
            return MaterialPageRoute(builder: (_) => const MainScreen());
          case AppRoutes.splash:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case AppRoutes.login:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case AppRoutes.productList:
            return MaterialPageRoute(builder: (_) => const ProductListScreen());
          case AppRoutes.productDetail:
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (_, __, ___) => const ProductDetailScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          case AppRoutes.cart:
            return MaterialPageRoute(builder: (_) => const CartScreen());
          default:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
        }
      },
    );
  }
}
