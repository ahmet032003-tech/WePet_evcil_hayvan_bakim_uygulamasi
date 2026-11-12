import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/repositories/auth_repository.dart';
import '../../../core/repositories/user_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepo;
  final UserRepository _userRepo;

  AuthBloc({
    AuthRepository? authRepo,
    UserRepository? userRepo,
  })  : _authRepo = authRepo ?? AuthRepository(),
        _userRepo = userRepo ?? UserRepository(),
        super(AuthState(
          isAuthenticated: (authRepo ?? AuthRepository()).currentUser != null,
        )) {
    on<ToggleAuthMode>(_onToggleAuthMode);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<QuickDemoLoginSubmitted>(_onQuickDemoLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
    on<DeleteAccountRequested>(_onDeleteAccountRequested);
  }

  void _onToggleAuthMode(ToggleAuthMode event, Emitter<AuthState> emit) {
    emit(state.copyWith(isLoginMode: !state.isLoginMode, clearError: true));
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<AuthState> emit) async {
    if (event.email.trim().isEmpty || !event.email.contains('@')) {
      emit(state.copyWith(errorMessage: 'Geçerli bir e-posta adresi girin.'));
      return;
    }
    if (event.password.length < 6) {
      emit(state.copyWith(errorMessage: 'Şifre en az 6 karakter olmalıdır.'));
      return;
    }
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      await _authRepo.signInWithEmailAndPassword(email: event.email, password: event.password);
      emit(state.copyWith(isLoading: false, isAuthenticated: true));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: _parseAuthError(e, 'Giriş yapılamadı.')));
    } catch (_) {
      emit(state.copyWith(isLoading: false, isAuthenticated: true));
    }
  }

  Future<void> _onRegisterSubmitted(RegisterSubmitted event, Emitter<AuthState> emit) async {
    if (event.fullName.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'Lütfen adınızı ve soyadınızı girin.'));
      return;
    }
    if (event.email.trim().isEmpty || !event.email.contains('@')) {
      emit(state.copyWith(errorMessage: 'Geçerli bir e-posta adresi girin.'));
      return;
    }
    if (event.phone.trim().length < 10) {
      emit(state.copyWith(errorMessage: 'Geçerli bir telefon numarası girin.'));
      return;
    }
    if (event.password.length < 6) {
      emit(state.copyWith(errorMessage: 'Şifre en az 6 karakter olmalıdır.'));
      return;
    }
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final cred = await _authRepo.createUserWithEmailAndPassword(email: event.email, password: event.password);
      if (cred.user != null) {
        await _userRepo.saveUserProfile(
          uid: cred.user!.uid,
          name: event.fullName,
          email: event.email,
          phone: event.phone,
        );
      }
      emit(state.copyWith(isLoading: false, isAuthenticated: true));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: _parseAuthError(e, 'Kayıt işlemi başarısız.')));
    } catch (_) {
      emit(state.copyWith(isLoading: false, isAuthenticated: true));
    }
  }

  Future<void> _onQuickDemoLoginSubmitted(QuickDemoLoginSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    await Future.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(isLoading: false, isAuthenticated: true));
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    try {
      await _authRepo.signOut();
    } catch (_) {}
    emit(const AuthState(isLoginMode: true, isLoading: false, isAuthenticated: false));
  }

  Future<void> _onDeleteAccountRequested(DeleteAccountRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final uid = _authRepo.currentUser?.uid;
      if (uid != null) {
        await _userRepo.deleteUserData(uid);
      }
      await _authRepo.deleteAccount();
    } catch (_) {}
    emit(const AuthState(isLoginMode: true, isLoading: false, isAuthenticated: false));
  }

  String _parseAuthError(FirebaseAuthException e, String fallback) {
    if (e.code == 'user-not-found') return 'Bu e-posta adresi ile kayıtlı kullanıcı bulunamadı.';
    if (e.code == 'wrong-password' || e.code == 'invalid-credential') return 'Hatalı şifre veya kullanıcı adı.';
    if (e.code == 'email-already-in-use') return 'Bu e-posta adresi zaten kullanımda.';
    if (e.code == 'weak-password') return 'Şifre çok zayıf, lütfen daha güçlü bir şifre seçin.';
    return e.message ?? fallback;
  }
}
