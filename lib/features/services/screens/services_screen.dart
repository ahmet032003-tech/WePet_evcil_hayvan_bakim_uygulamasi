import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../profile/widgets/add_pet_bottom_sheet.dart';
import '../bloc/services_cubit.dart';
import '../widgets/create_pet_bottom_button.dart';
import '../widgets/services_empty_state_card.dart';

class ServicesScreen extends StatelessWidget {
  final ValueChanged<int>? onNavigateTab;

  const ServicesScreen({
    super.key,
    this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServicesCubit(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'HİZMETLERİM',
            style: AppTextStyles.appBarTitle,
          ),
        ),
        body: BlocBuilder<ServicesCubit, ServicesState>(
          builder: (context, state) {
            return Column(
              children: [
                const Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: ServicesEmptyStateCard(),
                    ),
                  ),
                ),
                CreatePetBottomButton(
                  onPressed: () {
                    context.read<ServicesCubit>().onCreatePetProfileTap();
                    AddPetBottomSheet.show(
                      context,
                      onPetSaved: (pet) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${pet.name} başarıyla kaydedildi!'),
                            backgroundColor: AppColors.secondary,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        onNavigateTab?.call(4); // Profil sekmesine yönlendir
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
