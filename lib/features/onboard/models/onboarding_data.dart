import '../../../core/constants/app_assets.dart';

class OnboardingData {
  final String image;
  final String title;
  final String titleHighlight;
  final String titleEmoji;
  final String subtitle;
  final String buttonLabel;

  const OnboardingData({
    required this.image,
    required this.title,
    required this.titleHighlight,
    required this.titleEmoji,
    required this.subtitle,
    required this.buttonLabel,
  });
}

final List<OnboardingData> onboardingPages = [
  OnboardingData(
    image: AppAssets.onboard1AppScreen,
    title: 'Sağlamlığına doğru',
    titleHighlight: 'ilk addım',
    titleEmoji: '👋',
    subtitle:
        'SağlamQal ilə hər gün nə yediyini bil, izlə və daha yaxşı seç. Kameranı tut, qalanını biz edək.',
    buttonLabel: 'Başla',
  ),
  OnboardingData(
    image: AppAssets.onboard2,
    title: 'Şəkil çək',
    titleHighlight: 'hər şeyi öyrən',
    titleEmoji: '🔍',
    subtitle:
        'Şəkil çək — AI saniyələr içində kalorini və qida dəyərini göstərsin.',
    buttonLabel: 'Davam et',
  ),
  OnboardingData(
    image: AppAssets.onboard3,
    title: 'Susuz qalma',
    titleHighlight: 'xatırladaq',
    titleEmoji: '💧',
    subtitle:
        'Gün ərzində su içməni izlə. Vaxtı gələndə SağlamQal sənə xatırladacaq.',
    buttonLabel: 'Davam et',
  ),
  OnboardingData(
    image: AppAssets.onboard4,
    title: 'Sevdiklərini saxla',
    titleHighlight: 'keçmişinə bax',
    titleEmoji: '⭐',
    subtitle:
        'Bəyəndiklərini favoritlərə əlavə et. Bütün scan tarixçən bir yerdə.',
    buttonLabel: 'Davam et',
  ),
  OnboardingData(
    image: AppAssets.onboard5,
    title: 'Bu gün',
    titleHighlight: 'nə bişirək?',
    titleEmoji: '🥗',
    subtitle:
        'Hər gün yeni, sağlam reseptlər. Maddələrdən addım-addım izahatına qədər.',
    buttonLabel: 'Başlayaq',
  ),
];
