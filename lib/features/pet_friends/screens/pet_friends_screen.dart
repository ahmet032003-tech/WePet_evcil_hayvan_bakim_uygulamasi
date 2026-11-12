import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../bloc/pet_friends_bloc.dart';
import '../bloc/pet_friends_event.dart';
import '../bloc/pet_friends_state.dart';
import '../widgets/create_post_bottom_sheet.dart';
import '../widgets/nearby_pets_bar.dart';
import '../widgets/pet_friend_post_card.dart';

class PetFriendsScreen extends StatelessWidget {
  const PetFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PetFriendsBloc()..add(const LoadPetFriends()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _PetFriendsAppBar(),
        body: BlocBuilder<PetFriendsBloc, PetFriendsState>(
          builder: (context, state) {
            if (state is PetFriendsLoading || state is PetFriendsInitial) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }

            if (state is PetFriendsLoaded) {
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 12),
                children: [
                  NearbyPetsBar(nearbyPets: state.nearbyPets),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Topluluk & Park Buluşmaları', style: AppTextStyles.cardTitle),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: state.posts.map((post) {
                        return PetFriendPostCard(
                          post: post,
                          onLike: () {
                            context.read<PetFriendsBloc>().add(ToggleLikePost(post.id));
                          },
                          onRequest: () {
                            context.read<PetFriendsBloc>().add(SendPlaydateRequest(post.id));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  post.isFriendRequestSent
                                      ? 'Oyun isteği geri çekildi.'
                                      : '${post.petName} için oyun isteği iletildi! 🐾',
                                ),
                                backgroundColor: AppColors.secondary,
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          onDelete: () {
                            context.read<PetFriendsBloc>().add(DeletePetPost(post.id));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('İlanınız yayından kaldırıldı.'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _PetFriendsAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'PetFriends',
        style: AppTextStyles.appBarTitle.copyWith(color: AppColors.primary),
      ),
      actions: [
        IconButton(
          onPressed: () {
            CreatePostBottomSheet.show(context, (newPost) {
              context.read<PetFriendsBloc>().add(CreateNewPost(newPost));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Buluşma ilanınız toplulukta yayınlandı! 🎉'),
                  backgroundColor: AppColors.secondary,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            });
          },
          icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.primary, size: 28),
        ),
      ],
    );
  }
}

