// Firebase çekirdek servislerini başlatan resmi paketi içe aktarır.
import 'package:firebase_core/firebase_core.dart';
// Flutter'ın temel Material UI widget kütüphanesini içe aktarır.
import 'package:flutter/material.dart';
// BLoC durum yönetimi (State Management) sağlayıcılarını içe aktarır.
import 'package:flutter_bloc/flutter_bloc.dart';
// Uygulamanın Sıcak Amber/Karamel temalı genel tasarım şablonunu içe aktarır.
import 'core/theme/app_theme.dart';
// Kullanıcı kimlik doğrulama mantığını yöneten AuthBloc ve state sınıflarını içe aktarır.
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/bloc/auth_state.dart';
// Kullanıcı giriş yapmamışsa gösterilecek olan Giriş/Kayıt ekranını içe aktarır.
import 'features/auth/screens/auth_screen.dart';
// Kullanıcı giriş yapmışsa gösterilecek olan 5 sekmeli ana navigasyon ekranını içe aktarır.
import 'features/main_navigation_screen.dart';
// Kullanıcı profilini, adreslerini ve kartlarını yöneten ProfileBloc bileşenlerini içe aktarır.
import 'features/profile/bloc/profile_bloc.dart';
import 'features/profile/bloc/profile_event.dart';
// Rezervasyonları ve durumlarını yöneten ReservationBloc bileşenlerini içe aktarır.
import 'features/reservations/bloc/reservation_bloc.dart';
import 'features/reservations/bloc/reservation_event.dart';
// Firebase proje konfigürasyonunu (API anahtarı, proje ID vb.) içeren dosyayı içe aktarır.
import 'firebase_options.dart';

/// Uygulamanın başlangıç noktası (Entry Point).
Future<void> main() async {
  // Flutter motoru ve widget bağlayıcılarının asenkron işlemler öncesinde hazır olmasını sağlar.
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Firebase backend altyapısını platforma uygun API anahtarlarıyla başlatır.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Firebase bağlantısı kurulamazsa veya çevrimdışıysa uygulamanın çökmesini önler.
    debugPrint('Firebase initialization info: $e');
  }
  // Kök widget'ı çalıştırarak uygulamayı ekrana basar.
  runApp(const WePetApp());
}

/// WePet uygulamasının kök widget'ı.
class WePetApp extends StatelessWidget {
  const WePetApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Uygulama genelinde kullanılacak BLoC yöneticilerini tek bir çatı altında sağlar.
    return MultiBlocProvider(
      providers: [
        // Kullanıcı oturum durumunu (giriş yapıldı/çıkış yapıldı) yöneten sağlayıcı.
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
        // Aktif ve geçmiş rezervasyonları yöneten ve başlangıçta yükleyen sağlayıcı.
        BlocProvider<ReservationBloc>(
          create: (_) => ReservationBloc()..add(const LoadReservations()),
        ),
        // Kullanıcı profilini, pet profillerini ve adresleri yükleyen sağlayıcı.
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc()..add(const LoadProfileData()),
        ),
      ],
      // Material Design tasarım sistemini ve tema ayarlarını yapılandıran ana uygulama çatısı.
      child: MaterialApp(
        title: 'WePet', // İşletim sisteminde ve görev yöneticisinde görünen uygulama başlığı
        debugShowCheckedModeBanner: false, // Sağ üstteki "Debug" flamasını gizler
        theme: AppTheme.lightTheme, // Özel hazırladığımız açık renk Sıcak Amber teması
        // Kullanıcının oturum açma durumuna göre dinamik yönlendirme yapar.
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            // Eğer kullanıcı oturum açmışsa ana sekmeli ekranı gösterir.
            if (state.isAuthenticated) {
              return const MainNavigationScreen();
            }
            // Oturum açılmamışsa doğrudan modern Giriş/Kayıt ekranını karşılar.
            return const AuthScreen();
          },
        ),
      ),
    );
  }
}
