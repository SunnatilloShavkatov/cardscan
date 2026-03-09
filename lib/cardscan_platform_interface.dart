import 'package:cardscan/cardscan_method_channel.dart';
import 'package:cardscan/src/card_scan_models.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class CardscanPlatform extends PlatformInterface {
  CardscanPlatform() : super(token: _token);

  static final Object _token = Object();

  static CardscanPlatform _instance = MethodChannelCardscan();

  static CardscanPlatform get instance => _instance;

  static set instance(CardscanPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isSupported() {
    throw UnimplementedError('isSupported() has not been implemented.');
  }

  Future<CardScanResult?> scanCard(CardScanOptions options) {
    throw UnimplementedError('scanCard() has not been implemented.');
  }
}
