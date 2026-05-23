import 'dart:convert';
import 'dart:io';

import '../../../../core/network/gemini_manager.dart';
import '../models/photo_product_model.dart';

abstract class PhotoScanRemoteDataSource {
  Future<PhotoProductModel> analyzeImage(String imagePath);
}

class PhotoScanRemoteDataSourceImpl implements PhotoScanRemoteDataSource {
  final GeminiManager _geminiManager;

  PhotoScanRemoteDataSourceImpl(this._geminiManager);

  static const _prompt = '''
Sən yalnız qida və içəcək analiz edən bir AI köməkçisisən.

QAYDA: Əgər şəkildə aydın şəkildə yeyəcək və ya içəcək yoxdursa — heç bir izah vermədən yalnız bu JSON-u qaytar:
{
  "name": null,
  "calories": null,
  "protein": null,
  "carbs": null,
  "fat": null,
  "advice": null,
  "is_food": false
}

Əgər şəkildə yeyəcək və ya içəcək varsa — aşağıdakı JSON-u qaytar:
{
  "name": "məhsulun dəqiq adı",
  "calories": 250,
  "protein": 5.2,
  "carbs": 30.1,
  "fat": 8.4,
  "advice": "bu məhsul haqqında 2-3 cümlə sağlamlıq məsləhəti Azərbaycan dilində",
  "is_food": true
}

ƏLAVƏ QAYDALAR:
- Yalnız JSON qaytar, başqa heç nə yazma
- Markdown işarəsi (```), izah və ya əlavə mətn yazma
- Kalori və makro dəyərlər 100 qram üçün olsun
- Şəkil bulanıq və ya qida olub-olmadığı bəlli deyilsə is_food: false qaytar
''';

  @override
  Future<PhotoProductModel> analyzeImage(String imagePath) async {
    final bytes = await File(imagePath).readAsBytes();
    final base64Image = base64Encode(bytes);

    final response = await _geminiManager.post<Map<String, dynamic>>(
      'models/gemini-2.5-flash:generateContent',
      data: {
        'contents': [
          {
            'parts': [
              {
                'inline_data': {'mime_type': 'image/jpeg', 'data': base64Image},
              },
              {'text': _prompt},
            ],
          },
        ],
      },
    );

    final text =
        response.data!['candidates'][0]['content']['parts'][0]['text']
            as String;

    final jsonStr = text.replaceAll(RegExp(r'```json|```'), '').trim();
    final parsed = jsonDecode(jsonStr) as Map<String, dynamic>;

    return PhotoProductModel.fromJson(parsed);
  }
}
