class Validators {

  // Full Name
  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your full name';
    }

    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }

    
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name cannot contain numbers or symbols';
    }

    return null;
  }

  
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your phone number';
    }

    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
      return 'Invalid phone number';
    }

    return null;
  }

  // Email
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your email';
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
      return 'Invalid email';
    }

    return null;
  }

  // Password
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    return null;
  }

  // Confirm Password
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }
}
