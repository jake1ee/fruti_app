// lib/models/community_post_model.dart
class CommunityPost {
  final String userName;
  final String userAvatarUrl;
  final String timeAgo;
  final String postImageUrl;
  final String caption;
  final int likes;
  final int comments;

  CommunityPost({
    required this.userName,
    required this.userAvatarUrl,
    required this.timeAgo,
    required this.postImageUrl,
    required this.caption,
    required this.likes,
    required this.comments,
  });
}
