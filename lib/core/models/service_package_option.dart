/// Bir hizmete ait tek bir tarife/paket seçeneğini temsil eden veri modeli (örn: "30 Dakika", ₺220).
class ServicePackageOption {
  // Paketin ekranda görünen başlığı (örn: "Tam Gün Evde Bakım", "Yıkama & Fön")
  final String title;
  // Paketin TL cinsinden ücreti
  final double price;
  // İsteğe bağlı ek açıklama veya süre detayı
  final String? subtitle;

  const ServicePackageOption({
    required this.title,
    required this.price,
    this.subtitle,
  });
}

/// Seçilen hizmete göre dinamik bölüm başlığı ve sunulacak paket listesini yapılandıran sınıf.
class ServiceTariffConfig {
  // Modal penceresinde seçeneklerin üzerinde yazacak başlık (örn: "Yürüyüş Süresi", "Kuaför & Bakım Türü")
  final String sectionTitle;
  // Bu hizmet için sunulan paketlerin listesi
  final List<ServicePackageOption> options;

  const ServiceTariffConfig({
    required this.sectionTitle,
    required this.options,
  });

  /// Hizmetin kimliğine (id) ve adına göre en uygun tarife paketlerini dinamik olarak seçer ve döndürür.
  static ServiceTariffConfig forService(String serviceId, String serviceTitle) {
    final id = serviceId.toLowerCase();
    final title = serviceTitle.toLowerCase();

    // 1. Köpek Gezdirme Hizmetleri (Tek Seferlik Yürüyüş, Rutin Yürüyüş)
    if (id.contains('walk') || title.contains('yürüyüş') || title.contains('yuruyus')) {
      return const ServiceTariffConfig(
        sectionTitle: 'Yürüyüş Süresi',
        options: [
          ServicePackageOption(title: '30 Dakika', price: 220),
          ServicePackageOption(title: '45 Dakika', price: 290),
          ServicePackageOption(title: '60 Dakika', price: 360),
          ServicePackageOption(title: '90 Dakika', price: 480),
        ],
      );
    }

    // 2. Evde Bakım Hizmetleri (Köpek Evde Bakım & Kedi Evde Bakım)
    if (id.contains('home_care') || title.contains('evde bakım') || title.contains('evde bakim')) {
      return const ServiceTariffConfig(
        sectionTitle: 'Bakım Paketi / Ziyaret Tipi',
        options: [
          ServicePackageOption(title: 'Tek Ziyaret (Besleme & Oyun)', price: 250),
          ServicePackageOption(title: 'Günde 2 Ziyaret (Sabah - Akşam)', price: 450),
          ServicePackageOption(title: 'Tam Gün Evde Bakım', price: 650),
          ServicePackageOption(title: 'Yatılı Konaklama (Gece Dahil)', price: 850),
        ],
      );
    }

    // 3. Mobil Pet Kuaför Hizmetleri (Tıraş, Yıkama, Tırnak Kesimi, SPA)
    if (id.contains('grooming') || title.contains('kuaför') || title.contains('kuafor')) {
      return const ServiceTariffConfig(
        sectionTitle: 'Kuaför & Bakım Türü',
        options: [
          ServicePackageOption(title: 'Yıkama & Fön', price: 380),
          ServicePackageOption(title: 'Makas / Makine Tıraşı', price: 520),
          ServicePackageOption(title: 'Tırnak & Kulak Bakımı', price: 200),
          ServicePackageOption(title: 'Tam SPA & Bakım Paketi', price: 750),
        ],
      );
    }

    // 4. Köpek Eğitimi Programları (İtaat, Tuvalet, Sosyalleşme)
    if (id.contains('train') || title.contains('eğitim') || title.contains('egitim')) {
      return const ServiceTariffConfig(
        sectionTitle: 'Eğitim Programı',
        options: [
          ServicePackageOption(title: 'Temel İtaat', price: 1200),
          ServicePackageOption(title: 'Tuvalet Eğitimi', price: 850),
          ServicePackageOption(title: 'Sosyalleşme', price: 1500),
          ServicePackageOption(title: 'Davranış Düzeltme', price: 1900),
        ],
      );
    }

    // 5. Pet Taksi ve Diğer Hizmetler için Genel Seçenekler
    return const ServiceTariffConfig(
      sectionTitle: 'Yolculuk & Hizmet Tipi',
      options: [
        ServicePackageOption(title: 'Tek Yön', price: 250),
        ServicePackageOption(title: 'Gidiş - Dönüş', price: 420),
        ServicePackageOption(title: 'Veteriner Beklemeli', price: 580),
      ],
    );
  }
}
