import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../widgets/scan_app_bar.dart';
import '../widgets/scan_frame.dart';
import '../widgets/scan_result_sheet.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isDetected = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isDetected) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue == null) return;

    setState(() => _isDetected = true);
    _controller.stop();

    _showResultSheet(barcode!.rawValue!);
  }

  void _showResultSheet(String barcode) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => ScanResultSheet(
        barcode: barcode,
        onScanAgain: () {
          Navigator.pop(context);
          setState(() => _isDetected = false);
          _controller.start();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(controller: _controller, onDetect: _onDetect),
          ScanAppBar(controller: _controller),
          Center(child: ScanFrame(isDetected: _isDetected)),
        ],
      ),
    );
  }
}
