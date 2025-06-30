import 'package:flutter/material.dart';
import 'package:fruti_app/models/review_model.dart';
import 'package:fruti_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewWidget extends StatelessWidget {
  final Review review;
  const ReviewWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 24, backgroundImage: AssetImage(review.userImageUrl)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      review.date,
                      style: GoogleFonts.poppins(
                          color: AppColors.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < review.rating ? Icons.star : Icons.star_border,
                    color: AppColors.starColor,
                    size: 16,
                  );
                }),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review.comment,
            style: GoogleFonts.poppins(fontSize: 14),
          )
        ],
      ),
    );
  }
}
