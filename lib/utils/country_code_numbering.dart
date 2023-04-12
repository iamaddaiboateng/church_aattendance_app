String numberWithCountryCode(String number) {
  if (number.startsWith('+233')) {
    return number;
  } else if (number.startsWith('0')) {
    String newNumber = number.substring(1);
    return "+233$newNumber";
  } else if (!number.startsWith('0') &&
      !number.startsWith('+233') &&
      number.length < 11) {
    return "+233$number";
  } else {
    return number;
  }
}
