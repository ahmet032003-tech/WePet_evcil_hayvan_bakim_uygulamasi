import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';

class SettingsBottomSheet extends StatefulWidget {
  const SettingsBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SettingsBottomSheet(),
    );
  }

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        14,
        20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Ayarlar', style: AppTextStyles.heading2),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Bildirim İzinleri', style: AppTextStyles.cardTitle),
            subtitle: const Text('Yürüyüş ve randevu bildirimleri', style: AppTextStyles.bodyMuted),
            activeThumbColor: AppColors.primary,
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
          ),
          const Divider(color: AppColors.borderLight, height: 1),
          SwitchListTile(
            title: const Text('Konum Servisleri', style: AppTextStyles.cardTitle),
            subtitle: const Text('Yakındaki walker eşleşmeleri için', style: AppTextStyles.bodyMuted),
            activeThumbColor: AppColors.primary,
            value: _locationEnabled,
            onChanged: (val) => setState(() => _locationEnabled = val),
          ),
          const Divider(color: AppColors.borderLight, height: 1),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded, color: AppColors.primary),
            title: const Text('Uygulama Hakkında', style: AppTextStyles.cardTitle),
            subtitle: const Text('WePet v1.0.0 (Build 2026)', style: AppTextStyles.bodyMuted),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(
                context: context,
                applicationName: 'WePet',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2026 WePet Inc.',
              );
            },
          ),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(const LogoutRequested());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Güvenli çıkış yapıldı.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            label: const Text('Çıkış Yap', style: TextStyle(color: Colors.redAccent)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.redAccent),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ],
      ),
    );
  }
}
