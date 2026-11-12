// Firestore veritabanı kütüphanesini içe aktarır
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pet_profile_model.dart';
import '../../features/profile/models/profile_extra_models.dart';

/// Kullanıcı profili, evcil hayvanları, adresleri ve kayıtlı ödeme kartlarını Firestore'da yöneten Veri Deposu.
class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Kullanıcının ad, e-posta, telefon ve davet kodunu 'users/{uid}' dökümanına kaydeder/günceller.
  Future<void> saveUserProfile({
    required String uid,
    required String name,
    required String email,
    required String phone,
    String inviteCode = 'WEPET2026',
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'inviteCode': inviteCode,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true)); // Mevcut diğer alanları silmeden üzerine birleştirir (merge).
  }

  /// Kullanıcının Firestore'daki profil bilgilerini getirir.
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }

  /// Kullanıcının 'users/{uid}/pets' alt koleksiyonuna yeni bir pet profili ekler.
  Future<void> addPet(String uid, PetProfileModel pet) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('pets')
        .doc(pet.id)
        .set({
      'name': pet.name,
      'breed': pet.breed,
      'type': pet.type == PetType.dog ? 'dog' : 'cat',
      'age': pet.age,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Kullanıcının pet dökümanını siler.
  Future<void> deletePet(String uid, String petId) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('pets')
        .doc(petId)
        .delete();
  }

  /// Kullanıcının kayıtlı petlerini gerçek zamanlı dinleyen akış (Stream).
  Stream<List<PetProfileModel>> getUserPetsStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('pets')
        .snapshots()
        .map((snap) => snap.docs.map((d) {
              final data = d.data();
              return PetProfileModel(
                id: d.id,
                name: data['name'] ?? '',
                breed: data['breed'] as String?,
                type: data['type'] == 'cat' ? PetType.cat : PetType.dog,
                age: data['age'] as int?,
              );
            }).toList());
  }

  /// Kullanıcı profiline yeni bir teslimat adresi ekler (Diziye ekleme: arrayUnion).
  Future<void> addAddress(String uid, UserAddressModel address) async {
    await _firestore.collection('users').doc(uid).set({
      'addresses': FieldValue.arrayUnion([
        {
          'id': address.id,
          'title': address.title,
          'fullAddress': address.fullAddress,
        }
      ]),
    }, SetOptions(merge: true));
  }

  /// Kullanıcı profilinden kayıtlı bir adresi siler (Diziden çıkarma: arrayRemove).
  Future<void> deleteAddress(String uid, UserAddressModel address) async {
    await _firestore.collection('users').doc(uid).update({
      'addresses': FieldValue.arrayRemove([
        {
          'id': address.id,
          'title': address.title,
          'fullAddress': address.fullAddress,
        }
      ]),
    });
  }

  /// Kullanıcı profiline yeni bir ödeme kartı kaydeder.
  Future<void> addPaymentCard(String uid, UserPaymentCardModel card) async {
    await _firestore.collection('users').doc(uid).set({
      'paymentCards': FieldValue.arrayUnion([
        {
          'id': card.id,
          'cardHolder': card.cardHolder,
          'lastFourDigits': card.lastFourDigits,
        }
      ]),
    }, SetOptions(merge: true));
  }

  /// Kullanıcı profilinden kayıtlı ödeme kartını siler.
  Future<void> deletePaymentCard(String uid, UserPaymentCardModel card) async {
    await _firestore.collection('users').doc(uid).update({
      'paymentCards': FieldValue.arrayRemove([
        {
          'id': card.id,
          'cardHolder': card.cardHolder,
          'lastFourDigits': card.lastFourDigits,
        }
      ]),
    });
  }
}
