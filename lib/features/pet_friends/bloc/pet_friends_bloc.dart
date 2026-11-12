import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/pet_profile_model.dart';
import '../../../core/repositories/auth_repository.dart';
import '../../../core/repositories/pet_friends_repository.dart';
import '../models/pet_friend_post_model.dart';
import 'pet_friends_event.dart';
import 'pet_friends_state.dart';

class PetFriendsBloc extends Bloc<PetFriendsEvent, PetFriendsState> {
  final PetFriendsRepository _petFriendsRepo;
  final AuthRepository _authRepo;

  PetFriendsBloc({PetFriendsRepository? petFriendsRepo, AuthRepository? authRepo})
      : _petFriendsRepo = petFriendsRepo ?? PetFriendsRepository(),
        _authRepo = authRepo ?? AuthRepository(),
        super(const PetFriendsInitial()) {
    on<LoadPetFriends>(_onLoadPetFriends);
    on<ToggleLikePost>(_onToggleLikePost);
    on<SendPlaydateRequest>(_onSendPlaydateRequest);
    on<CreateNewPost>(_onCreateNewPost);
    on<DeletePetPost>(_onDeletePetPost);
  }

  void _onLoadPetFriends(LoadPetFriends event, Emitter<PetFriendsState> emit) {
    const defaultPosts = [
      PetFriendPostModel(
        id: 'post_1', ownerName: 'Merve', petName: 'Bobi', petBreed: 'Golden Retriever',
        petType: PetType.dog, distance: '450m yakında', meetingLocation: 'Moda Sahil Parkı',
        content: 'Moda Sahil Parkı çimlerinde olacağız! Enerjik köpek dostlarımızı bekleriz 🎾',
        likeCount: 14, isLiked: false, isFriendRequestSent: false,
      ),
      PetFriendPostModel(
        id: 'post_2', ownerName: 'Can & Sinem', petName: 'Duman', petBreed: 'Fransız Bulldog',
        petType: PetType.dog, distance: '1.2 km yakında', meetingLocation: 'Göztepe 60. Yıl Parkı',
        content: 'Duman çok sosyal bir dost. Hafta sonu parkta buluşmak isteyen var mı?',
        likeCount: 9, isLiked: true, isFriendRequestSent: false,
      ),
      PetFriendPostModel(
        id: 'post_3', ownerName: 'Elif', petName: 'Pamuk & Tarçın', petBreed: 'Pomeranian Boo',
        petType: PetType.dog, distance: '2.1 km yakında', meetingLocation: 'Caddebostan Sahil',
        content: 'Küçük ırk dostlarımızla kontrollü sosyalleşme yürüyüşü planlıyoruz.',
        likeCount: 22, isLiked: false, isFriendRequestSent: true,
      ),
    ];
    emit(const PetFriendsLoaded(posts: defaultPosts, nearbyPets: defaultPosts));
  }

  Future<void> _onToggleLikePost(ToggleLikePost event, Emitter<PetFriendsState> emit) async {
    final user = _authRepo.currentUser;
    final s = state;
    if (s is PetFriendsLoaded) {
      final target = s.posts.firstWhere((p) => p.id == event.postId);
      if (user != null) {
        try { await _petFriendsRepo.toggleLikePost(event.postId, user.uid, target.isLiked); } catch (_) {}
      }
      final updated = s.posts.map((p) {
        if (p.id == event.postId) {
          final isLiked = !p.isLiked;
          return p.copyWith(isLiked: isLiked, likeCount: isLiked ? p.likeCount + 1 : p.likeCount - 1);
        }
        return p;
      }).toList();
      emit(s.copyWith(posts: updated));
    }
  }

  Future<void> _onSendPlaydateRequest(SendPlaydateRequest event, Emitter<PetFriendsState> emit) async {
    final s = state;
    if (s is PetFriendsLoaded) {
      final target = s.posts.firstWhere((p) => p.id == event.postId);
      if (target.isOwnPost) return;
      final user = _authRepo.currentUser;
      if (user != null) {
        try {
          await _petFriendsRepo.sendPlaydateRequest(event.postId, user.uid, target.isFriendRequestSent);
        } catch (_) {}
      }
      final updated = s.posts.map((p) {
        return p.id == event.postId ? p.copyWith(isFriendRequestSent: !p.isFriendRequestSent) : p;
      }).toList();
      emit(s.copyWith(posts: updated));
    }
  }

  Future<void> _onCreateNewPost(CreateNewPost event, Emitter<PetFriendsState> emit) async {
    final user = _authRepo.currentUser;
    if (user != null) {
      try { await _petFriendsRepo.addPost(user.uid, event.post); } catch (_) {}
    }
    final s = state;
    if (s is PetFriendsLoaded) {
      emit(s.copyWith(posts: [event.post, ...s.posts]));
    }
  }

  Future<void> _onDeletePetPost(DeletePetPost event, Emitter<PetFriendsState> emit) async {
    try { await _petFriendsRepo.deletePost(event.postId); } catch (_) {}
    final s = state;
    if (s is PetFriendsLoaded) {
      emit(s.copyWith(posts: s.posts.where((p) => p.id != event.postId).toList()));
    }
  }
}
