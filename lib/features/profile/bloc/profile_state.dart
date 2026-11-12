import '../../../core/models/pet_profile_model.dart';
import '../../../core/models/profile_menu_item_model.dart';
import '../models/profile_extra_models.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoaded extends ProfileState {
  final PetType selectedPetTab;
  final List<PetProfileModel> pets;
  final String userName;
  final String userPhone;
  final String userEmail;
  final String inviteCode;
  final List<UserAddressModel> addresses;
  final List<UserPaymentCardModel> paymentCards;
  final List<ProfileMenuItemModel> menuItems;

  const ProfileLoaded({
    this.selectedPetTab = PetType.dog,
    required this.pets,
    this.userName = 'Ahmet Yılmaz',
    this.userPhone = '+90 555 123 45 67',
    this.userEmail = 'ahmet.yilmaz@wepet.com',
    this.inviteCode = 'WEPET2026',
    required this.addresses,
    required this.paymentCards,
    required this.menuItems,
  });

  // Geriye dönük uyumluluk için getter
  PetType get selectedPetType => selectedPetTab;

  List<PetProfileModel> get filteredPets =>
      pets.where((p) => p.type == selectedPetTab).toList();

  ProfileLoaded copyWith({
    PetType? selectedPetTab,
    List<PetProfileModel>? pets,
    String? userName,
    String? userPhone,
    String? userEmail,
    String? inviteCode,
    List<UserAddressModel>? addresses,
    List<UserPaymentCardModel>? paymentCards,
    List<ProfileMenuItemModel>? menuItems,
  }) {
    return ProfileLoaded(
      selectedPetTab: selectedPetTab ?? this.selectedPetTab,
      pets: pets ?? this.pets,
      userName: userName ?? this.userName,
      userPhone: userPhone ?? this.userPhone,
      userEmail: userEmail ?? this.userEmail,
      inviteCode: inviteCode ?? this.inviteCode,
      addresses: addresses ?? this.addresses,
      paymentCards: paymentCards ?? this.paymentCards,
      menuItems: menuItems ?? this.menuItems,
    );
  }
}
