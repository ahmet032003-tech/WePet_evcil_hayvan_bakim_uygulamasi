import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../bloc/reservation_bloc.dart';
import '../bloc/reservation_event.dart';
import '../bloc/reservation_state.dart';
import '../widgets/reservation_card.dart';
import '../widgets/reservations_empty_state.dart';
import '../widgets/reservations_tab_bar.dart';

class ReservationsScreen extends StatefulWidget {
  final ValueChanged<int>? onNavigateTab;

  const ReservationsScreen({super.key, this.onNavigateTab});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  int _selectedTab = 0; // 0: Aktif, 1: Geçmiş

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text('Rezervasyonlarım', style: AppTextStyles.appBarTitle),
      ),
      body: BlocBuilder<ReservationBloc, ReservationState>(
        builder: (context, state) {
          if (state is ReservationLoading || state is ReservationInitial) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          if (state is ReservationLoaded) {
            final activeList = state.activeReservations;
            final pastList = state.completedReservations;

            return Column(
              children: [
                ReservationsTabBar(
                  selectedIndex: _selectedTab,
                  onTabSelected: (idx) => setState(() => _selectedTab = idx),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _selectedTab == 0
                      ? (activeList.isEmpty
                          ? ReservationsEmptyState(
                              onGoHome: () => widget.onNavigateTab?.call(0),
                            )
                          : _buildList(activeList, isActive: true))
                      : _buildList(pastList, isActive: false),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildList(List reservations, {required bool isActive}) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        final res = reservations[index];
        return ReservationCard(
          reservation: res,
          onCancel: isActive
              ? () {
                  context.read<ReservationBloc>().add(CancelReservation(res.id));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Rezervasyon iptal edildi.'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              : null,
          onComplete: isActive
              ? () {
                  context.read<ReservationBloc>().add(CompleteReservation(res.id));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Rezervasyon tamamlandı olarak işaretlendi!'),
                      backgroundColor: AppColors.secondary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              : null,
        );
      },
    );
  }
}

