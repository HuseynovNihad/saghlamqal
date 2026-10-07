// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class AppLocalizationsAz extends AppLocalizations {
  AppLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get languageTitle => 'Dil seçimi';

  @override
  String get systemLanguage => 'Sistem dili';

  @override
  String get continueButton => 'Davam et';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get languageSaveError => 'Dil seçimi saxlanmadı. Yenidən cəhd edin';

  @override
  String get authGenericError => 'Xəta baş verdi, yenidən cəhd edin';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authEmailHint => 'Emailinizi daxil edin';

  @override
  String get authEmailExample => 'example@email.com';

  @override
  String get authEmailRequired => 'Email daxil edin';

  @override
  String get authEmailInvalid => 'Düzgün email daxil edin';

  @override
  String get authPasswordLabel => 'Şifrə';

  @override
  String get authPasswordHint => 'Şifrənizi daxil edin';

  @override
  String get authPasswordRequired => 'Şifrə daxil edin';

  @override
  String get authPasswordMinLength => 'Şifrə ən az 6 simvol olmalıdır';

  @override
  String get authConfirmPasswordLabel => 'Şifrəni təsdiqlə';

  @override
  String get authConfirmPasswordHint => 'Şifrənizi təkrar daxil edin';

  @override
  String get authConfirmPasswordRequired => 'Şifrəni təsdiqləyin';

  @override
  String get authPasswordsDoNotMatch => 'Şifrələr uyğun deyil';

  @override
  String get authLoginTitle => 'Daxil ol';

  @override
  String get authLoginButton => 'Daxil ol';

  @override
  String get authForgotPasswordLink => 'Şifrənizi unutmusunuz?';

  @override
  String get authOr => 'və ya';

  @override
  String get authContinueWithGoogle => 'Google ilə davam et';

  @override
  String get authNoAccount => 'Hesabın yoxdur?';

  @override
  String get authRegisterLink => 'Qeydiyyat';

  @override
  String get authHaveAccount => 'Hesabın var?';

  @override
  String get authRegisterButton => 'Qeydiyyatdan keç';

  @override
  String get authFirstNameLabel => 'Ad';

  @override
  String get authFirstNameHint => 'Adınızı daxil edin';

  @override
  String get authLastNameLabel => 'Soyad';

  @override
  String get authLastNameHint => 'Soyadınızı daxil edin';

  @override
  String get authGoogleIdTokenMissing =>
      'Google ID token alınmadı. Yenidən cəhd edin.';

  @override
  String get authGoogleLoginFailed =>
      'Google ilə giriş mümkün olmadı. Yenidən cəhd edin.';

  @override
  String get authGoogleLoginError => 'Google ilə giriş zamanı xəta baş verdi.';

  @override
  String get authGoogleCredentialsMissing =>
      'Google giriş məlumatları alınmadı';

  @override
  String get authAccountDeactivatedTitle => 'Hesab deaktivdir';

  @override
  String get authAccountDeactivatedMessage =>
      'Hesabınız deaktiv edilmişdir. Yenidən aktivləşdirmək üçün emailinizə doğrulama kodu göndəriləcək.';

  @override
  String get authReactivateButton => 'Aktivləşdir';

  @override
  String get authPasswordNotSetTitle => 'Şifrə təyin edilməyib';

  @override
  String get authPasswordNotSetMessage =>
      'Bu hesab Google ilə yaradılıb. Email və şifrə ilə daxil olmaq üçün hesabınıza şifrə təyin edin.';

  @override
  String get authSetPasswordButton => 'Şifrə təyin et';

  @override
  String get authForgotPasswordTitle => 'Şifrəni Unutdum';

  @override
  String get authForgotPasswordDescription =>
      'Email ünvanınızı daxil edin, şifrə sıfırlama kodu göndərəcəyik';

  @override
  String get authPasswordResetCodeSent => 'Şifrə sıfırlama kodu göndərildi';

  @override
  String get authSendCodeButton => 'Kodu Göndər';

  @override
  String get authBackButton => 'Geri qayıt';

  @override
  String get authNewPasswordTitle => 'Yeni Şifrə';

  @override
  String get authNewPasswordDescription => 'Yeni şifrənizi daxil edin';

  @override
  String get authNewPasswordLabel => 'Yeni şifrə';

  @override
  String get authPasswordResetSuccess => 'Şifrəniz uğurla yeniləndi';

  @override
  String get authUpdatePasswordButton => 'Şifrəni Yenilə';

  @override
  String get authOtpCodeResent => 'Yeni kod göndərildi';

  @override
  String get authOtpDidNotReceive => 'Kodu almadınız?';

  @override
  String get authOtpResend => 'Yenidən göndər';

  @override
  String authOtpSecondsRemaining(int seconds) {
    return '$seconds san';
  }

  @override
  String get authOtpEmailVerificationTitle => 'Email Təsdiqləmə';

  @override
  String get authOtpPasswordResetTitle => 'Şifrə Sıfırlama';

  @override
  String get authOtpAccountRestoreTitle => 'Hesab Bərpası';

  @override
  String get authOtpEmailVerificationDescription =>
      'Emailinizə göndərilən 6 rəqəmli kodu daxil edin';

  @override
  String get authOtpPasswordResetDescription =>
      'Şifrənizi yeniləmək üçün emailinizə göndərilən 6 rəqəmli kodu daxil edin';

  @override
  String get authOtpAccountRestoreDescription =>
      'Hesabınızı bərpa etmək üçün emailinizə göndərilən 6 rəqəmli kodu daxil edin';

  @override
  String get authPhoneNumberLabel => 'Telefon nömrəsi';

  @override
  String get authRegistrationBack => 'Geri';

  @override
  String authRegistrationStep(int current, int total) {
    return 'Qeydiyyat $current / $total';
  }

  @override
  String get profileBirthdayRequired => 'Doğum tarixini seçin';

  @override
  String get profileGenderRequired => 'Cins seçin';

  @override
  String get profileActivityLevelRequired => 'Aktivlik səviyyəsi seçin';

  @override
  String get profileGoalRequired => 'Məqsəd seçin';

  @override
  String get profileWeightHeightInvalid =>
      'Çəki və boy məlumatlarını düzgün daxil edin';

  @override
  String get profilePersonalInfoTitle => 'Şəxsi məlumatlar';

  @override
  String get profilePersonalInfoDescription =>
      'Sizi daha yaxşı tanımaq üçün əsas məlumatları tamamlayın.';

  @override
  String get profileBodyMetricsTitle => 'Bədən göstəriciləri';

  @override
  String get profileBodyMetricsDescription =>
      'Boy və çəki məlumatlarınız gündəlik ehtiyacların hesablanmasına kömək edir.';

  @override
  String get profileActivityLevelTitle => 'Aktivlik səviyyəsi';

  @override
  String get profileActivityLevelDescription =>
      'Adi gününüzə ən yaxın fiziki aktivlik səviyyəsini seçin.';

  @override
  String get profileGoalTitle => 'Məqsədiniz';

  @override
  String get profileGoalDescription =>
      'SağlamQal planınızı seçdiyiniz məqsədə uyğun fərdiləşdirəcək.';

  @override
  String get profileLastStep => 'Son addım';

  @override
  String get profileCompleteTitle => 'Profilinizi tamamlayaq';

  @override
  String get profileCompleteDescription =>
      'Sizə uyğun kalori və qidalanma planı hazırlamaq üçün bir neçə məlumat lazımdır.';

  @override
  String get profileTargetWeightLabel => 'Hədəf çəki';

  @override
  String get profileOptional => 'İstəyə bağlı';

  @override
  String get profileTargetWeightHint => 'Məsələn: 65';

  @override
  String get profileInvalidWeight => 'Düzgün çəki daxil edin';

  @override
  String get profileWeightRangeError => 'Çəki 20-500 kq aralığında olmalıdır';

  @override
  String get profilePrivacyNote =>
      'Məlumatlarınız yalnız sizə uyğun fərdi plan yaratmaq üçün istifadə olunur.';

  @override
  String get profileCompleteButton => 'Profili tamamla';

  @override
  String get profileBirthdayLabel => 'Doğum tarixi';

  @override
  String get profileBirthdaySelect => 'Doğum tarixini seçin';

  @override
  String profileBirthdayWithAge(String date, int age) {
    return '$date ($age yaş)';
  }

  @override
  String get profileGenderLabel => 'Cins';

  @override
  String get profileGenderMale => 'Kişi';

  @override
  String get profileGenderFemale => 'Qadın';

  @override
  String get profileWeightLabel => 'Çəki';

  @override
  String get profileHeightLabel => 'Boy';

  @override
  String get unitKg => 'kq';

  @override
  String get unitCm => 'sm';

  @override
  String get activitySedentaryLabel => 'Oturaq';

  @override
  String get activitySedentaryDescription =>
      'Demək olar ki, heç bir fiziki aktivlik yoxdur';

  @override
  String get activityLightLabel => 'Az aktiv';

  @override
  String get activityLightDescription => 'Həftədə 1-3 gün yüngül idman';

  @override
  String get activityModerateLabel => 'Orta aktiv';

  @override
  String get activityModerateDescription =>
      'Həftədə 3-5 gün orta səviyyəli idman';

  @override
  String get activityActiveLabel => 'Çox aktiv';

  @override
  String get activityActiveDescription => 'Həftədə 6-7 gün intensiv idman';

  @override
  String get activityVeryActiveLabel => 'Həddindən çox aktiv';

  @override
  String get activityVeryActiveDescription =>
      'Gündə 2 dəfə idman və ya ağır fiziki iş';

  @override
  String get goalLoseWeightLabel => 'Çəki itirmək';

  @override
  String get goalLoseWeightDescription =>
      'Kalori defisiti ilə arıqlamaq istəyirəm';

  @override
  String get goalMaintainWeightLabel => 'Çəkini saxlamaq';

  @override
  String get goalMaintainWeightDescription =>
      'Hazırkı çəkimi qorumaq istəyirəm';

  @override
  String get goalGainWeightLabel => 'Çəki artırmaq';

  @override
  String get goalGainWeightDescription =>
      'Kalori profisiti ilə çəki qazanmaq istəyirəm';

  @override
  String get validationRequired => 'Bu sahə boş qala bilməz';

  @override
  String get validationPhoneRequired => 'Telefon nömrəsi daxil edin';

  @override
  String get validationPhoneDigitsOnly =>
      'Telefon yalnız rəqəmlərdən ibarət olmalıdır';

  @override
  String get validationPhoneInvalid => 'Düzgün telefon nömrəsi daxil edin';

  @override
  String get homeGreetingMorning => 'Sabahınız xeyir';

  @override
  String get homeGreetingAfternoon => 'Günortanız xeyir';

  @override
  String get homeGreetingEvening => 'Axşamınız xeyir';

  @override
  String get homeGuest => 'Qonaq';

  @override
  String get homeTodayStoryReady => 'Bugünkü hekayən başlamağa hazırdır.';

  @override
  String get navHome => 'Ana səhifə';

  @override
  String get navFavorites => 'Favoritlər';

  @override
  String get navProfile => 'Profilim';

  @override
  String get homePhotoScanTitle => 'Şəklini çək,\nkaloriləri öyrən';

  @override
  String get homePhotoScanSubtitle => 'Saniyələr içində kalorilərini öyrən';

  @override
  String get homePhotoScanOpenCamera => 'Kameranı aç';

  @override
  String get homeGuestPreviewTitle => 'Sağlıqlı həyat\nsənin əlindədir.';

  @override
  String get homeGuestFeatureCalories => 'Gündəlik kalori & makro izləmə';

  @override
  String get homeGuestFeatureHydration => 'Su istehlakı monitorinqi';

  @override
  String get homeGuestFeatureHistory => 'Oxuduğun məhsulların tarixi';

  @override
  String get homeDailyRecommendation => 'Gündəlik tövsiyə';

  @override
  String get macroProtein => 'Zülal';

  @override
  String get macroCarbohydrate => 'Karbohidrat';

  @override
  String get macroFat => 'Yağ';

  @override
  String get nutritionEnergyUpper => 'ENERJİ';

  @override
  String get nutritionDurationUpper => 'MÜDDƏT';

  @override
  String get nutritionServingUpper => 'PORSİYA';

  @override
  String get nutritionProteinUpper => 'ZÜLAL';

  @override
  String get nutritionCarbohydrateUpper => 'KARBOHİDRAT';

  @override
  String get nutritionCarbsShortUpper => 'KARBO';

  @override
  String get nutritionFatUpper => 'YAĞ';

  @override
  String get unitKcal => 'kcal';

  @override
  String get unitGram => 'q';

  @override
  String get unitMinuteShort => 'dəq';

  @override
  String get unitPerson => 'nəfər';

  @override
  String get unitLiter => 'L';

  @override
  String get homeHydrationTitle => 'Hidrasiya';

  @override
  String homeHydrationRecommendation(String value) {
    return 'Tövsiyə: $value';
  }

  @override
  String get homeMealOfTheDayUpper => 'GÜNÜN YEMƏYİ';

  @override
  String get homeViewRecipe => 'Reseptə baxın';

  @override
  String get homeIngredients => 'Tərkiblər';

  @override
  String get homePreparationSteps => 'Hazırlama mərhələləri';

  @override
  String get homeRecentProductsTitle => 'Son oxudulanlar';

  @override
  String get homeViewAll => 'Hamısına bax';

  @override
  String homeRecentProductsCount(int count) {
    return '$count məhsul';
  }

  @override
  String get homeNoProductsScanned => 'Hələ heç bir məhsul\noxudulmayıb';

  @override
  String get homeScanProductsHint =>
      'Məhsulları əlavə etmək üçün barkodu scan edin';

  @override
  String get homeScanNow => 'İndi scan et';

  @override
  String get commonProduct => 'Məhsul';

  @override
  String get commonVitamins => 'Vitaminlər';

  @override
  String commonTodayAt(String time) {
    return 'Bugün, $time';
  }

  @override
  String commonYesterdayAt(String time) {
    return 'Dünən, $time';
  }

  @override
  String homeProductAddedFavorite(String product) {
    return '$product favoritlərə əlavə edildi';
  }

  @override
  String homeProductRemovedFavorite(String product) {
    return '$product favoritlərdən silindi';
  }

  @override
  String get homeBarcodeScanTitle => 'Barkod Oxut';

  @override
  String get homeBarcodeScanSubtitle => 'Məhsulun kalorisini dərhal öyrən';

  @override
  String get photoScanTitle => 'Şəkillə axtar';

  @override
  String get photoScanTipGoodLight => 'Yaxşı işıq';

  @override
  String get photoScanTipFitFrame => 'Çərçivəyə sığdırın';

  @override
  String get photoScanTipKeepSteady => 'Sabit saxlayın';

  @override
  String get photoScanAnalyzingTitle => 'Məhsul analiz edilir...';

  @override
  String get photoScanAnalyzingDuration => 'Bu adətən 10-15 saniyə çəkir';

  @override
  String get photoScanAnalyzingExtended =>
      'Bir az da davam edir, xahiş edirik gözləyin...';

  @override
  String get photoScanStepCapturedTitle => 'Şəkil uğurla çəkildi';

  @override
  String get photoScanStepCapturedSubtitle => 'Keyfiyyət yoxlanıldı';

  @override
  String get photoScanStepAnalyzingTitle => 'Məhsul analiz edilir';

  @override
  String get photoScanStepAnalyzingSubtitle => 'AI görüntünü araşdırır';

  @override
  String get photoScanStepSearchingTitle => 'Uyğun məhsul axtarılır';

  @override
  String get photoScanStepSearchingSubtitle => 'Verilənlər bazasında axtarış';

  @override
  String get photoScanStepPreparingTitle => 'Nəticə hazırlanır';

  @override
  String get photoScanStepPreparingSubtitle => 'Məlumatlar hazırlanır';

  @override
  String get photoScanStepCompleted => 'Tamamlandı';

  @override
  String get photoScanErrorTitle => 'Xəta baş verdi';

  @override
  String get photoScanNotFoodTitle => 'Qida aşkarlanmadı';

  @override
  String get photoScanNotFoodDescription =>
      'Zəhmət olmasa yeyəcək və ya içəcək şəklini çəkin.';

  @override
  String photoScanNutritionValues(String amount, String unit) {
    return '$amount $unit üzrə qida dəyərləri';
  }

  @override
  String get photoScanCalories => 'Kalori';

  @override
  String get photoScanAgain => 'Yenidən çək';

  @override
  String get unitMilligram => 'mq';

  @override
  String get networkTimeoutError => 'Bağlantı vaxtı bitdi. İnterneti yoxlayın.';

  @override
  String get networkServerError => 'Server xətası baş verdi.';

  @override
  String get networkNoConnectionError => 'İnternet bağlantısı yoxdur.';

  @override
  String get networkUnexpectedError => 'Gözlənilməz bir xəta baş verdi.';

  @override
  String get favoritesGuestTitle => 'Sağlam seçimlərini\nsaxla';

  @override
  String get favoritesGuestSubtitle =>
      'Oxutduğun məhsulları əlavə et,\nkalori və dəyərlərini izlə.';

  @override
  String get favoritesGuestFeatureSaveProducts => 'Məhsulları saxla';

  @override
  String get favoritesGuestFeatureCreateCollections => 'Kolleksiyalar yarat';

  @override
  String get favoritesGuestFeatureFindAnytime => 'İstənilən vaxt tap';

  @override
  String get favoritesSearchHint => 'Axtar...';

  @override
  String get favoritesSavedProducts => 'Saxlanılmış məhsullar';

  @override
  String get favoritesTitle => 'Favoritlər';

  @override
  String favoritesSavedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count məhsul saxlanılıb',
      one: '1 məhsul saxlanılıb',
      zero: 'Heç bir məhsul saxlanılmayıb',
    );
    return '$_temp0';
  }

  @override
  String get favoritesEmptyTitle => 'Hələ heç nə saxlanılmayıb';

  @override
  String get favoritesEmptySubtitle =>
      'Məhsulları tarayaraq favoritlərə əlavə et';

  @override
  String get favoritesRetry => 'Yenidən cəhd et';

  @override
  String get favoritesCreateCollectionTitle => 'Yeni kolleksiya';

  @override
  String get favoritesCollectionNameHint => 'Kolleksiya adı...';

  @override
  String get favoritesSelectIcon => 'İkon seç';

  @override
  String get favoritesCreate => 'Yarat';

  @override
  String get favoritesNew => 'Yeni';

  @override
  String get favoritesIconGym => 'İdman';

  @override
  String get favoritesIconBreakfast => 'Səhər yeməyi';

  @override
  String get favoritesIconLunch => 'Nahar';

  @override
  String get favoritesIconDinner => 'Axşam yeməyi';

  @override
  String get favoritesIconSnack => 'Ara yemək';

  @override
  String get favoritesIconSalad => 'Salat';

  @override
  String get favoritesIconFruit => 'Meyvə';

  @override
  String get favoritesIconDrink => 'İçki';

  @override
  String get favoritesIconDiet => 'Pəhriz';

  @override
  String get favoritesIconProtein => 'Protein';

  @override
  String get favoritesIconVegan => 'Vegan';

  @override
  String get favoritesIconDessert => 'Desert';

  @override
  String favoritesCollectionItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count məhsul',
      one: '1 məhsul',
      zero: '0 məhsul',
    );
    return '$_temp0';
  }

  @override
  String favoritesCaloriesValue(int value) {
    return '$value kkal';
  }

  @override
  String favoritesProteinValue(int value) {
    return '$value q Z';
  }

  @override
  String favoritesCarbsValue(int value) {
    return '$value q K';
  }

  @override
  String get onboardingFirstTitle => 'Sağlamlığına doğru';

  @override
  String get onboardingFirstHighlight => 'ilk addım';

  @override
  String get onboardingFirstSubtitle =>
      'SağlamQal ilə hər gün nə yediyini bil, izlə və daha yaxşı seç. Kameranı tut, qalanını biz edək.';

  @override
  String get onboardingSecondTitle => 'Şəkil çək';

  @override
  String get onboardingSecondHighlight => 'hər şeyi öyrən';

  @override
  String get onboardingSecondSubtitle =>
      'Şəkil çək — AI saniyələr içində kalorini və qida dəyərini göstərsin.';

  @override
  String get onboardingThirdTitle => 'Susuz qalma';

  @override
  String get onboardingThirdHighlight => 'xatırladaq';

  @override
  String get onboardingThirdSubtitle =>
      'Gün ərzində su içməni izlə. Vaxtı gələndə SağlamQal sənə xatırladacaq.';

  @override
  String get onboardingFourthTitle => 'Sevdiklərini saxla';

  @override
  String get onboardingFourthHighlight => 'keçmişinə bax';

  @override
  String get onboardingFourthSubtitle =>
      'Bəyəndiklərini favoritlərə əlavə et. Bütün scan tarixçən bir yerdə.';

  @override
  String get onboardingFifthTitle => 'Bu gün';

  @override
  String get onboardingFifthHighlight => 'nə bişirək?';

  @override
  String get onboardingFifthSubtitle =>
      'Hər gün yeni, sağlam reseptlər. Maddələrdən addım-addım izahatına qədər.';

  @override
  String get onboardingStart => 'Başla';

  @override
  String get onboardingContinue => 'Davam et';

  @override
  String get onboardingLetsStart => 'Başlayaq';

  @override
  String get onboardingSkip => 'Keç →';
}
