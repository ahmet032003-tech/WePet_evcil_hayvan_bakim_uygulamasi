import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../../profile/bloc/profile_event.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_form_card.dart';
import '../widgets/auth_header.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AuthHeader(isLoginMode: state.isLoginMode),
                    const SizedBox(height: 24),
                    AuthFormCard(
                      isLoginMode: state.isLoginMode,
                      isLoading: state.isLoading,
                      errorMessage: state.errorMessage,
                      onToggleMode: () {
                        context.read<AuthBloc>().add(const ToggleAuthMode());
                      },
                      onLogin: (email, pass) {
                        context.read<AuthBloc>().add(LoginSubmitted(email: email, password: pass));
                      },
                      onRegister: (name, email, phone, pass) {
                        context.read<ProfileBloc>().add(UpdateUserInfo(
                              name: name,
                              phone: phone,
                              email: email,
                            ));
                        context.read<AuthBloc>().add(RegisterSubmitted(
                              fullName: name,
                              email: email,
                              phone: phone,
                              password: pass,
                            ));
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildQuickDemoLogin(context),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickDemoLogin(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        context.read<AuthBloc>().add(const QuickDemoLoginSubmitted());
      },
      icon: const Icon(Icons.flash_on_rounded, color: AppColors.primary, size: 18),
      label: const Text(
        'Misafir / Hızlı Demo Girişi',
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }
}

