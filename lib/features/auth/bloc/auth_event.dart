abstract class AuthEvent {
  const AuthEvent();
}

class ToggleAuthMode extends AuthEvent {
  const ToggleAuthMode();
}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted({
    required this.email,
    required this.password,
  });
}

class RegisterSubmitted extends AuthEvent {
  final String fullName;
  final String email;
  final String phone;
  final String password;

  const RegisterSubmitted({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  });
}

class QuickDemoLoginSubmitted extends AuthEvent {
  const QuickDemoLoginSubmitted();
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class DeleteAccountRequested extends AuthEvent {
  const DeleteAccountRequested();
}

