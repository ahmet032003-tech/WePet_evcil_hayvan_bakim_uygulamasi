// Cloud Firestore veritabanı kütüphanesini içe aktarır
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../features/reservations/models/reservation_model.dart';

/// Rezervasyonların Cloud Firestore üzerinde saklanması, okunması ve canlı izlenmesini yöneten Veri Deposu (Repository).
class ReservationRepository {
  final FirebaseFirestore _firestore; // Firestore istemci örneği

  // Test edilebilirlik için opsiyonel Firestore nesnesi alır; verilmezse varsayılan instance'ı kullanır.
  ReservationRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Yeni oluşturulan rezervasyonu Firestore'daki 'reservations' koleksiyonuna ekler.
  Future<void> addReservation(String uid, ReservationModel reservation) async {
    await _firestore.collection('reservations').doc(reservation.id).set({
      'userId': uid, // Rezervasyonu yapan kullanıcının Firebase Auth UID'si
      'serviceTitle': reservation.serviceTitle, // Hizmet adı (örn: "KÖPEK EVDE BAKIM")
      'serviceIconCode': reservation.serviceIcon.codePoint, // İkonun MaterialIcons kod noktası
      'date': Timestamp.fromDate(reservation.date), // Randevu tarihi
      'timeSlot': reservation.timeSlot, // Randevu saati (örn: "14:00")
      'duration': reservation.duration, // Hizmet süresi veya genel süre bilgisi
      'packageOption': reservation.packageOption ?? reservation.duration, // Seçilen özel tarife paketi
      'price': reservation.price, // Ödenecek toplam tutar (TL)
      'status': reservation.status == ReservationStatus.active ? 'active' : 'completed', // 'active' veya 'completed'
      'createdAt': FieldValue.serverTimestamp(), // Sunucu tarafı oluşturulma zaman damgası
    });
  }

  /// Mevcut bir rezervasyonun durumunu (Aktif -> Tamamlandı) günceller.
  Future<void> updateReservationStatus(
    String reservationId,
    ReservationStatus status,
  ) async {
    await _firestore.collection('reservations').doc(reservationId).update({
      'status': status == ReservationStatus.active ? 'active' : 'completed',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// İptal edilen rezervasyon dökümanını Firestore'dan siler.
  Future<void> cancelReservation(String reservationId) async {
    await _firestore.collection('reservations').doc(reservationId).delete();
  }

  /// Belirli bir kullanıcıya ait rezervasyonları gerçek zamanlı dinleyen akış (Stream).
  /// Veritabanında bir değişiklik olduğunda UI anında otomatik olarak güncellenir.
  Stream<List<ReservationModel>> getUserReservationsStream(String uid) {
    return _firestore
        .collection('reservations')
        .where('userId', isEqualTo: uid) // Sadece giriş yapan kullanıcının verilerini filtreler
        .snapshots() // Canlı dinleme akışı
        .map((snap) => snap.docs.map((d) {
              final data = d.data();
              final ts = data['date'] as Timestamp?;
              final date = ts != null ? ts.toDate() : DateTime.now();
              final iconCode = data['serviceIconCode'] as int? ?? Icons.pets_rounded.codePoint;

              return ReservationModel(
                id: d.id,
                serviceTitle: data['serviceTitle'] ?? '',
                // ignore: non_const_argument_for_const_parameter
                serviceIcon: IconData(iconCode, fontFamily: 'MaterialIcons'),
                date: date,
                timeSlot: data['timeSlot'] ?? '',
                duration: data['duration'] ?? '',
                packageOption: data['packageOption'] as String? ?? data['duration'] ?? '',
                price: (data['price'] as num?)?.toDouble() ?? 0.0,
                status: data['status'] == 'completed'
                    ? ReservationStatus.completed
                    : ReservationStatus.active,
              );
            }).toList());
  }
}
