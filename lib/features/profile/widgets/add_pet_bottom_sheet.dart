import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/models/pet_profile_model.dart';
import 'pet_age_selector.dart';
import 'pet_type_selector.dart';

class AddPetBottomSheet extends StatefulWidget {
  final PetType initialType;
  final ValueChanged<PetProfileModel>? onPetSaved;

  const AddPetBottomSheet({
    super.key,
    this.initialType = PetType.dog,
    this.onPetSaved,
  });

  static Future<PetProfileModel?> show(
    BuildContext context, {
    PetType initialType = PetType.dog,
    ValueChanged<PetProfileModel>? onPetSaved,
  }) {
    return showModalBottomSheet<PetProfileModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddPetBottomSheet(
        initialType: initialType,
        onPetSaved: onPetSaved,
      ),
    );
  }

  @override
  State<AddPetBottomSheet> createState() => _AddPetBottomSheetState();
}

class _AddPetBottomSheetState extends State<AddPetBottomSheet> {
  late PetType _type;
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  int _age = 2;

  @override
  void initState() {
    super.initState();
    _type = widget.initialType;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        14,
        20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDragHandle(),
          const SizedBox(height: 16),
          const Text('Evcil Hayvan Ekle', style: AppTextStyles.heading2),
          const SizedBox(height: 14),
          PetTypeSelector(
            selectedType: _type,
            onTypeChanged: (type) => setState(() => _type = type),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _nameController,
            decoration: _inputDecoration('Dostunun Adı', Icons.pets),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _breedController,
            decoration: _inputDecoration(
              'Irkı (Örn: Golden, British)',
              Icons.category_rounded,
            ),
          ),
          const SizedBox(height: 14),
          PetAgeSelector(
            age: _age,
            onAgeChanged: (val) => setState(() => _age = val),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _savePet,
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 44,
        height: 5,
        decoration: BoxDecoration(
          color: AppColors.borderLight,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: AppColors.primary),
      filled: true,
      fillColor: AppColors.background,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
    );
  }

  void _savePet() {
    final name = _nameController.text.trim().isEmpty ? 'Dostum' : _nameController.text.trim();
    final breed = _breedController.text.trim().isEmpty ? null : _breedController.text.trim();
    final pet = PetProfileModel(
      id: 'pet_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      type: _type,
      breed: breed,
      age: _age,
    );
    widget.onPetSaved?.call(pet);
    Navigator.pop(context, pet);
  }
}
