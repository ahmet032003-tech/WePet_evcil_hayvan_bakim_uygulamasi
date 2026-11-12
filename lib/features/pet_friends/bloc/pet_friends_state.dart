import '../models/pet_friend_post_model.dart';

abstract class PetFriendsState {
  const PetFriendsState();
}

class PetFriendsInitial extends PetFriendsState {
  const PetFriendsInitial();
}

class PetFriendsLoading extends PetFriendsState {
  const PetFriendsLoading();
}

class PetFriendsLoaded extends PetFriendsState {
  final List<PetFriendPostModel> posts;
  final List<PetFriendPostModel> nearbyPets;

  const PetFriendsLoaded({
    required this.posts,
    required this.nearbyPets,
  });

  PetFriendsLoaded copyWith({
    List<PetFriendPostModel>? posts,
    List<PetFriendPostModel>? nearbyPets,
  }) {
    return PetFriendsLoaded(
      posts: posts ?? this.posts,
      nearbyPets: nearbyPets ?? this.nearbyPets,
    );
  }
}

