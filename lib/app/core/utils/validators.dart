class Validators {
  static bool pinLengthValidator(String pin) {
    return (pin.length > 6 || pin.length < 6);
  }

  static bool newPinConfirmPinValidator(String newPin, String confirmPin) {
    return (newPin != confirmPin);
  }
}
