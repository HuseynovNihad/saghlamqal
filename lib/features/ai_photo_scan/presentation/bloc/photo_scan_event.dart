part of 'photo_scan_bloc.dart';

sealed class PhotoScanEvent extends Equatable {
  const PhotoScanEvent();

  @override
  List<Object> get props => [];
}

final class PhotoAnalyzeRequested extends PhotoScanEvent {
  final String imagePath;

  const PhotoAnalyzeRequested(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

final class PhotoScanReset extends PhotoScanEvent {
  const PhotoScanReset();
}
