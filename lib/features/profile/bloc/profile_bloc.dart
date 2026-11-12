import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/mock_data.dart';
import '../../../core/models/pet_profile_model.dart';
import '../../../core/repositories/auth_repository.dart';
import '../../../core/repositories/user_repository.dart';
import '../models/profile_extra_models.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepo;
  final AuthRepository _authRepo;

  ProfileBloc({UserRepository? userRepo, AuthRepository? authRepo})
      : _userRepo = userRepo ?? UserRepository(),
        _authRepo = authRepo ?? AuthRepository(),
        super(const ProfileInitial()) {
    on<LoadProfileData>(_onLoadProfileData);
    on<SwitchPetTab>((e, emit) {
      if (state is ProfileLoaded) emit((state as ProfileLoaded).copyWith(selectedPetTab: e.selectedType));
    });
    on<AddPetProfile>(_onAddPetProfile);
    on<DeletePetProfile>(_onDeletePetProfile);
    on<UpdateUserInfo>(_onUpdateUserInfo);
    on<AddAddress>(_onAddAddress);
    on<DeleteAddress>(_onDeleteAddress);
    on<AddPaymentMethod>(_onAddPaymentMethod);
    on<DeletePaymentMethod>(_onDeletePaymentMethod);
  }

  Future<void> _onLoadProfileData(LoadProfileData event, Emitter<ProfileState> emit) async {
    String name = 'Ahmet Yılmaz', phone = '+90 555 123 45 67', email = 'ahmet@wepet.com';
    final user = _authRepo.currentUser;
    if (user != null) {
      email = user.email ?? email;
      try {
        final profile = await _userRepo.getUserProfile(user.uid);
        if (profile != null) {
          name = profile['name'] ?? name;
          phone = profile['phone'] ?? phone;
        }
      } catch (_) {}
    }
    emit(ProfileLoaded(
      pets: List<PetProfileModel>.from(MockData.samplePets),
      userName: name, userPhone: phone, userEmail: email,
      addresses: const [
        UserAddressModel(id: 'addr_1', title: 'Ev Adresi', fullAddress: 'Fenerbahçe Mah. Lale Sok. No: 12 D: 4, Kadıköy / İstanbul'),
        UserAddressModel(id: 'addr_2', title: 'İş Yeri', fullAddress: 'Büyükdere Cad. No: 193, Levent / İstanbul'),
      ],
      paymentCards: const [
        UserPaymentCardModel(id: 'card_1', cardHolder: 'Ahmet Yılmaz', lastFourDigits: '4512'),
        UserPaymentCardModel(id: 'card_2', cardHolder: 'Ahmet Yılmaz', lastFourDigits: '8820'),
      ],
      menuItems: MockData.getProfileMenu(),
    ));
  }

  Future<void> _onAddPetProfile(AddPetProfile event, Emitter<ProfileState> emit) async {
    final s = state;
    if (s is ProfileLoaded) {
      final user = _authRepo.currentUser;
      if (user != null) { try { await _userRepo.addPet(user.uid, event.pet); } catch (_) {} }
      emit(s.copyWith(pets: List<PetProfileModel>.from(s.pets)..add(event.pet), selectedPetTab: event.pet.type));
    }
  }

  Future<void> _onDeletePetProfile(DeletePetProfile event, Emitter<ProfileState> emit) async {
    final s = state;
    if (s is ProfileLoaded) {
      final user = _authRepo.currentUser;
      if (user != null) { try { await _userRepo.deletePet(user.uid, event.petId); } catch (_) {} }
      emit(s.copyWith(pets: s.pets.where((p) => p.id != event.petId).toList()));
    }
  }

  Future<void> _onUpdateUserInfo(UpdateUserInfo event, Emitter<ProfileState> emit) async {
    final s = state;
    if (s is ProfileLoaded) {
      final user = _authRepo.currentUser;
      if (user != null) {
        try { await _userRepo.saveUserProfile(uid: user.uid, name: event.name, email: event.email, phone: event.phone); } catch (_) {}
      }
      emit(s.copyWith(userName: event.name, userPhone: event.phone, userEmail: event.email));
    }
  }

  Future<void> _onAddAddress(AddAddress event, Emitter<ProfileState> emit) async {
    final s = state;
    if (s is ProfileLoaded) {
      final newAddr = UserAddressModel(id: 'addr_${DateTime.now().millisecondsSinceEpoch}', title: event.title, fullAddress: event.fullAddress);
      final user = _authRepo.currentUser;
      if (user != null) { try { await _userRepo.addAddress(user.uid, newAddr); } catch (_) {} }
      emit(s.copyWith(addresses: [...s.addresses, newAddr]));
    }
  }

  Future<void> _onDeleteAddress(DeleteAddress event, Emitter<ProfileState> emit) async {
    final s = state;
    if (s is ProfileLoaded) {
      final target = s.addresses.firstWhere((a) => a.id == event.addressId);
      final user = _authRepo.currentUser;
      if (user != null) { try { await _userRepo.deleteAddress(user.uid, target); } catch (_) {} }
      emit(s.copyWith(addresses: s.addresses.where((a) => a.id != event.addressId).toList()));
    }
  }

  Future<void> _onAddPaymentMethod(AddPaymentMethod event, Emitter<ProfileState> emit) async {
    final s = state;
    if (s is ProfileLoaded) {
      final newCard = UserPaymentCardModel(id: 'card_${DateTime.now().millisecondsSinceEpoch}', cardHolder: event.cardHolder, lastFourDigits: event.lastFourDigits);
      final user = _authRepo.currentUser;
      if (user != null) { try { await _userRepo.addPaymentCard(user.uid, newCard); } catch (_) {} }
      emit(s.copyWith(paymentCards: [...s.paymentCards, newCard]));
    }
  }

  Future<void> _onDeletePaymentMethod(DeletePaymentMethod event, Emitter<ProfileState> emit) async {
    final s = state;
    if (s is ProfileLoaded) {
      final target = s.paymentCards.firstWhere((c) => c.id == event.cardId);
      final user = _authRepo.currentUser;
      if (user != null) { try { await _userRepo.deletePaymentCard(user.uid, target); } catch (_) {} }
      emit(s.copyWith(paymentCards: s.paymentCards.where((c) => c.id != event.cardId).toList()));
    }
  }
}
