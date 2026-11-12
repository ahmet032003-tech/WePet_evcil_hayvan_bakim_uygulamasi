import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/pet_friends/models/pet_friend_post_model.dart';
import '../models/pet_profile_model.dart';

class PetFriendsRepository {
  final FirebaseFirestore _firestore;

  PetFriendsRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<PetFriendPostModel>> getPostsStream(String currentUserId) {
    return _firestore
        .collection('pet_friends_posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) {
              final data = d.data();
              final creatorId = data['creatorId'] ?? '';
              return PetFriendPostModel(
                id: d.id,
                ownerName: data['ownerName'] ?? 'Anonim',
                petName: data['petName'] ?? 'Dostum',
                petBreed: data['petBreed'] ?? 'Melez',
                petType: (data['petType'] == 'cat') ? PetType.cat : PetType.dog,
                distance: data['distance'] ?? 'Yakında',
                content: data['content'] ?? '',
                meetingLocation: data['meetingLocation'] ?? 'Park',
                likeCount: (data['likeCount'] as num?)?.toInt() ?? 0,
                isLiked: (data['likedBy'] as List?)?.contains(currentUserId) ?? false,
                isFriendRequestSent: (data['requestedBy'] as List?)?.contains(currentUserId) ?? false,
                isOwnPost: creatorId == currentUserId,
              );
            }).toList());
  }

  Future<void> addPost(String uid, PetFriendPostModel post) async {
    await _firestore.collection('pet_friends_posts').doc(post.id).set({
      'creatorId': uid,
      'ownerName': post.ownerName,
      'petName': post.petName,
      'petBreed': post.petBreed,
      'petType': post.petType == PetType.dog ? 'dog' : 'cat',
      'distance': post.distance,
      'content': post.content,
      'meetingLocation': post.meetingLocation,
      'likeCount': post.likeCount,
      'likedBy': [],
      'requestedBy': [],
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> toggleLikePost(String postId, String currentUserId, bool isLiked) async {
    final ref = _firestore.collection('pet_friends_posts').doc(postId);
    if (isLiked) {
      await ref.update({
        'likedBy': FieldValue.arrayRemove([currentUserId]),
        'likeCount': FieldValue.increment(-1),
      });
    } else {
      await ref.update({
        'likedBy': FieldValue.arrayUnion([currentUserId]),
        'likeCount': FieldValue.increment(1),
      });
    }
  }

  Future<void> sendPlaydateRequest(String postId, String currentUserId, bool isSent) async {
    final ref = _firestore.collection('pet_friends_posts').doc(postId);
    if (isSent) {
      await ref.update({
        'requestedBy': FieldValue.arrayRemove([currentUserId]),
      });
    } else {
      await ref.update({
        'requestedBy': FieldValue.arrayUnion([currentUserId]),
      });
    }
  }

  Future<void> deletePost(String postId) async {
    await _firestore.collection('pet_friends_posts').doc(postId).delete();
  }
}

