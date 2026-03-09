import 'package:shs_cardscan/cardscan_platform_interface.dart';
import 'package:shs_cardscan/src/card_scan_models.dart';

final class Cardscan {
  const Cardscan();

  Future<bool> isSupported() => CardscanPlatform.instance.isSupported();

  Future<CardScanResult?> scanCard([CardScanOptions options = const CardScanOptions()]) =>
      CardscanPlatform.instance.scanCard(options);
}
