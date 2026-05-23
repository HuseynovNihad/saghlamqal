import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../bloc/photo_scan_bloc.dart';
import '../widgets/photo_app_bar.dart';
import '../widgets/photo_capture_button.dart';
import '../widgets/photo_frame.dart';
import '../widgets/photo_result_sheet.dart';

class PhotoScanPage extends StatefulWidget {
  const PhotoScanPage({super.key});

  @override
  State<PhotoScanPage> createState() => _PhotoScanPageState();
}

class _PhotoScanPageState extends State<PhotoScanPage> {
  CameraController? _cameraController;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    _cameraController = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    if (mounted) setState(() => _isReady = true);
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _onCapture(BuildContext context) async {
    if (_cameraController == null || !_isReady) return;

    final file = await _cameraController!.takePicture();
    if (!context.mounted) return;

    context.read<PhotoScanBloc>().add(PhotoAnalyzeRequested(file.path));
    _showResultSheet(context);
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
        value: context.read<PhotoScanBloc>(),
        child: PhotoResultSheet(
          onScanAgain: () {
            Navigator.pop(context);
            context.read<PhotoScanBloc>().add(const PhotoScanReset());
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PhotoScanBloc>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: BlocBuilder<PhotoScanBloc, PhotoScanState>(
              builder: (context, state) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    if (_isReady && _cameraController != null)
                      SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: _cameraController!.value.previewSize!.height,
                            height: _cameraController!.value.previewSize!.width,
                            child: CameraPreview(_cameraController!),
                          ),
                        ),
                      )
                    else
                      const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    Positioned(
                      left: 0,
                      right: 0,
                      child: PhotoAppBar(controller: _cameraController),
                    ),
                    Center(
                      child: PhotoFrame(isCapturing: state is PhotoScanLoading),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).padding.bottom + 16,
                      left: 0,
                      right: 0,
                      child: PhotoCaptureButton(
                        isLoading: state is PhotoScanLoading,
                        onTap: () => _onCapture(context),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
