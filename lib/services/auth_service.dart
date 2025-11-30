class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String? _currentUser;
  String? _currentUserEmail;

  // Usuario de prueba único
  static const Map<String, Map<String, String>> _users = {
    'admin@gmail.com': {
      'password': '123456',
      'role': 'admin',
      'name': 'Usuario Admin',
    },
  };

  // Simular autenticación
  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simular delay de red

    if (_users.containsKey(username) &&
        _users[username]!['password'] == password) {
      _currentUser = _users[username]!['name'];
      _currentUserEmail = username;
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    _currentUserEmail = null;
  }

  bool get isLoggedIn => _currentUser != null;
  String? get currentUser => _currentUser;
  String? get currentUserEmail => _currentUserEmail;

  String get currentUserRole {
    if (_currentUserEmail != null && _users.containsKey(_currentUserEmail)) {
      return _users[_currentUserEmail]!['role']!;
    }
    return 'user';
  }

  bool get isAdmin => currentUserRole == 'admin';

  // Obtener todos los usuarios (solo para admin)
  List<Map<String, String>> getAllUsers() {
    if (!isAdmin) return [];

    return _users.entries.map((entry) {
      return {
        'email': entry.key,
        'name': entry.value['name']!,
        'role': entry.value['role']!,
      };
    }).toList();
  }
}
