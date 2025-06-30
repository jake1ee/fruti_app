import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fruti_app/data/mock_data.dart';
import 'package:fruti_app/models/community_post_model.dart';
import 'package:fruti_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  void _showNotImplementedSnackBar(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$featureName function is not implemented yet.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Feed',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: mockCommunityPosts.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  // Pass context to the build method
                  child: _buildPostCard(context, mockCommunityPosts[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, CommunityPost post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(post.userAvatarUrl)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.userName,
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    Text(post.timeAgo,
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
          Image.asset(post.postImageUrl,
              fit: BoxFit.cover, width: double.infinity, height: 200),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(post.caption, style: GoogleFonts.poppins()),
          ),
          const Divider(height: 1),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Pass context to the action buttons
                _buildActionButton(context, Icons.favorite_border,
                    '${post.likes} Likes', 'Like'),
                _buildActionButton(context, Icons.comment_outlined,
                    '${post.comments} Comments', 'Comment'),
                _buildActionButton(
                    context, Icons.share_outlined, 'Share', 'Share'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, IconData icon, String label, String featureName) {
    return TextButton.icon(
      onPressed: () {
        _showNotImplementedSnackBar(context, featureName);
      },
      icon: Icon(icon, size: 18, color: AppColors.textSecondary),
      label: Text(label,
          style: GoogleFonts.poppins(
              color: AppColors.textSecondary, fontSize: 12)),
    );
  }
}
