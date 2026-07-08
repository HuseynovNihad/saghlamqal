import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../favorites/presentation/bloc/favorites_bloc.dart';
import '../bloc/photo_scan_bloc.dart';
import '../widgets/photo_app_bar.dart';
import '../widgets/photo_capture_button.dart';
import '../widgets/photo_frame.dart';
import '../widgets/photo_result_sheet.dart';
import '../widgets/photo_tips_panel.dart';

class PhotoScanPage extends StatefulWidget {
  const PhotoScanPage({super.key});

  @override
  State<PhotoScanPage> createState() => _PhotoScanPageState();
}

class _PhotoScanPageState extends State<PhotoScanPage>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _cameraController;

    if (controller == null || !controller.value.isInitialized) return;

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _disposeCamera();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  Future<void> _disposeCamera() async {
    final controller = _cameraController;
    _cameraController = null;
    if (mounted) {
      setState(() => _isReady = false);
    }
    await controller?.dispose();
  }

  Future<void> _initCamera() async {
    await _disposeCamera();

    final cameras = await availableCameras();
    if (cameras.isEmpty || !mounted) return;

    final controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await controller.initialize();
    } catch (_) {
      await controller.dispose();
      return;
    }

    if (!mounted) {
      await controller.dispose();
      return;
    }

    setState(() {
      _cameraController = controller;
      _isReady = true;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
    final photoScanBloc = context.read<PhotoScanBloc>();
    final authBloc = context.read<AuthBloc>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: photoScanBloc),
          BlocProvider.value(value: authBloc),
          BlocProvider(create: (_) => sl<FavoritesBloc>()),
        ],
        child: PhotoResultSheet(
          onScanAgain: () {
            Navigator.pop(context);
            photoScanBloc.add(const PhotoScanReset());
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final frameSize = MediaQuery.of(context).size.width * 0.78;

    return BlocProvider(
      create: (_) => sl<PhotoScanBloc>(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            _CameraPreviewLayer(
              controller: _cameraController,
              isReady: _isReady,
            ),
            SafeArea(
              child: Column(
                children: [
                  PhotoAppBar(controller: _cameraController),
                  Expanded(
                    child: Center(
                      child: BlocBuilder<PhotoScanBloc, PhotoScanState>(
                        buildWhen: (prev, curr) =>
                            prev.runtimeType != curr.runtimeType,
                        builder: (context, state) {
                          return PhotoFrame(
                            isCapturing: state is PhotoScanLoading,
                          );
                        },
                      ),
                    ),
                  ),
                  PhotoTipsPanel(width: frameSize),
                  20.hs,
                  BlocBuilder<PhotoScanBloc, PhotoScanState>(
                    buildWhen: (prev, curr) =>
                        prev.runtimeType != curr.runtimeType,
                    builder: (context, state) {
                      return PhotoCaptureButton(
                        isLoading: state is PhotoScanLoading,
                        onTap: () => _onCapture(context),
                      );
                    },
                  ),
                  15.hs,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CameraPreviewLayer extends StatelessWidget {
  final CameraController? controller;
  final bool isReady;

  const _CameraPreviewLayer({required this.controller, required this.isReady});

  @override
  Widget build(BuildContext context) {
    if (!isReady || controller == null) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: controller!.value.previewSize!.height,
          height: controller!.value.previewSize!.width,
          child: CameraPreview(controller!),
        ),
      ),
    );
  }
}
