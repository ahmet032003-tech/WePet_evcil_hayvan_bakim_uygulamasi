import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/mock_data.dart';
import '../../../core/models/pet_profile_model.dart';
import '../../../core/models/profile_menu_item_model.dart';

class ProfileState {
  final PetType selectedPetType;
  final List<PetProfileModel> pets;
  final List<ProfileMenuItemModel> menuItems;

  const ProfileState({
    required this.selectedPetType,
    required this.pets,
    required this.menuItems,
  });

  List<PetProfileModel> get filteredPets =>
      pets.where((p) => p.type == selectedPetType).toList();

  ProfileState copyWith({
    PetType? selectedPetType,
    List<PetProfileModel>? pets,
    List<ProfileMenuItemModel>? menuItems,
  }) {
    return ProfileState(
      selectedPetType: selectedPetType ?? this.selectedPetType,
      pets: pets ?? this.pets,
      menuItems: menuItems ?? this.menuItems,
    );
  }
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({void Function(String title, IconData icon)? onMenuSelected})
      : super(
          ProfileState(
            selectedPetType: PetType.dog,
            pets: MockData.samplePets,
            menuItems: MockData.getProfileMenu(onMenuSelected: onMenuSelected),
          ),
        );

  void selectPetType(PetType type) {
    emit(state.copyWith(selectedPetType: type));
  }

  void addPet(PetProfileModel pet) {
    final updatedList = List<PetProfileModel>.from(state.pets)..add(pet);
    emit(state.copyWith(
      pets: updatedList,
      selectedPetType: pet.type,
    ));
  }
}
