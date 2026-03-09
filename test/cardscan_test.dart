import 'package:cardscan/cardscan.dart';
import 'package:cardscan/cardscan_method_channel.dart';
import 'package:cardscan/cardscan_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCardscanPlatform with MockPlatformInterfaceMixin implements CardscanPlatform {
  @override
  Future<bool> isSupported() => Future.value(true);

  @override
  Future<CardScanResult?> scanCard(CardScanOptions options) => Future.value(
    const CardScanResult(
      cardNumber: '8600123412341234',
      expiryMonth: '08',
      expiryYear: '28',
      cardholderName: null,
      networkName: 'Uzcard',
    ),
  );
}

void main() {
  final initialPlatform = CardscanPlatform.instance;

  test('$MethodChannelCardscan is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCardscan>());
  });

  test('Cardscan delegates scanCard', () async {
    CardscanPlatform.instance = MockCardscanPlatform();
    const plugin = Cardscan();

    final result = await plugin.scanCard();
    expect(result?.cardNumber, '8600123412341234');
    expect(result?.expiryMonth, '08');
    expect(result?.expiryYear, '28');
  });
}
