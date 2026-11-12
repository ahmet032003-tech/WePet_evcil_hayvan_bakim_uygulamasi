import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/constants/app_colors.dart';
import '../core/widgets/custom_bottom_nav.dart';
import 'home/screens/home_screen.dart';
import 'pet_friends/screens/pet_friends_screen.dart';
import 'profile/screens/profile_screen.dart';
import 'reservations/screens/reservations_screen.dart';
import 'shop/screens/shop_screen.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void selectTab(int index) => emit(index);
}

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          final pages = [
            HomeScreen(
              onNavigateTab: (index) {
                context.read<NavigationCubit>().selectTab(index);
              },
            ),
            const ShopScreen(),
            ReservationsScreen(
              onNavigateTab: (index) {
                context.read<NavigationCubit>().selectTab(index);
              },
            ),
            const PetFriendsScreen(),
            const ProfileScreen(),
          ];

          return Scaffold(
            backgroundColor: AppColors.background,
            body: IndexedStack(
              index: currentIndex,
              children: pages,
            ),
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<NavigationCubit>().selectTab(index);
              },
            ),
          );
        },
      ),
    );
  }
}


