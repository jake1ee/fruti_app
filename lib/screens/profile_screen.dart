import 'package:flutter/material.dart';
import 'package:fruti_app/utils/app_colors.dart';
import 'package:fruti_app/utils/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showNotImplementedSnackBar(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$featureName screen is not implemented yet.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: Text('My Profile',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildProfileMenu(context), // Pass context here
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/review_1.jpeg'),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sharifah Amani',
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('example@gmail.com',
                  style: GoogleFonts.poppins(color: AppColors.textSecondary)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildMenuItem(Icons.receipt_long_outlined, 'My Orders',
              () => _showNotImplementedSnackBar(context, 'My Orders')),
          _buildMenuItem(Icons.location_on_outlined, 'My Addresses',
              () => _showNotImplementedSnackBar(context, 'My Addresses')),
          _buildMenuItem(Icons.payment_outlined, 'Payment Methods',
              () => _showNotImplementedSnackBar(context, 'Payment Methods')),
          _buildMenuItem(Icons.settings_outlined, 'Settings',
              () => _showNotImplementedSnackBar(context, 'Settings')),
          _buildMenuItem(Icons.help_outline, 'Help & Support',
              () => _showNotImplementedSnackBar(context, 'Help & Support')),
          const Divider(),
          _buildMenuItem(Icons.logout, 'Log Out', () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.login, (Route<dynamic> route) => false);
          }, color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap,
      {Color color = AppColors.textPrimary}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: GoogleFonts.poppins(color: color)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
