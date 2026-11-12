/// 7/24 Nöbetçi Acil Veteriner kliniklerinin bilgilerini temsil eden veri modeli.
class EmergencyVetClinicModel {
  // Kliniğin benzersiz kimlik numarası (örn: 'vet_1')
  final String id;
  // Kliniğin tam ticari / kurumsal adı
  final String name;
  // Kliniğin bulunduğu ilçe veya semt bilgisi
  final String district;
  // Kullanıcının seçtiği adrese olan yaklaşık kuş uçuşu / yol mesafesi
  final String distance;
  // Kliniğin açık cadde, sokak ve kapı numarası adresi
  final String address;
  // Acil durumlarda hemen aranabilecek nöbetçi hekim telefon hattı
  final String phone;
  // Kliniğin 7 gün 24 saat kesintisiz hizmet verip vermediği bayrağı
  final bool isOpen24h;
  // Hasta sahiplerinin kliniğe verdiği ortalama memnuniyet puanı (1.0 - 5.0)
  final double rating;

  // Model yapıcısı (Constructor): Gerekli tüm alanları zorunlu olarak alır.
  const EmergencyVetClinicModel({
    required this.id,
    required this.name,
    required this.district,
    required this.distance,
    required this.address,
    required this.phone,
    this.isOpen24h = true,
    this.rating = 4.9,
  });

  // Kullanıcıya ilk açılışta ve arama sonuçlarında gösterilen örnek nöbetçi klinikler listesi.
  static const List<EmergencyVetClinicModel> sampleClinics = [
    EmergencyVetClinicModel(
      id: 'vet_1',
      name: 'Kadıköy 7/24 Acil Hayvan Hastanesi',
      district: 'Kadıköy',
      distance: '1.2 km',
      address: 'Fenerbahçe Mah. Kalamış Cad. No: 48, Kadıköy / İstanbul',
      phone: '0216 444 0 724',
      rating: 4.9,
    ),
    EmergencyVetClinicModel(
      id: 'vet_2',
      name: 'Moda Nöbetçi Veteriner Kliniği',
      district: 'Moda',
      distance: '1.8 km',
      address: 'Caferağa Mah. Şair Nefi Sok. No: 15, Moda / Kadıköy',
      phone: '0216 330 22 11',
      rating: 4.8,
    ),
    EmergencyVetClinicModel(
      id: 'vet_3',
      name: 'Bağdat Caddesi Pet Hospital & Yoğun Bakım',
      district: 'Caddebostan',
      distance: '2.5 km',
      address: 'Caddebostan Mah. Bağdat Cad. No: 312, Kadıköy',
      phone: '0216 360 88 99',
      rating: 4.9,
    ),
    EmergencyVetClinicModel(
      id: 'vet_4',
      name: 'Ataşehir 7/24 Acil Veteriner Tıp Merkezi',
      district: 'Ataşehir',
      distance: '4.1 km',
      address: 'Atatürk Mah. Meriç Cad. No: 22, Ataşehir / İstanbul',
      phone: '0216 455 12 34',
      rating: 4.7,
    ),
    EmergencyVetClinicModel(
      id: 'vet_5',
      name: 'Beşiktaş & Levent Acil Nöbetçi Kliniği',
      district: 'Levent',
      distance: '6.3 km',
      address: 'Büyükdere Cad. No: 140, Levent / Beşiktaş',
      phone: '0212 280 90 90',
      rating: 4.8,
    ),
  ];
}
