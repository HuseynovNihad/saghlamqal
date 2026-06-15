part of 'photo_scan_bloc.dart';

sealed class PhotoScanState extends Equatable {
  const PhotoScanState();

  @override
  List<Object?> get props => [];
}

final class PhotoScanInitial extends PhotoScanState {
  const PhotoScanInitial();
}

final class PhotoScanLoading extends PhotoScanState {
  const PhotoScanLoading();
}

final class PhotoScanSuccess extends PhotoScanState {
  final PhotoProductEntity product;

  const PhotoScanSuccess(this.product);

  @override
  List<Object?> get props => [product];
}

final class PhotoScanError extends PhotoScanState {
  final String message;

  const PhotoScanError(this.message);

  @override
  List<Object?> get props => [message];
}

final class PhotoScanNotFood extends PhotoScanState {
  const PhotoScanNotFood();
}

final class PhotoScanHistoryLoaded extends PhotoScanState {
  final List<PhotoScanHistoryEntity> history;

  const PhotoScanHistoryLoaded(this.history);

  @override
  List<Object?> get props => [history];
}

final class PhotoScanHistoryActionSuccess extends PhotoScanState {
  const PhotoScanHistoryActionSuccess();
}
