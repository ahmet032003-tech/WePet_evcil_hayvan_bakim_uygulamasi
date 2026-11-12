import '../models/pet_friend_post_model.dart';

abstract class PetFriendsEvent {
  const PetFriendsEvent();
}

class LoadPetFriends extends PetFriendsEvent {
  const LoadPetFriends();
}

class ToggleLikePost extends PetFriendsEvent {
  final String postId;

  const ToggleLikePost(this.postId);
}

class SendPlaydateRequest extends PetFriendsEvent {
  final String postId;

  const SendPlaydateRequest(this.postId);
}

class CreateNewPost extends PetFriendsEvent {
  final PetFriendPostModel post;

  const CreateNewPost(this.post);
}

class DeletePetPost extends PetFriendsEvent {
  final String postId;

  const DeletePetPost(this.postId);
}
