import 'package:shs_cardscan/shs_cardscan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: ScanDemoPage());
}

class ScanDemoPage extends StatefulWidget {
  const ScanDemoPage({super.key});

  @override
  State<ScanDemoPage> createState() => _ScanDemoPageState();
}

class _ScanDemoPageState extends State<ScanDemoPage> {
  final Cardscan _plugin = const Cardscan();

  bool _isSupported = false;
  bool _enableNameExtraction = false;
  bool _enableExpiryExtraction = true;
  bool _enableEnterManually = true;
  bool _isLoading = true;
  String? _error;
  CardScanResult? _result;

  @override
  void initState() {
    super.initState();
    _loadSupport().ignore();
  }

  Future<void> _loadSupport() async {
    try {
      final supported = await _plugin.isSupported();
      if (!mounted) {
        return;
      }
      setState(() {
        _isSupported = supported;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _error = '$error';
        _isLoading = false;
      });
    }
  }

  Future<void> _scanCard() async {
    setState(() {
      _error = null;
    });

    try {
      final result = await _plugin.scanCard(
        CardScanOptions(
          enableEnterManually: _enableEnterManually,
          enableNameExtraction: _enableNameExtraction,
          enableExpiryExtraction: _enableExpiryExtraction,
        ),
      );

      if (!mounted) {
        return;
      }
      setState(() {
        _result = result;
      });
    } on PlatformException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _error = '${error.code}: ${error.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('CardScan Demo')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          _isLoading
              ? 'Checking support...'
              : _isSupported
              ? 'Scanning is supported on this device.'
              : 'Scanning is not supported on this device.',
        ),
        const SizedBox(height: 12),
        SwitchListTile(
          value: _enableExpiryExtraction,
          onChanged: (value) => setState(() => _enableExpiryExtraction = value),
          title: const Text('Enable expiry extraction'),
        ),
        SwitchListTile(
          value: _enableNameExtraction,
          onChanged: (value) => setState(() => _enableNameExtraction = value),
          title: const Text('Enable name extraction'),
        ),
        SwitchListTile(
          value: _enableEnterManually,
          onChanged: (value) => setState(() => _enableEnterManually = value),
          title: const Text('Allow skip/manual entry'),
        ),
        const SizedBox(height: 12),
        FilledButton(onPressed: _isLoading || !_isSupported ? null : _scanCard, child: const Text('Scan card')),
        if (_error != null) ...[const SizedBox(height: 16), Text(_error!, style: const TextStyle(color: Colors.red))],
        if (_result != null) ...[
          const SizedBox(height: 16),
          SelectableText(
            'number: ${_result?.cardNumber}\n'
            'expiryMonth: ${_result?.expiryMonth}\n'
            'expiryYear: ${_result?.expiryYear}\n'
            'cardholderName: ${_result?.cardholderName}\n'
            'networkName: ${_result?.networkName}',
          ),
        ],
      ],
    ),
  );
}
