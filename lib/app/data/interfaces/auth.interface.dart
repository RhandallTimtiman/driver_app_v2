abstract class IAuth {
  /// Sign In Functionality
  Future signIn({required String username, required String pin});
  Future<bool> refreshExpiredToken();
}
