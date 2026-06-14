import '../../features/home/data/datasource/home_remote_datasource.dart';
import '../../features/home/data/models/daily_goal_model.dart';
import '../../features/home/data/models/hydration_model.dart';
import '../../features/home/data/models/ingredient_model.dart';
import '../../features/home/data/models/macro_model.dart';
import '../../features/home/data/models/meal_of_the_day_model.dart';
import '../../features/home/data/models/recent_product_model.dart';
import 'mock_delay.dart';

class MockHomeRemoteDataSource implements HomeRemoteDataSource {
  @override
  Future<DailyGoalModel> getDailyGoal() async {
    await MockDelay.wait();
    return const DailyGoalModel(
      dailyKcal: 2100,
      protein: MacroModel(label: 'Zülal', recommended: 160, unit: 'q'),
      carbs: MacroModel(label: 'Karbohidrat', recommended: 230, unit: 'q'),
      fats: MacroModel(label: 'Yağ', recommended: 70, unit: 'q'),
    );
  }

  @override
  Future<HydrationModel> getHydration() async {
    await MockDelay.wait();
    return const HydrationModel(
      tracked: 1200,
      recommended: 2500,
      addAmount: 250,
    );
  }

  @override
  Future<HydrationModel> addWater(int amount) async {
    await MockDelay.wait();
    return HydrationModel(tracked: 1450, recommended: 2500, addAmount: amount);
  }

  @override
  Future<List<RecentProductModel>> getRecentProducts() async {
    await MockDelay.wait();
    return const [
      RecentProductModel(
        name: 'Activia Yogurt',
        imageUrl:
            'https://images.unsplash.com/photo-1571212515416-fef01fc43637?w=200&q=80',
        calories: 120,
        protein: 5,
        carbs: 10,
        fat: 2,
        vitamins: {'B12': 0.4, 'D': 1.2, 'Kalsium': 150.0},
        advice: 'Probiotiklərlə zəngindir, həzm sisteminə faydalıdır.',
        isFood: true,
      ),
      RecentProductModel(
        name: 'Protein Bar',
        imageUrl:
            'https://images.unsplash.com/photo-1593095948071-474c5cc2989d?w=200&q=80',
        calories: 210,
        protein: 20,
        carbs: 15,
        fat: 7,
        vitamins: {'B6': 0.3, 'Maqnezium': 40.0, 'Dəmir': 2.5},
        advice: 'İdmandan sonra əzələ bərpası üçün əlverişlidir.',
        isFood: true,
      ),
      RecentProductModel(
        name: 'Narıncı Şirə',
        imageUrl:
            'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=200&q=80',
        calories: 85,
        protein: 1,
        carbs: 20,
        fat: 0,
        vitamins: {'C': 50.0, 'Folat': 30.0, 'Kalium': 200.0},
        advice: 'C vitamini ilə zəngindir, lakin şəkər miqdarına diqqət edin.',
        isFood: true,
      ),
    ];
  }

  @override
  Future<MealOfTheDayModel> getMealOfTheDay() async {
    await MockDelay.wait();
    return MealOfTheDayModel(
      id: 1,
      tag: 'QİDA MADDƏLƏRİ İLƏ ZƏNGİN',
      title: 'Avokado və Qızılbalıq Güclü Qabı',
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&q=80',
      kcal: 420,
      timeMinutes: 15,
      description:
          'Günortadan sonra yuxu zamanı enerji səviyyənizi qorumaq üçün Omega-3 və liflə zəngindir.',
      protein: 35,
      carbs: 28,
      fat: 18,
      servings: 2,
      ingredients: const [
        IngredientModel(name: 'Qızılbalıq filesi', amount: '200q'),
        IngredientModel(name: 'Avokado', amount: '1 ədəd'),
        IngredientModel(name: 'Quinoa', amount: '80q'),
        IngredientModel(name: 'Gilas pomidor', amount: '100q'),
        IngredientModel(name: 'Zeytun yağı', amount: '2 xörək qaşığı'),
        IngredientModel(name: 'Limon suyu', amount: '1 xörək qaşığı'),
        IngredientModel(name: 'Duz və istiot', amount: 'dad üzrə'),
      ],
      steps: const [
        'Quinoa-nı 2 qat su ilə bişirin, 15 dəqiqə saxlayın.',
        'Qızılbalıq filesini duz və istiotla ədviyyatlayın.',
        'Tavada zeytun yağında hər tərəfi 3-4 dəqiqə qızardın.',
        'Avokadonu dilimlərə kəsin, limon suyu əlavə edin.',
        'Qabda quinoa, qızılbalıq, avokado və pomidoru düzün.',
        'Üzərinə zeytun yağı süzün və servis edin.',
      ],
    );
  }
}
