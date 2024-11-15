/// Checks if string consists only of alphabets (No whitespace)
bool isText(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern = r'^[a-zA-Z]+$';
    final regExp = RegExp(pattern);
    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

/// Password should have:
/// - at least one uppercase letter
/// - at least one lowercase letter
/// - at least one digit
/// - at least one special character [@#$%^&+=]
/// - a length of at least 8 characters
/// - no whitespace allowed
bool isValidPassword(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern =
        r'^(?=.*?[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_])(?!.*\s).{8,}$';
    final regExp = RegExp(pattern);
    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

/// Checks if string is a valid email
bool isValidEmail(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(pattern);
    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}
