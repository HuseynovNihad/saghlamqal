abstract class ScanEvent {}

class ProductFetchRequested extends ScanEvent {
  final String barcode;
  ProductFetchRequested(this.barcode);
}

class ScanReset extends ScanEvent {}
