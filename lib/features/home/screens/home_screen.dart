// Flutter temel Material UI bileşenleri ve BLoC durum yönetimi kütüphaneleri
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../../reservations/bloc/reservation_bloc.dart';
import '../../reservations/bloc/reservation_event.dart';
import '../../reservations/models/reservation_model.dart';
import '../../emergency_vet/screens/emergency_vet_sheet.dart';
import '../widgets/hero_campaign_banner.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/partnership_dialog.dart';
import '../widgets/section_pill_header.dart';
import '../widgets/service_detail_bottom_sheet.dart';
import '../widgets/service_grid_section.dart';

/// WePet ana ekranı: Banner, hizmet kartları ızgarası ve acil veteriner erişimini barındırır.
class HomeScreen extends StatelessWidget {
  final ValueChanged<int>? onNavigateTab; // Sekmeler arası geçişi sağlayan callback (örn: Shop sekmesine geçiş)

  const HomeScreen({super.key, this.onNavigateTab});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(const LoadHomeData()), // Ana sayfa hizmet verilerini yükler
      child: Scaffold(
        backgroundColor: AppColors.background,
        // Üst Bar: WePet logosu ve "ACİL" 7/24 Nöbetçi Veteriner Butonu
        appBar: HomeAppBar(
          onEmergencyTap: () => EmergencyVetSheet.show(context),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            if (state is HomeError) {
              return Center(child: Text(state.message, style: AppTextStyles.bodyRegular));
            }

            if (state is HomeLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. WePet Tanıtım & Kampanya Görsel Bannerı
                    HeroCampaignBanner(
                      onTap: () => PartnershipDialog.show(context),
                    ),
                    const SizedBox(height: 20),
                    // 2. "HİZMETLERİMİZ" Bölüm Başlık Kapsülü
                    const SectionPillHeader(),
                    const SizedBox(height: 18),
                    // 3. 2 Sütunlu Hizmet Kartları Izgarası (Yürüyüş, Evde Bakım, Kuaför, Eğitim vb.)
                    ServiceGridSection(
                      services: state.services,
                      selectedService: state.selectedService,
                      onServiceTap: (service) {
                        context.read<HomeBloc>().add(SelectService(service));
                        // Eğer kullanıcı "WePet Shop" kartına basarsa Mağaza sekmesine (index: 1) yönlendirir.
                        if (service.id == 'wepet_shop') {
                          onNavigateTab?.call(1);
                        } else {
                          // Diğer hizmetlerde dinamik tarife paketli rezervasyon modalını açar.
                          ServiceDetailBottomSheet.show(
                            context,
                            service,
                            onBooked: (date, slot, package) {
                              context.read<HomeBloc>().add(
                                    CreateReservation(
                                      service: service,
                                      date: date,
                                      timeSlot: slot,
                                      packageOption: package.title,
                                      price: package.price,
                                    ),
                                  );
                              // Yeni rezervasyonu Firestore ve in-memory listeye ekler.
                              final res = ReservationModel(
                                id: 'res_${DateTime.now().millisecondsSinceEpoch}',
                                serviceTitle: service.title,
                                serviceIcon: service.icon,
                                date: date,
                                timeSlot: slot,
                                duration: package.title,
                                packageOption: package.title,
                                price: package.price,
                                status: ReservationStatus.active,
                              );
                              context.read<ReservationBloc>().add(AddReservation(res));
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 24), // Sayfa altı ferah boşluk
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
