import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class BecomeWalkerScreen extends StatefulWidget {
  const BecomeWalkerScreen({super.key});

  @override
  State<BecomeWalkerScreen> createState() => _BecomeWalkerScreenState();
}

class _BecomeWalkerScreenState extends State<BecomeWalkerScreen> {
  final _nameController = TextEditingController();
  String _selectedCity = 'İstanbul - Kadıköy';
  String _selectedExp = '1-3 Yıl Evcil Hayvan Sahibi';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Hemen Walker Ol', style: AppTextStyles.appBarTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.directions_walk_rounded, size: 36, color: AppColors.primary),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'Pati dostlarıyla vakit geçirerek ek gelir kazan, WePet ailesine katıl!',
                      style: AppTextStyles.cardTitle,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Adınız Soyadınız'),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _selectedCity,
              decoration: const InputDecoration(labelText: 'Hizmet Vereceğiniz Bölge'),
              items: const [
                DropdownMenuItem(value: 'İstanbul - Kadıköy', child: Text('İstanbul - Kadıköy')),
                DropdownMenuItem(value: 'İstanbul - Beşiktaş', child: Text('İstanbul - Beşiktaş')),
                DropdownMenuItem(value: 'Ankara - Çankaya', child: Text('Ankara - Çankaya')),
                DropdownMenuItem(value: 'İzmir - Karşıyaka', child: Text('İzmir - Karşıyaka')),
              ],
              onChanged: (val) => setState(() => _selectedCity = val!),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _selectedExp,
              decoration: const InputDecoration(labelText: 'Evcil Hayvan Deneyimi'),
              items: const [
                DropdownMenuItem(value: '1-3 Yıl Evcil Hayvan Sahibi', child: Text('1-3 Yıl Evcil Hayvan Sahibi')),
                DropdownMenuItem(value: '3+ Yıl Evcil Hayvan Sahibi', child: Text('3+ Yıl Evcil Hayvan Sahibi')),
                DropdownMenuItem(value: 'Veterinerlik Öğrencisi / Mezunu', child: Text('Veterinerlik Öğrencisi / Mezunu')),
              ],
              onChanged: (val) => setState(() => _selectedExp = val!),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: _submitApplication,
              child: const Text('Başvuruyu Gönder'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitApplication() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Walker başvurunuz alındı! Ekibimiz 24 saat içinde iletişime geçecektir.'),
        backgroundColor: AppColors.secondary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
