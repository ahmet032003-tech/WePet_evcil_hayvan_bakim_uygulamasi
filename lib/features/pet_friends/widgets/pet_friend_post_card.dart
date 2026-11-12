import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../models/pet_friend_post_model.dart';

class PetFriendPostCard extends StatelessWidget {
  final PetFriendPostModel post;
  final VoidCallback onLike;
  final VoidCallback onRequest;
  final VoidCallback? onDelete;

  const PetFriendPostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onRequest,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 10),
          Text(post.content, style: AppTextStyles.bodyRegular),
          const SizedBox(height: 12),
          _buildLocationBadge(),
          const SizedBox(height: 12),
          const Divider(color: AppColors.borderLight, height: 1),
          const SizedBox(height: 8),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
          child: const Icon(Icons.pets, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${post.petName} & ${post.ownerName}', style: AppTextStyles.cardTitle.copyWith(fontSize: 14)),
              const SizedBox(height: 2),
              Text(post.petBreed, style: AppTextStyles.bodyMuted.copyWith(fontSize: 11)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: post.isOwnPost ? AppColors.primary : AppColors.background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: post.isOwnPost ? AppColors.primary : AppColors.borderLight),
          ),
          child: Text(
            post.isOwnPost ? 'Senin İlanın' : post.distance,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: post.isOwnPost ? AppColors.cardSurface : AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationBadge() {
    return Row(
      children: [
        const Icon(Icons.location_on_rounded, size: 16, color: AppColors.secondary),
        const SizedBox(width: 4),
        Text(
          post.meetingLocation,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.secondary),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: onLike,
          icon: Icon(
            post.isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: post.isLiked ? Colors.redAccent : AppColors.textMuted,
            size: 20,
          ),
          label: Text(
            '${post.likeCount}',
            style: TextStyle(color: post.isLiked ? Colors.redAccent : AppColors.textDark, fontWeight: FontWeight.w700),
          ),
        ),
        if (post.isOwnPost)
          TextButton.icon(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 18),
            label: const Text('İlanı Kaldır', style: TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.w700)),
          )
        else
          ElevatedButton.icon(
            onPressed: onRequest,
            style: ElevatedButton.styleFrom(
              backgroundColor: post.isFriendRequestSent ? AppColors.secondary : AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            ),
            icon: Icon(post.isFriendRequestSent ? Icons.check_circle_rounded : Icons.person_add_alt_1_rounded, size: 16),
            label: Text(
              post.isFriendRequestSent ? 'İstek Gönderildi' : 'Oyun İsteği Gönder',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
      ],
    );
  }
}
