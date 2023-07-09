extension ValidationExt on String {
  String? get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    String? result;
    if (isEmpty) {
      result = 'هذا الحقل مطلوب';
    } else if (!(emailRegExp.hasMatch(this))) {
      result = 'ادخل ايميل صالح';
    }
    return result;
  }

  String? get isNotEmptyField {
    String? result;
    if (isEmpty) {
      result = 'هذا الحقل مطلوب';
    }
    return result;
  }

  String? get isValidPassword {
    String? result;

    final passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (isEmpty) {
      result = 'هذا الحقل مطلوب';
    } else if (!(passwordRegExp.hasMatch(this))) {
      result = 'ادخل كلمة مرور قوية';
    }
    return result;
  }

  String? get isValidPhone {
    String? result;
    final phoneRegExp = RegExp(r"^\+?[0-9]{8}$");
    if (isEmpty) {
      result = 'هذا الحقل مطلوب';
    } else if (!(phoneRegExp.hasMatch(this))) {
      result = 'enter valid phone number';
    }
    return result;
  }

  String? get isValidName {
    String? result;
    if (isEmpty) {
      result = 'هذا الحقل مطلوب';
    } else if (!this.contains(' ')) {
      result = 'ادخل الاسم الاول و العائلة';
    }
    return result;
  }

  String? get isValidOtp {
    String? result;
    if (isEmpty) {
      result = 'هذا الحقل مطلوب';
    } else if (this.length < 4) {
      result = 'ادخل الكود كامل';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(this)) {
      result = 'مسموح ادخال ارقام فقط';
    }
    return result;
  }
}
