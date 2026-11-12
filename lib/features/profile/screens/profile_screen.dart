import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/models/pet_profile_model.dart';
import '../../../core/models/profile_menu_item_model.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../screens/sub_screens/addresses_screen.dart';
import '../screens/sub_screens/become_walker_screen.dart';
import '../screens/sub_screens/help_center_screen.dart';
import '../screens/sub_screens/invite_code_screen.dart';
import '../screens/sub_screens/payment_methods_screen.dart';
import '../screens/sub_screens/personal_info_screen.dart';
import '../widgets/add_pet_bottom_sheet.dart';
import '../widgets/profile_header_section.dart';
import '../widgets/profile_menu_list.dart';
import '../widgets/profile_pet_list_section.dart';
import '../widgets/settings_bottom_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is! ProfileLoaded) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                ProfileHeaderSection(
                  selectedPetType: state.selectedPetTab,
                  onPetTypeChanged: (type) {
                    context.read<ProfileBloc>().add(SwitchPetTab(type));
                  },
                  onAddPetTap: () {
                    _openAddPetModal(context, state.selectedPetTab);
                  },
                  onSettingsTap: () {
                    SettingsBottomSheet.show(context);
                  },
                ),
                const SizedBox(height: 16),
                ProfilePetListSection(
                  pets: state.filteredPets,
                  selectedType: state.selectedPetTab,
                  onAddPet: () {
                    _openAddPetModal(context, state.selectedPetTab);
                  },
                  onDeletePet: (petId) {
                    context.read<ProfileBloc>().add(DeletePetProfile(petId));
                  },
                ),
                ProfileMenuList(
                  items: _buildNavMenuItems(context, state),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<ProfileMenuItemModel> _buildNavMenuItems(BuildContext context, ProfileLoaded state) {
    return state.menuItems.map((item) {
      return item.copyWith(
        onTap: () {
          Widget targetScreen;
          switch (item.id) {
            case 'personal_info':
              targetScreen = const PersonalInfoScreen();
              break;
            case 'wepet_code':
              targetScreen = const InviteCodeScreen();
              break;
            case 'addresses':
              targetScreen = const AddressesScreen();
              break;
            case 'payment_method':
              targetScreen = const PaymentMethodsScreen();
              break;
            case 'help':
              targetScreen = const HelpCenterScreen();
              break;
            case 'become_walker':
              targetScreen = const BecomeWalkerScreen();
              break;
            default:
              targetScreen = const PersonalInfoScreen();
          }
          Navigator.push(context, MaterialPageRoute(builder: (_) => targetScreen));
        },
      );
    }).toList();
  }

  void _openAddPetModal(BuildContext context, PetType type) {
    AddPetBottomSheet.show(
      context,
      initialType: type,
      onPetSaved: (newPet) {
        context.read<ProfileBloc>().add(AddPetProfile(newPet));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${newPet.name} profiline başarıyla eklendi!'),
            backgroundColor: AppColors.secondary,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }
}
