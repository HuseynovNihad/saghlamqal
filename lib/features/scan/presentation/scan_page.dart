import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/di/injection_container.dart';
import 'bloc/scan_bloc.dart';
import 'bloc/scan_event.dart';
import 'bloc/scan_state.dart';
import 'widgets/scan_app_bar.dart';
import 'widgets/scan_frame.dart';
import 'widgets/scan_result_sheet.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final MobileScannerController _controller = MobileScannerController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture, BuildContext context) {
    final state = context.read<ScanBloc>().state;
    if (state is ScanLoading || state is ScanSuccess) return;

    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue == null) return;

    _controller.stop();
    context.read<ScanBloc>().add(ProductFetchRequested(barcode!.rawValue!));
  }

  void _showResultSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<ScanBloc>(),
        child: ScanResultSheet(
          onScanAgain: () {
            Navigator.pop(context);
            context.read<ScanBloc>().add(ScanReset());
            _controller.start();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ScanBloc>(),
      child: Builder(
        builder: (context) {
          return BlocListener<ScanBloc, ScanState>(
            listener: (context, state) {
              if (state is ScanSuccess ||
                  state is ScanNotFound ||
                  state is ScanError) {
                _showResultSheet(context);
              }
            },
            child: Scaffold(
              backgroundColor: Colors.black,
              body: BlocBuilder<ScanBloc, ScanState>(
                builder: (context, state) {
                  return Stack(
                    children: [
                      MobileScanner(
                        controller: _controller,
                        onDetect: (capture) => _onDetect(capture, context),
                      ),
                      ScanAppBar(controller: _controller),
                      Center(
                        child: ScanFrame(
                          isDetected:
                              state is ScanLoading || state is ScanSuccess,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
