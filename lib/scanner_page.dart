import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'pola_api.dart';
import 'barcode_detail_page.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final MobileScannerController _cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    formats: const [BarcodeFormat.ean13, BarcodeFormat.ean8],
  );

  bool _isProcessing = false;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final barcode = barcodes.first;
      final code = barcode.rawValue;
      if (code != null) {
        setState(() {
          _isProcessing = true;
        });

        // Block scanning and show loader
        _cameraController.stop();

        try {
          final api = PolaApi();
          final responseData = await api.getByCode(code);

          if (!mounted) return;
          
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BarcodeDetailPage(code: code, data: responseData),
            ),
          );
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Błąd pobierania danych: $e')),
          );
        } finally {
          if (mounted) {
            setState(() {
              _isProcessing = false;
            });
            _cameraController.start();
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skaner kodu EAN')),
      body: Stack(
        children: [
          MobileScanner(
            controller: _cameraController,
            onDetect: _onDetect,
          ),
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
