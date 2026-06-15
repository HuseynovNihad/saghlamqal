import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_manager.dart';
import '../models/photo_product_model.dart';
import '../models/photo_scan_history_model.dart';

abstract class PhotoScanRemoteDataSource {
  Future<PhotoProductModel> analyzeImage(String imagePath);
  Future<List<PhotoScanHistoryModel>> getScanHistory();
  Future<void> deleteScanHistory(String id);
  Future<void> clearScanHistory();
}

class PhotoScanRemoteDataSourceImpl implements PhotoScanRemoteDataSource {
  final NetworkManager _networkManager;

  PhotoScanRemoteDataSourceImpl(this._networkManager);

  @override
  Future<PhotoProductModel> analyzeImage(String imagePath) async {
    final file = File(imagePath);
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    final response = await _networkManager.uploadFile<Map<String, dynamic>>(
      Endpoints.analyzeScan,
      formData,
    );

    return PhotoProductModel.fromJson(response.data!);
  }

  @override
  Future<List<PhotoScanHistoryModel>> getScanHistory() async {
    final response = await _networkManager.get<List<dynamic>>(
      Endpoints.getScanHistory,
    );

    return (response.data as List)
        .map((e) => PhotoScanHistoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> deleteScanHistory(String id) async {
    await _networkManager.delete<void>(Endpoints.deleteScanHistory(id));
  }

  @override
  Future<void> clearScanHistory() async {
    await _networkManager.delete<void>(Endpoints.clearScanHistory);
  }
}
