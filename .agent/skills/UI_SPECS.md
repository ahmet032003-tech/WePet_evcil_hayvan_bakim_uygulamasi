# UI Specifications & Screen Implementations

Ekteki ekran tasarımlarına sadık kalınarak geliştirilecek 4 ana ekranın bileşen ve veri modeli detaylarıdır.

## 1. Veri Modelleri (Core Models)

### `service_item_model.dart`
- `id`: String
- `title`: String
- `icon`: IconData
- `badgeText`: String?
- `badgeColor`: Color?

### `pet_profile_model.dart`
- `id`: String
- `name`: String
- `type`: Enum (`dog`, `cat`)
- `breed`: String?
- `age`: int?

### `profile_menu_item_model.dart`
- `id`: String
- `title`: String
- `icon`: IconData
- `onTap`: VoidCallback

---

## 2. Ekran Gereksinimleri

### Ekran 1: Ana Sayfa (Home Screen)
- **AppBar:** Sol tarafta logo/metin (`DogGO`), sağ tarafta kalkan (güvenlik) ve hediye paketi aksiyon ikonları.
- **Hero Banner:** Üst kısımda yuvarlatılmış köşeli büyük kampanya/reklam kartı (Otomol / Volvo iş birliği görsel alanı).
- **Bölüm Başlığı:** Çerçeveli hap (pill) kutu: `"DOSTUN İÇİN UYGUN HİZMETİ SEÇ!"`.
- **Hizmet Kartları Grid'i:**
  - `TEK YÜRÜYÜŞ` (Şimşek ikonu)
  - `RUTİN YÜRÜYÜŞ` (Takvim ikonu, `%10` sarı rozet)
  - `KÖPEK EVDE BAKIM` (Köpek patisi/yüzü ikonu)
  - `KEDI EVDE BAKIM` (Kedi ikonu)
  - `MOBİL PET KUAFÖR` (Makas ikonu, `YENİ` mor rozet)
  - `DogGO Shop` (Çanta ikonu, `200 TL Kazan!` sarı rozet)
  - `KÖPEK EĞİTİMİ` (Düdük ikonu, `Bedava Tanışma` rozeti)
- **Alt Banner:** Turuncu degrade zemin, solunda hediye ikonu, `"Ücretsiz Tanışma Yürüyüşü"` metni ve sağ köşede çapraz `"FREE"` rozeti.

### Ekran 2: Shop Karşılama Ekranı
- **AppBar:** Sade başlık (`DogGO Shop`).
- **Merkez İllüstrasyon Alanı:** 3D yumuşak mama kabı, kedi oyuncağı ve ödül tasması kompozisyonu alanı.
- **Başlık & Açıklama:** Kalın başlık (`DogGO Shop'a Hoş Geldin!`) ve açıklama metni.
- **Alt Buton:** Tam genişlikte turuncu aksiyon butonu: `"Şimdi 200 TL Kazan! >"`.

### Ekran 3: Hizmetlerim Ekranı (Empty State)
- **AppBar:** Başlık (`HİZMETLERİM`).
- **İçerik:** Sol alanda `"Hizmet Geçmişin ve Planların Burada!"` başlığı ve açıklama metni; sağ tarafta kedi/köpek illüstrasyonu.
- **Alt Sabit Buton:** Ekran altına sabitlenmiş pati ikonlu buton: `"PET PROFİLİ OLUŞTUR >"`.

### Ekran 4: Profil Ekranı
- **Üst Header & Sekmeler:** Turuncu üst alan, sağda ayarlar çarkı, ortada `[Köpeklerim | Kedilerim]` segmented control kapsül yapısı.
- **Pet Ekleme Alanı:** Açık krem daire içinde turuncu `+` ikonu ve hemen altında `"Köpek Ekle"` beyaz kartı.
- **Liste Menüsü:** 
  - Kişisel Bilgiler
  - DogGO Kodunuz
  - Adreslerim
  - Ödeme Yöntemi
  - Yardım
  - Hemen Walker Ol