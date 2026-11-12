# Agent Skills & Architecture Guidelines

Bu belge, Flutter Pet Bakım & Gezdirme uygulamasında uyulması zorunlu mimari kuralları ve standartları belirler.

## 1. Mimari Prensipler
- **State Management:** BLoC / Cubit deseni zorunludur. Ekran widget'ları içinde doğrudan `setState` ile iş mantığı yürütülmez.
- **Klasör Yapısı (Feature-First):**
  lib/
  ├── core/
  │   ├── constants/ (app_colors.dart, app_text_styles.dart)
  │   ├── theme/     (app_theme.dart)
  │   └── widgets/   (badge_wrapper.dart, custom_bottom_nav.dart)
  └── features/
      ├── home/      (bloc/, models/, screens/, widgets/)
      ├── services/  (bloc/, screens/, widgets/)
      ├── shop/      (bloc/, screens/, widgets/)
      └── profile/   (bloc/, screens/, widgets/)

## 2. Tasarım & UI Kuralları
- **Renk Paleti:**
  - Primary (Turuncu/Mercan): `#FF725E`
  - PrimaryLight (Açık Şeftali Zemin): `#FFF7F2`
  - Surface (Kart Zeminleri): `#FFFFFF`
  - Accent Mor: `#6C5CE7`
  - Accent Sarı/Turuncu: `#FFA801`
  - TextDark: `#2D3436`
  - TextMuted: `#A4B0BE`
- **Köşe Yuvarlaklıkları:** Kart ve butonlarda `borderRadius: BorderRadius.circular(20)` standardı korunur.
- **Gölgelendirme:** Sert gölgeler kullanılmaz. `BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: Offset(0, 4))` uygulanır.
- **Bileşen Parçalama:** 150 satırı aşan widget yapıları `widgets/` dizini altına alt bileşenlere bölünmelidir.