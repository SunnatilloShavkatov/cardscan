import 'package:cardscan/cardscan_platform_interface.dart';
import 'package:cardscan/src/card_scan_models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class MethodChannelCardscan extends CardscanPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('cardscan');

  @override
  Future<bool> isSupported() async => await methodChannel.invokeMethod<bool>('isSupported') ?? false;

  @override
  Future<CardScanResult?> scanCard(CardScanOptions options) async {
    final result = await methodChannel.invokeMapMethod<String, Object?>('scanCard', options.toMap());
    if (result == null) {
      return null;
    }
    return CardScanResult.fromMap(result);
  }
}
