import '../../features/home/data/datasource/home_remote_datasource.dart';
import '../../features/home/data/models/daily_goal_model.dart';
import '../../features/home/data/models/hydration_model.dart';
import '../../features/home/data/models/ingredient_model.dart';
import '../../features/home/data/models/meal_of_the_day_model.dart';
import '../../features/home/data/models/recent_product_model.dart';
import 'mock_delay.dart';

class MockHomeRemoteDataSource implements HomeRemoteDataSource {
  @override
  Future<DailyGoalModel> getDailyGoal() async {
    await MockDelay.wait();
    return DailyGoalModel(
      id: 'mock-daily-goal-id',
      bmr: 2032,
      tdee: 3150,
      maintainCalories: 3150,
      loseCalories: 2650,
      gainCalories: 3650,
      dailyProtein: 180,
      dailyCarbs: 412,
      dailyFat: 87,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<HydrationModel> getHydration() async {
    await MockDelay.wait();
    return const HydrationModel(
      dailyGoal: 2.5,
      consumed: 1.2,
      remaining: 1.3,
      percentage: 48,
    );
  }

  @override
  Future<HydrationModel> addWater(double amount) async {
    await MockDelay.wait();
    const consumed = 1.2 + 0.25;
    const dailyGoal = 2.5;
    return const HydrationModel(
      dailyGoal: dailyGoal,
      consumed: consumed,
      remaining: dailyGoal - consumed,
      percentage: (consumed / dailyGoal * 100),
    );
  }

  @override
  Future<List<RecentProductModel>> getRecentProducts() async {
    await MockDelay.wait();
    return [
      RecentProductModel(
        id: 'mock-1',
        icon: '🥛',
        name: 'Activia Yogurt',
        calories: 120,
        protein: 5,
        carbs: 10,
        fat: 2,
        vitamins: const {'B12': 0.4, 'D': 1.2},
        advice: const [
          'Probiotiklərlə zəngindir, həzm sisteminə faydalıdır.',
          'Gündəlik pəhrizə asanlıqla daxil edilə bilər.',
        ],
        isFood: true,
        servingSize: 150,
        servingUnit: 'g',
        createdAt: DateTime.now()
            .subtract(const Duration(hours: 2))
            .toIso8601String(),
      ),
      RecentProductModel(
        id: 'mock-2',
        icon: '🍫',
        name: 'Protein Bar',
        calories: 210,
        protein: 20,
        carbs: 15,
        fat: 7,
        vitamins: const {'B6': 0.3},
        advice: const [
          'İdmandan sonra əzələ bərpası üçün əlverişlidir.',
          'Yüksək protein tərkibi tox saxlamağa kömək edir.',
        ],
        isFood: true,
        servingSize: 60,
        servingUnit: 'g',
        createdAt: DateTime.now()
            .subtract(const Duration(hours: 5))
            .toIso8601String(),
      ),
      RecentProductModel(
        id: 'mock-3',
        icon: '🧃',
        name: 'Narıncı Şirə',
        calories: 85,
        protein: 1,
        carbs: 20,
        fat: 0,
        vitamins: const {'C': 50.0},
        advice: const [
          'C vitamini ilə zəngindir, immuniteti gücləndirir.',
          'Şəkər miqdarına görə həddindən artıq istifadə edilməməlidir.',
        ],
        isFood: true,
        servingSize: 250,
        servingUnit: 'ml',
        createdAt: DateTime.now()
            .subtract(const Duration(days: 1))
            .toIso8601String(),
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
