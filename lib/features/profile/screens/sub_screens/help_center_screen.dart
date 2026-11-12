import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const faqs = [
      (
        q: 'Walker dostum randevuya nasıl gelir?',
        a: 'Randevu saatinizde eşleşen sertifikalı walker kapınıza gelir, güvenli tasma takarak yürüyüşü canlı GPS ile başlatır.',
      ),
      (
        q: 'Rezervasyonumu nasıl iptal edebilirim?',
        a: 'Rezervasyonlarım sekmesinden randevu saatinden 2 saat öncesine kadar ücretsiz iptal gerçekleştirebilirsiniz.',
      ),
      (
        q: 'Evde bakım hizmetinde walker evimde ne kadar kalır?',
        a: 'Seçtiğiniz paket süresine göre (30, 45, 60 dk) evinizde besleme, oyun, tuvalet ve sevgi seansı gerçekleştirilir.',
      ),
      (
        q: 'Ödeme ve faturalandırma nasıl çalışır?',
        a: 'Tüm ödemeler 256-bit SSL güvencesiyle kayıtlı kartınızdan hizmet tamamlandıktan sonra otomatik tahsil edilir.',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Yardım Merkezi', style: AppTextStyles.appBarTitle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: faqs.length,
              itemBuilder: (ctx, i) {
                final faq = faqs[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.cardSurface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: AppColors.softShadow,
                  ),
                  child: ExpansionTile(
                    shape: const Border(),
                    title: Text(faq.q, style: AppTextStyles.cardTitle),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(faq.a, style: AppTextStyles.bodyMuted),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Canlı destek uzmanı görüşmeye atanıyor... 🎧'),
                      backgroundColor: AppColors.secondary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.headset_mic_rounded),
                label: const Text('Canlı Desteğe Bağlan'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

