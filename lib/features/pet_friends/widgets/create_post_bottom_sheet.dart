import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/models/pet_profile_model.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../../profile/bloc/profile_state.dart';
import '../models/pet_friend_post_model.dart';

class CreatePostBottomSheet extends StatefulWidget {
  final ValueChanged<PetFriendPostModel> onPostCreated;

  const CreatePostBottomSheet({super.key, required this.onPostCreated});

  static Future<void> show(BuildContext context, ValueChanged<PetFriendPostModel> onPostCreated) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CreatePostBottomSheet(onPostCreated: onPostCreated),
    );
  }

  @override
  State<CreatePostBottomSheet> createState() => _CreatePostBottomSheetState();
}

class _CreatePostBottomSheetState extends State<CreatePostBottomSheet> {
  final _petNameController = TextEditingController(text: 'Tarçın');
  final _breedController = TextEditingController(text: 'Golden Retriever');
  final _locationController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _petNameController.dispose();
    _breedController.dispose();
    _locationController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(20, 14, 20, MediaQuery.of(context).viewInsets.bottom + 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDragHandle(),
            const SizedBox(height: 16),
            const Text('Yeni Buluşma / Oyun İlanı', style: AppTextStyles.heading2),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(child: TextField(controller: _petNameController, decoration: const InputDecoration(labelText: 'Dostunun Adı'))),
                const SizedBox(width: 10),
                Expanded(child: TextField(controller: _breedController, decoration: const InputDecoration(labelText: 'Irkı'))),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Buluşma Yeri (Örn: Caddebostan Sahil)',
                prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contentController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Buluşma Notu ve Saat', hintText: 'Örn: Saat 17:00 gibi çimlerde olacağız!'),
            ),
            const SizedBox(height: 18),
            ElevatedButton(onPressed: _submitPost, child: const Text('İlanı Yayınla')),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 44,
        height: 5,
        decoration: BoxDecoration(color: AppColors.borderLight, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _submitPost() {
    final pet = _petNameController.text.trim().isEmpty ? 'Dostum' : _petNameController.text.trim();
    final breed = _breedController.text.trim().isEmpty ? 'Melez' : _breedController.text.trim();
    final loc = _locationController.text.trim().isEmpty ? 'Şehir Parkı' : _locationController.text.trim();
    final note = _contentController.text.trim().isEmpty ? 'Oyun arkadaşları arıyoruz!' : _contentController.text.trim();

    String currentUserName = 'Sen';
    final pState = context.read<ProfileBloc>().state;
    if (pState is ProfileLoaded && pState.userName.isNotEmpty) {
      currentUserName = pState.userName;
    }

    widget.onPostCreated(PetFriendPostModel(
      id: 'post_${DateTime.now().millisecondsSinceEpoch}',
      ownerName: currentUserName,
      petName: pet,
      petBreed: breed,
      petType: PetType.dog,
      distance: '0 m (Senin İlanın)',
      content: note,
      meetingLocation: loc,
      isOwnPost: true,
    ));
    Navigator.pop(context);
  }
}
