class AuthMockData {
  static final List<Map<String, String>> registeredUsers = [
    {
      'name': 'Fatma Hassan',
      'email': 'fatma@gmail.com',
      'phone': '01123456789',
      'password': 'password123',
    },
    {
      'name': 'John Zakaria',
      'email': 'john@example.com',
      'phone': '01012345678',
      'password': 'securepass',
    },
  ];

  static bool loginCheck({required String email, required String password}) {
    for (var user in registeredUsers) {
      if (user['email'] == email.trim() && user['password'] == password) {
        return true; 
      }
    }
    return false; 
  }

  static void registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    registeredUsers.add({
      'name': name.trim(),
      'email': email.trim(),
      'phone': phone.trim(),
      'password': password,
    });
  }
}