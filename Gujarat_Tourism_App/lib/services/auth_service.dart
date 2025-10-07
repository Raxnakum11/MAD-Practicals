import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'database_helper.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  static const String _userIdKey = 'user_id';
  static const String _isLoggedInKey = 'is_logged_in';

  Future<bool> register(User user) async {
    try {
      // Check if user already exists
      final existingUser = await _databaseHelper.getUserByEmail(user.email);
      if (existingUser != null) {
        return false; // User already exists
      }

      // Insert new user
      final userId = await _databaseHelper.insertUser(user);
      if (userId > 0) {
        await _saveUserSession(userId);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final user = await _databaseHelper.getUserByEmail(email);
      if (user != null && user.password == password) {
        await _saveUserSession(user.id!);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt(_userIdKey);

    // Check if using dummy session
    if (userId == 999) {
      // Return dummy user
      return User(
        id: 999,
        fullName: prefs.getString('dummy_name') ?? 'Test User',
        email: prefs.getString('dummy_email') ?? 'test@example.com',
        password: 'dummy',
        phoneNumber: '+91 9999999999',
        createdAt: DateTime.now(),
      );
    }

    if (userId != null) {
      return await _databaseHelper.getUserById(userId);
    }
    return null;
  }

  Future<int?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  Future<void> _saveUserSession(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, userId);
    await prefs.setBool(_isLoggedInKey, true);
  }

  // Dummy authentication for testing - bypasses database
  Future<void> createDummySession(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, 999); // Dummy user ID
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString('dummy_email', email);
    await prefs.setString('dummy_name', 'Test User');
  }
}
