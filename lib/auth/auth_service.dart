import 'package:my_passwords/auth/auth_provider.dart';
import 'package:my_passwords/auth/firebase_auth_provider.dart';
import 'package:my_passwords/auth/auth_user.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser> createuser({
    required String email,
    required String password,
  }) => provider.createuser(email: email, password: password);

  @override
  AuthUser? get currentuser => provider.currentuser;

  @override
  Future<void> initilaizeup() => provider.initilaizeup();
  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> sendEmailVerivication() => provider.sendEmailVerivication();

  @override
  Future<void> sendResetpassword({required String toEmail}) =>
      provider.sendResetpassword(toEmail: toEmail);

  @override
  Future<AuthUser> signin({required String email, required String password}) =>
      provider.signin(email: email, password: password);
}
