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
  "vitamins": null,
  "advice": null,
  "is_food": false,
  "serving_size": null,
  "serving_unit": null
}

Əgər şəkildə yeyəcək və ya içəcək varsa — aşağıdakı JSON-u qaytar:
{
  "name": "məhsulun dəqiq adı və sortu (məs: Coca-Cola Classic, Fuji Alma, Fanta Portağal)",
  "calories": 250,
  "protein": 5.2,
  "carbs": 30.1,
  "fat": 8.4,
  "vitamins": {
    "A": 12.5,
    "C": 48.0,
    "D": null,
    "E": 1.2,
    "B12": null,
    "K": 3.4
  },
  "advice": "bu məhsul haqqında 2-3 cümlə sağlamlıq məsləhəti Azərbaycan dilində",
  "is_food": true,
  "serving_size": 100,
  "serving_unit": "ml"
}

SERVING_SIZE VƏ SERVING_UNIT QAYDASI:
- serving_unit: bərk qidalar üçün "g", maye içəcəklər üçün "ml"
- Bərk qidalar (alma, çörək, pendir və s.): kalori və makrolar 100g üçün olsun, serving_size: 100
- Maye içəcəklər (kola, şirə, çay və s.): kalori və makrolar 1 porsiya üçün olsun
  * Bankada/şüşədə gəlirsə: həmin qabın həcmi (məs: 330, 500)
  * Stəkanda/açıq qabda gəlirsə: 250
  * serving_size həmin həcmi göstərsin (məs: 330)

AD VƏ SORT QAYDASI:
- İçəcəkləri marka + növ ilə yaz: "Coca-Cola Zero", "Fanta Portağal", "Sprite"
- Meyvələri sort ilə yaz (bilinərsə): "Fuji Alma", "Qızıl Alma", "Amalfi Limon"
- Sortunu ayırd edə bilmirsənsə ümumi adı yaz: "Alma", "Limon"
- Qablaşdırılmış məhsulda etiket varsa məhz oradakı adı oxu

ƏLAVƏ QAYDALAR:
- Yalnız JSON qaytar, başqa heç nə yazma
- Markdown işarəsi (```), izah və ya əlavə mətn yazma
- Vitaminlər: yalnız həmin qidada mövcud olanları qaytar, bilinməyənlər null olsun
- Vitamin dəyərləri milivramla (mg) olsun, A və D vitamini isə mikrogram (mcg)
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
