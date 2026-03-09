final class CardScanOptions {
  const CardScanOptions({
    this.enableEnterManually = true,
    this.enableNameExtraction = false,
    this.enableExpiryExtraction = true,
  });

  final bool enableEnterManually;
  final bool enableNameExtraction;
  final bool enableExpiryExtraction;

  Map<String, Object?> toMap() => {
    'enableEnterManually': enableEnterManually,
    'enableNameExtraction': enableNameExtraction,
    'enableExpiryExtraction': enableExpiryExtraction,
  };
}

final class CardScanResult {
  const CardScanResult({
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cardholderName,
    required this.networkName,
  });

  factory CardScanResult.fromMap(Map<String, Object?> map) => CardScanResult(
    cardNumber: map['cardNumber'] as String?,
    expiryMonth: map['expiryMonth'] as String?,
    expiryYear: map['expiryYear'] as String?,
    cardholderName: map['cardholderName'] as String?,
    networkName: map['networkName'] as String?,
  );

  final String? cardNumber;
  final String? expiryMonth;
  final String? expiryYear;
  final String? cardholderName;
  final String? networkName;

  Map<String, Object?> toMap() => {
    'cardNumber': cardNumber,
    'expiryMonth': expiryMonth,
    'expiryYear': expiryYear,
    'cardholderName': cardholderName,
    'networkName': networkName,
  };

  @override
  String toString() =>
      'CardScanResult(cardNumber: $cardNumber, expiryMonth: $expiryMonth, '
      'expiryYear: $expiryYear, cardholderName: $cardholderName, '
      'networkName: $networkName)';
}
