import '../../../core/models/pet_profile_model.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class LoadProfileData extends ProfileEvent {
  const LoadProfileData();
}

class SwitchPetTab extends ProfileEvent {
  final PetType selectedType;

  const SwitchPetTab(this.selectedType);
}

class AddPetProfile extends ProfileEvent {
  final PetProfileModel pet;

  const AddPetProfile(this.pet);
}

class DeletePetProfile extends ProfileEvent {
  final String petId;

  const DeletePetProfile(this.petId);
}

class UpdateUserInfo extends ProfileEvent {
  final String name;
  final String phone;
  final String email;

  const UpdateUserInfo({
    required this.name,
    required this.phone,
    required this.email,
  });
}

class AddAddress extends ProfileEvent {
  final String title;
  final String fullAddress;

  const AddAddress(this.title, this.fullAddress);
}

class DeleteAddress extends ProfileEvent {
  final String addressId;

  const DeleteAddress(this.addressId);
}

class AddPaymentMethod extends ProfileEvent {
  final String cardHolder;
  final String lastFourDigits;

  const AddPaymentMethod(this.cardHolder, this.lastFourDigits);
}

class DeletePaymentMethod extends ProfileEvent {
  final String cardId;

  const DeletePaymentMethod(this.cardId);
}

