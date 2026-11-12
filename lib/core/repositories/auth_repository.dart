// Firebase Authentication paketini içe aktarır
import 'package:firebase_auth/firebase_auth.dart';

/// Firebase Authentication servislerini izole eden ve temiz bir arayüz sunan Veri Deposu (Repository).
class AuthRepository {
  final FirebaseAuth _auth; // Firebase Auth istemci örneği

  // Testlerde Mock nesnesi verilebilmesi için opsiyonel FirebaseAuth alır.
  AuthRepository({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  /// E-posta ve şifre ikilisiyle mevcut kullanıcının oturum açmasını sağlar.
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  /// Yeni bir kullanıcı hesabı oluşturur (Kayıt ol).
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  /// Açık olan kullanıcı oturumunu kapatır.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Şu an oturumu açık olan mevcut Firebase kullanıcısını döndürür (Giriş yapılmamışsa null).
  User? get currentUser => _auth.currentUser;

  /// Kullanıcının oturum açma/kapatma durumunu gerçek zamanlı dinleyen akış (Stream).
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
