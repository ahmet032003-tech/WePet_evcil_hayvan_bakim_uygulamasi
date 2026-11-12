import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_state.dart';

class InviteCodeScreen extends StatelessWidget {
  const InviteCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('WePet Kodunuz', style: AppTextStyles.appBarTitle),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final code = state is ProfileLoaded ? state.inviteCode : 'WEPET2026';

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.card_giftcard_rounded,
                    size: 60,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Arkadaşını Davet Et,\nİkiniz de 200 TL Kazanın!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading1,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Davet kodunu dostlarınla paylaş. Onlar ilk yürüyüşünü tamamladığında hem sen hem arkadaşın 200 TL WePet Shop kuponu kazansın.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMuted,
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.cardSurface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primary, width: 1.5),
                    boxShadow: AppColors.softShadow,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        code,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                          color: AppColors.primary,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: code));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Davet kodu panoya kopyalandı!'),
                              backgroundColor: AppColors.secondary,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.copy_rounded, size: 18),
                        label: const Text('Kopyala'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: 'WePet davet kodum: $code'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Paylaşım linki kopyalandı!'),
                        backgroundColor: AppColors.secondary,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.share_rounded),
                  label: const Text('Arkadaşınla Paylaş'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

