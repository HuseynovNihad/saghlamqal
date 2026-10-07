import '../../../core/constants/app_assets.dart';
import '../../../core/l10n/app_localizations.dart';

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

List<OnboardingData> getOnboardingPages(AppLocalizations l10n) {
  return [
    OnboardingData(
      image: AppAssets.onboard1AppScreen,
      title: l10n.onboardingFirstTitle,
      titleHighlight: l10n.onboardingFirstHighlight,
      titleEmoji: '👋',
      subtitle: l10n.onboardingFirstSubtitle,
      buttonLabel: l10n.onboardingStart,
    ),
    OnboardingData(
      image: AppAssets.onboard2,
      title: l10n.onboardingSecondTitle,
      titleHighlight: l10n.onboardingSecondHighlight,
      titleEmoji: '🔍',
      subtitle: l10n.onboardingSecondSubtitle,
      buttonLabel: l10n.onboardingContinue,
    ),
    OnboardingData(
      image: AppAssets.onboard3,
      title: l10n.onboardingThirdTitle,
      titleHighlight: l10n.onboardingThirdHighlight,
      titleEmoji: '💧',
      subtitle: l10n.onboardingThirdSubtitle,
      buttonLabel: l10n.onboardingContinue,
    ),
    OnboardingData(
      image: AppAssets.onboard4,
      title: l10n.onboardingFourthTitle,
      titleHighlight: l10n.onboardingFourthHighlight,
      titleEmoji: '⭐',
      subtitle: l10n.onboardingFourthSubtitle,
      buttonLabel: l10n.onboardingContinue,
    ),
    OnboardingData(
      image: AppAssets.onboard5,
      title: l10n.onboardingFifthTitle,
      titleHighlight: l10n.onboardingFifthHighlight,
      titleEmoji: '🥗',
      subtitle: l10n.onboardingFifthSubtitle,
      buttonLabel: l10n.onboardingLetsStart,
    ),
  ];
}
