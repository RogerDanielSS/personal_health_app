String formatBrazilianCurrency(double amount) {
  // Convert the amount to fixed-point notation with 2 decimal digits
  String formattedAmount = amount.toStringAsFixed(2);

  // Split the amount into integer and decimal parts
  List<String> parts = formattedAmount.split('.');

  // Format the integer part with commas for thousands separation
  String integerPart = parts[0];
  String formattedIntegerPart = '';
  for (int i = integerPart.length - 1, j = 0; i >= 0; i--, j++) {
    if (j != 0 && j % 3 == 0) {
      formattedIntegerPart = '.$formattedIntegerPart';
    }
    formattedIntegerPart = integerPart[i] + formattedIntegerPart;
  }

  // Construct the final formatted currency string
  String result = 'R\$ $formattedIntegerPart,${parts[1]}';

  return result;
}
