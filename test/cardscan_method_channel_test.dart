import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shs_cardscan/cardscan_method_channel.dart';
import 'package:shs_cardscan/src/card_scan_models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final platform = MethodChannelCardscan();
  const channel = MethodChannel('cardscan');

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('isSupported', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (methodCall) async {
          expect(methodCall.method, 'isSupported');
          return true;
        });

    expect(await platform.isSupported(), isTrue);
  });

  test('scanCard maps native result', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (methodCall) async {
          expect(methodCall.method, 'scanCard');
          return <String, Object?>{
            'cardNumber': '8600123412341234',
            'expiryMonth': '08',
            'expiryYear': '28',
            'cardholderName': 'TEST USER',
            'networkName': 'Uzcard',
          };
        });

    final result = await platform.scanCard(const CardScanOptions());
    expect(result?.cardNumber, '8600123412341234');
    expect(result?.expiryMonth, '08');
    expect(result?.expiryYear, '28');
    expect(result?.cardholderName, 'TEST USER');
    expect(result?.networkName, 'Uzcard');
  });
}
