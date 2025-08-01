import 'package:my_passwords/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentuser;

  Future<AuthUser> createuser({
    required String email,
    required String password,
  });

  Future<AuthUser> signin({required String email, required String password});

  Future<void> logout();
  Future<void> initilaizeup();
  Future<void> sendEmailVerivication();
  Future<void> sendResetpassword({required String toEmail});
}
