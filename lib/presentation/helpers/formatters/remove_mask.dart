String removeBrazilianCurrencyMask(String currencyString) {
  return currencyString.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", ".");
}

String removePhoneNumberMask(String phoneNumberString) {
  return phoneNumberString
      .replaceAll('(', '')
      .replaceAll(')', '')
      .replaceAll(' ', '')
      .replaceAll('-', '');
}
