import '../../../core/models/pet_profile_model.dart';

class PetFriendPostModel {
  final String id;
  final String ownerName;
  final String petName;
  final String petBreed;
  final PetType petType;
  final String distance;
  final String content;
  final String meetingLocation;
  final int likeCount;
  final bool isLiked;
  final bool isFriendRequestSent;
  final bool isOwnPost;

  const PetFriendPostModel({
    required this.id,
    required this.ownerName,
    required this.petName,
    required this.petBreed,
    this.petType = PetType.dog,
    required this.distance,
    required this.content,
    required this.meetingLocation,
    this.likeCount = 0,
    this.isLiked = false,
    this.isFriendRequestSent = false,
    this.isOwnPost = false,
  });

  PetFriendPostModel copyWith({
    String? id,
    String? ownerName,
    String? petName,
    String? petBreed,
    PetType? petType,
    String? distance,
    String? content,
    String? meetingLocation,
    int? likeCount,
    bool? isLiked,
    bool? isFriendRequestSent,
    bool? isOwnPost,
  }) {
    return PetFriendPostModel(
      id: id ?? this.id,
      ownerName: ownerName ?? this.ownerName,
      petName: petName ?? this.petName,
      petBreed: petBreed ?? this.petBreed,
      petType: petType ?? this.petType,
      distance: distance ?? this.distance,
      content: content ?? this.content,
      meetingLocation: meetingLocation ?? this.meetingLocation,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      isFriendRequestSent: isFriendRequestSent ?? this.isFriendRequestSent,
      isOwnPost: isOwnPost ?? this.isOwnPost,
    );
  }
}
