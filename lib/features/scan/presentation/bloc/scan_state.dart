import '../../domain/entities/product_entity.dart';

abstract class ScanState {}

class ScanInitial extends ScanState {}

class ScanLoading extends ScanState {}

class ScanSuccess extends ScanState {
  final ProductEntity product;
  ScanSuccess(this.product);
}

class ScanNotFound extends ScanState {}

class ScanError extends ScanState {
  final String message;
  ScanError(this.message);
}