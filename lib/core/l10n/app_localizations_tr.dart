// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get languageTitle => 'Dil seçimi';

  @override
  String get systemLanguage => 'Sistem dili';

  @override
  String get continueButton => 'Devam et';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get languageSaveError =>
      'Dil seçimi kaydedilemedi. Lütfen tekrar deneyin';

  @override
  String get authGenericError => 'Bir hata oluştu. Lütfen tekrar deneyin';

  @override
  String get authEmailLabel => 'E-posta';

  @override
  String get authEmailHint => 'E-posta adresinizi girin';

  @override
  String get authEmailExample => 'example@email.com';

  @override
  String get authEmailRequired => 'E-posta adresinizi girin';

  @override
  String get authEmailInvalid => 'Geçerli bir e-posta adresi girin';

  @override
  String get authPasswordLabel => 'Şifre';

  @override
  String get authPasswordHint => 'Şifrenizi girin';

  @override
  String get authPasswordRequired => 'Şifrenizi girin';

  @override
  String get authPasswordMinLength => 'Şifre en az 6 karakter olmalıdır';

  @override
  String get authConfirmPasswordLabel => 'Şifreyi doğrula';

  @override
  String get authConfirmPasswordHint => 'Şifrenizi tekrar girin';

  @override
  String get authConfirmPasswordRequired => 'Şifrenizi doğrulayın';

  @override
  String get authPasswordsDoNotMatch => 'Şifreler eşleşmiyor';

  @override
  String get authLoginTitle => 'Giriş yap';

  @override
  String get authLoginButton => 'Giriş yap';

  @override
  String get authForgotPasswordLink => 'Şifrenizi mi unuttunuz?';

  @override
  String get authOr => 'veya';

  @override
  String get authContinueWithGoogle => 'Google ile devam et';

  @override
  String get authNoAccount => 'Hesabınız yok mu?';

  @override
  String get authRegisterLink => 'Kayıt ol';

  @override
  String get authHaveAccount => 'Hesabınız var mı?';

  @override
  String get authRegisterButton => 'Kayıt ol';

  @override
  String get authFirstNameLabel => 'Ad';

  @override
  String get authFirstNameHint => 'Adınızı girin';

  @override
  String get authLastNameLabel => 'Soyad';

  @override
  String get authLastNameHint => 'Soyadınızı girin';

  @override
  String get authGoogleIdTokenMissing =>
      'Google ID token alınamadı. Lütfen tekrar deneyin.';

  @override
  String get authGoogleLoginFailed =>
      'Google ile giriş yapılamadı. Lütfen tekrar deneyin.';

  @override
  String get authGoogleLoginError =>
      'Google ile giriş sırasında bir hata oluştu.';

  @override
  String get authGoogleCredentialsMissing => 'Google giriş bilgileri alınamadı';

  @override
  String get authAccountDeactivatedTitle => 'Hesap devre dışı';

  @override
  String get authAccountDeactivatedMessage =>
      'Hesabınız devre dışı bırakılmıştır. Yeniden etkinleştirmek için e-posta adresinize bir doğrulama kodu gönderilecektir.';

  @override
  String get authReactivateButton => 'Etkinleştir';

  @override
  String get authPasswordNotSetTitle => 'Şifre belirlenmemiş';

  @override
  String get authPasswordNotSetMessage =>
      'Bu hesap Google ile oluşturuldu. E-posta ve şifreyle giriş yapmak için hesabınıza bir şifre belirleyin.';

  @override
  String get authSetPasswordButton => 'Şifre belirle';

  @override
  String get authForgotPasswordTitle => 'Şifremi Unuttum';

  @override
  String get authForgotPasswordDescription =>
      'E-posta adresinizi girin, size bir şifre sıfırlama kodu gönderelim';

  @override
  String get authPasswordResetCodeSent => 'Şifre sıfırlama kodu gönderildi';

  @override
  String get authSendCodeButton => 'Kodu Gönder';

  @override
  String get authBackButton => 'Geri dön';

  @override
  String get authNewPasswordTitle => 'Yeni Şifre';

  @override
  String get authNewPasswordDescription => 'Yeni şifrenizi girin';

  @override
  String get authNewPasswordLabel => 'Yeni şifre';

  @override
  String get authPasswordResetSuccess => 'Şifreniz başarıyla güncellendi';

  @override
  String get authUpdatePasswordButton => 'Şifreyi Güncelle';

  @override
  String get authOtpCodeResent => 'Yeni kod gönderildi';

  @override
  String get authOtpDidNotReceive => 'Kodu almadınız mı?';

  @override
  String get authOtpResend => 'Tekrar gönder';

  @override
  String authOtpSecondsRemaining(int seconds) {
    return '$seconds sn';
  }

  @override
  String get authOtpEmailVerificationTitle => 'E-posta Doğrulama';

  @override
  String get authOtpPasswordResetTitle => 'Şifre Sıfırlama';

  @override
  String get authOtpAccountRestoreTitle => 'Hesap Kurtarma';

  @override
  String get authOtpEmailVerificationDescription =>
      'E-posta adresinize gönderilen 6 haneli kodu girin';

  @override
  String get authOtpPasswordResetDescription =>
      'Şifrenizi yenilemek için e-posta adresinize gönderilen 6 haneli kodu girin';

  @override
  String get authOtpAccountRestoreDescription =>
      'Hesabınızı geri yüklemek için e-posta adresinize gönderilen 6 haneli kodu girin';

  @override
  String get authPhoneNumberLabel => 'Telefon numarası';

  @override
  String get authRegistrationBack => 'Geri';

  @override
  String authRegistrationStep(int current, int total) {
    return 'Kayıt $current / $total';
  }

  @override
  String get profileBirthdayRequired => 'Doğum tarihinizi seçin';

  @override
  String get profileGenderRequired => 'Cinsiyetinizi seçin';

  @override
  String get profileActivityLevelRequired => 'Aktivite seviyenizi seçin';

  @override
  String get profileGoalRequired => 'Hedefinizi seçin';

  @override
  String get profileWeightHeightInvalid =>
      'Geçerli kilo ve boy bilgileri girin';

  @override
  String get profilePersonalInfoTitle => 'Kişisel bilgiler';

  @override
  String get profilePersonalInfoDescription =>
      'Sizi daha iyi tanıyabilmemiz için temel bilgilerinizi tamamlayın.';

  @override
  String get profileBodyMetricsTitle => 'Vücut ölçüleri';

  @override
  String get profileBodyMetricsDescription =>
      'Boy ve kilo bilgileriniz günlük ihtiyaçlarınızın hesaplanmasına yardımcı olur.';

  @override
  String get profileActivityLevelTitle => 'Aktivite seviyesi';

  @override
  String get profileActivityLevelDescription =>
      'Normal bir gününüze en yakın fiziksel aktivite seviyesini seçin.';

  @override
  String get profileGoalTitle => 'Hedefiniz';

  @override
  String get profileGoalDescription =>
      'SağlamQal, planınızı seçtiğiniz hedefe göre kişiselleştirecektir.';

  @override
  String get profileLastStep => 'Son adım';

  @override
  String get profileCompleteTitle => 'Profilinizi tamamlayalım';

  @override
  String get profileCompleteDescription =>
      'Size uygun kalori ve beslenme planı hazırlamak için birkaç bilgiye ihtiyacımız var.';

  @override
  String get profileTargetWeightLabel => 'Hedef kilo';

  @override
  String get profileOptional => 'İsteğe bağlı';

  @override
  String get profileTargetWeightHint => 'Örneğin: 65';

  @override
  String get profileInvalidWeight => 'Geçerli bir kilo girin';

  @override
  String get profileWeightRangeError => 'Kilo 20-500 kg arasında olmalıdır';

  @override
  String get profilePrivacyNote =>
      'Bilgileriniz yalnızca size özel bir plan oluşturmak için kullanılır.';

  @override
  String get profileCompleteButton => 'Profili tamamla';

  @override
  String get profileBirthdayLabel => 'Doğum tarihi';

  @override
  String get profileBirthdaySelect => 'Doğum tarihinizi seçin';

  @override
  String profileBirthdayWithAge(String date, int age) {
    return '$date ($age yaş)';
  }

  @override
  String get profileGenderLabel => 'Cinsiyet';

  @override
  String get profileGenderMale => 'Erkek';

  @override
  String get profileGenderFemale => 'Kadın';

  @override
  String get profileWeightLabel => 'Kilo';

  @override
  String get profileHeightLabel => 'Boy';

  @override
  String get unitKg => 'kg';

  @override
  String get unitCm => 'cm';

  @override
  String get activitySedentaryLabel => 'Hareketsiz';

  @override
  String get activitySedentaryDescription =>
      'Neredeyse hiç fiziksel aktivite yok';

  @override
  String get activityLightLabel => 'Az aktif';

  @override
  String get activityLightDescription => 'Haftada 1-3 gün hafif egzersiz';

  @override
  String get activityModerateLabel => 'Orta aktif';

  @override
  String get activityModerateDescription =>
      'Haftada 3-5 gün orta düzey egzersiz';

  @override
  String get activityActiveLabel => 'Çok aktif';

  @override
  String get activityActiveDescription => 'Haftada 6-7 gün yoğun egzersiz';

  @override
  String get activityVeryActiveLabel => 'Aşırı aktif';

  @override
  String get activityVeryActiveDescription =>
      'Günde 2 kez egzersiz veya ağır fiziksel iş';

  @override
  String get goalLoseWeightLabel => 'Kilo vermek';

  @override
  String get goalLoseWeightDescription =>
      'Kalori açığıyla kilo vermek istiyorum';

  @override
  String get goalMaintainWeightLabel => 'Kiloyu korumak';

  @override
  String get goalMaintainWeightDescription => 'Mevcut kilomu korumak istiyorum';

  @override
  String get goalGainWeightLabel => 'Kilo almak';

  @override
  String get goalGainWeightDescription =>
      'Kalori fazlasıyla kilo almak istiyorum';

  @override
  String get validationRequired => 'Bu alan boş bırakılamaz';

  @override
  String get validationPhoneRequired => 'Telefon numaranızı girin';

  @override
  String get validationPhoneDigitsOnly =>
      'Telefon numarası yalnızca rakamlardan oluşmalıdır';

  @override
  String get validationPhoneInvalid => 'Geçerli bir telefon numarası girin';

  @override
  String get homeGreetingMorning => 'Günaydın';

  @override
  String get homeGreetingAfternoon => 'İyi günler';

  @override
  String get homeGreetingEvening => 'İyi akşamlar';

  @override
  String get homeGuest => 'Misafir';

  @override
  String get homeTodayStoryReady => 'Bugünkü hikâyen başlamaya hazır.';

  @override
  String get navHome => 'Ana sayfa';

  @override
  String get navFavorites => 'Favoriler';

  @override
  String get navProfile => 'Profilim';

  @override
  String get homePhotoScanTitle => 'Fotoğrafını çek,\nkalorileri öğren';

  @override
  String get homePhotoScanSubtitle => 'Kalorileri saniyeler içinde öğren';

  @override
  String get homePhotoScanOpenCamera => 'Kamerayı aç';

  @override
  String get homeGuestPreviewTitle => 'Sağlıklı yaşam\nsenin ellerinde.';

  @override
  String get homeGuestFeatureCalories => 'Günlük kalori & makro takibi';

  @override
  String get homeGuestFeatureHydration => 'Su tüketimi takibi';

  @override
  String get homeGuestFeatureHistory => 'Taradığın ürünlerin geçmişi';

  @override
  String get homeDailyRecommendation => 'Günlük öneri';

  @override
  String get macroProtein => 'Protein';

  @override
  String get macroCarbohydrate => 'Karbonhidrat';

  @override
  String get macroFat => 'Yağ';

  @override
  String get nutritionEnergyUpper => 'ENERJİ';

  @override
  String get nutritionDurationUpper => 'SÜRE';

  @override
  String get nutritionServingUpper => 'PORSİYON';

  @override
  String get nutritionProteinUpper => 'PROTEİN';

  @override
  String get nutritionCarbohydrateUpper => 'KARBONHİDRAT';

  @override
  String get nutritionCarbsShortUpper => 'KARB.';

  @override
  String get nutritionFatUpper => 'YAĞ';

  @override
  String get unitKcal => 'kcal';

  @override
  String get unitGram => 'g';

  @override
  String get unitMinuteShort => 'dk';

  @override
  String get unitPerson => 'kişi';

  @override
  String get unitLiter => 'L';

  @override
  String get homeHydrationTitle => 'Hidrasyon';

  @override
  String homeHydrationRecommendation(String value) {
    return 'Önerilen: $value';
  }

  @override
  String get homeMealOfTheDayUpper => 'GÜNÜN YEMEĞİ';

  @override
  String get homeViewRecipe => 'Tarifi görüntüle';

  @override
  String get homeIngredients => 'Malzemeler';

  @override
  String get homePreparationSteps => 'Hazırlama adımları';

  @override
  String get homeRecentProductsTitle => 'Son tarananlar';

  @override
  String get homeViewAll => 'Tümünü gör';

  @override
  String homeRecentProductsCount(int count) {
    return '$count ürün';
  }

  @override
  String get homeNoProductsScanned => 'Henüz hiçbir ürün\ntaranmadı';

  @override
  String get homeScanProductsHint => 'Ürün eklemek için barkodu tara';

  @override
  String get homeScanNow => 'Şimdi tara';

  @override
  String get commonProduct => 'Ürün';

  @override
  String get commonVitamins => 'Vitaminler';

  @override
  String commonTodayAt(String time) {
    return 'Bugün, $time';
  }

  @override
  String commonYesterdayAt(String time) {
    return 'Dün, $time';
  }

  @override
  String homeProductAddedFavorite(String product) {
    return '$product favorilere eklendi';
  }

  @override
  String homeProductRemovedFavorite(String product) {
    return '$product favorilerden kaldırıldı';
  }

  @override
  String get homeBarcodeScanTitle => 'Barkodu Tara';

  @override
  String get homeBarcodeScanSubtitle => 'Ürünün kalorisini anında öğren';

  @override
  String get photoScanTitle => 'Fotoğrafla ara';

  @override
  String get photoScanTipGoodLight => 'İyi ışık';

  @override
  String get photoScanTipFitFrame => 'Kadra sığdırın';

  @override
  String get photoScanTipKeepSteady => 'Sabit tutun';

  @override
  String get photoScanAnalyzingTitle => 'Ürün analiz ediliyor...';

  @override
  String get photoScanAnalyzingDuration =>
      'Bu işlem genellikle 10-15 saniye sürer';

  @override
  String get photoScanAnalyzingExtended =>
      'Biraz daha uzun sürüyor, lütfen bekleyin...';

  @override
  String get photoScanStepCapturedTitle => 'Fotoğraf başarıyla çekildi';

  @override
  String get photoScanStepCapturedSubtitle => 'Kalite kontrol edildi';

  @override
  String get photoScanStepAnalyzingTitle => 'Ürün analiz ediliyor';

  @override
  String get photoScanStepAnalyzingSubtitle => 'AI görüntüyü analiz ediyor';

  @override
  String get photoScanStepSearchingTitle => 'Uygun ürün aranıyor';

  @override
  String get photoScanStepSearchingSubtitle => 'Veritabanında aranıyor';

  @override
  String get photoScanStepPreparingTitle => 'Sonuç hazırlanıyor';

  @override
  String get photoScanStepPreparingSubtitle => 'Bilgiler hazırlanıyor';

  @override
  String get photoScanStepCompleted => 'Tamamlandı';

  @override
  String get photoScanErrorTitle => 'Bir hata oluştu';

  @override
  String get photoScanNotFoodTitle => 'Yiyecek algılanmadı';

  @override
  String get photoScanNotFoodDescription =>
      'Lütfen yiyecek veya içecek bir ürünün fotoğrafını çekin.';

  @override
  String photoScanNutritionValues(String amount, String unit) {
    return '$amount $unit için besin değerleri';
  }

  @override
  String get photoScanCalories => 'Kalori';

  @override
  String get photoScanAgain => 'Yeniden çek';

  @override
  String get unitMilligram => 'mg';

  @override
  String get networkTimeoutError =>
      'Bağlantı zaman aşımına uğradı. İnternet bağlantınızı kontrol edin.';

  @override
  String get networkServerError => 'Bir sunucu hatası oluştu.';

  @override
  String get networkNoConnectionError => 'İnternet bağlantısı yok.';

  @override
  String get networkUnexpectedError => 'Beklenmeyen bir hata oluştu.';

  @override
  String get favoritesGuestTitle => 'Sağlıklı seçimlerini\nkaydet';

  @override
  String get favoritesGuestSubtitle =>
      'Taradığın ürünleri kaydet,\nkalori ve besin değerlerini takip et.';

  @override
  String get favoritesGuestFeatureSaveProducts => 'Ürünleri kaydet';

  @override
  String get favoritesGuestFeatureCreateCollections => 'Koleksiyon oluştur';

  @override
  String get favoritesGuestFeatureFindAnytime => 'İstediğin zaman bul';

  @override
  String get favoritesSearchHint => 'Ara...';

  @override
  String get favoritesSavedProducts => 'Kaydedilen ürünler';

  @override
  String get favoritesTitle => 'Favoriler';

  @override
  String favoritesSavedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ürün kaydedildi',
      one: '1 ürün kaydedildi',
      zero: 'Henüz ürün kaydedilmedi',
    );
    return '$_temp0';
  }

  @override
  String get favoritesEmptyTitle => 'Henüz hiçbir şey kaydedilmedi';

  @override
  String get favoritesEmptySubtitle => 'Ürünleri tarayıp favorilerine ekle';

  @override
  String get favoritesRetry => 'Tekrar dene';

  @override
  String get favoritesCreateCollectionTitle => 'Yeni koleksiyon';

  @override
  String get favoritesCollectionNameHint => 'Koleksiyon adı...';

  @override
  String get favoritesSelectIcon => 'Simge seç';

  @override
  String get favoritesCreate => 'Oluştur';

  @override
  String get favoritesNew => 'Yeni';

  @override
  String get favoritesIconGym => 'Spor';

  @override
  String get favoritesIconBreakfast => 'Kahvaltı';

  @override
  String get favoritesIconLunch => 'Öğle yemeği';

  @override
  String get favoritesIconDinner => 'Akşam yemeği';

  @override
  String get favoritesIconSnack => 'Ara öğün';

  @override
  String get favoritesIconSalad => 'Salata';

  @override
  String get favoritesIconFruit => 'Meyve';

  @override
  String get favoritesIconDrink => 'İçecek';

  @override
  String get favoritesIconDiet => 'Diyet';

  @override
  String get favoritesIconProtein => 'Protein';

  @override
  String get favoritesIconVegan => 'Vegan';

  @override
  String get favoritesIconDessert => 'Tatlı';

  @override
  String favoritesCollectionItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ürün',
      one: '1 ürün',
      zero: '0 ürün',
    );
    return '$_temp0';
  }

  @override
  String favoritesCaloriesValue(int value) {
    return '$value kcal';
  }

  @override
  String favoritesProteinValue(int value) {
    return '$value g P';
  }

  @override
  String favoritesCarbsValue(int value) {
    return '$value g K';
  }

  @override
  String get onboardingFirstTitle => 'Sağlığına doğru';

  @override
  String get onboardingFirstHighlight => 'ilk adım';

  @override
  String get onboardingFirstSubtitle =>
      'SağlamQal ile her gün ne yediğini bil, takip et ve daha iyi seçimler yap. Kamerayı tut, gerisini biz halledelim.';

  @override
  String get onboardingSecondTitle => 'Fotoğraf çek';

  @override
  String get onboardingSecondHighlight => 'her şeyi öğren';

  @override
  String get onboardingSecondSubtitle =>
      'Fotoğraf çek, AI saniyeler içinde kalori ve besin değerlerini göstersin.';

  @override
  String get onboardingThirdTitle => 'Susuz kalma';

  @override
  String get onboardingThirdHighlight => 'biz hatırlatalım';

  @override
  String get onboardingThirdSubtitle =>
      'Gün boyunca su tüketimini takip et. Zamanı geldiğinde SağlamQal sana hatırlatsın.';

  @override
  String get onboardingFourthTitle => 'Sevdiklerini kaydet';

  @override
  String get onboardingFourthHighlight => 'geçmişine bak';

  @override
  String get onboardingFourthSubtitle =>
      'Beğendiğin ürünleri favorilerine ekle. Tüm tarama geçmişin tek bir yerde.';

  @override
  String get onboardingFifthTitle => 'Bugün';

  @override
  String get onboardingFifthHighlight => 'ne pişirelim?';

  @override
  String get onboardingFifthSubtitle =>
      'Her gün yeni ve sağlıklı tarifler. Malzemelerden adım adım hazırlanışına kadar.';

  @override
  String get onboardingStart => 'Başla';

  @override
  String get onboardingContinue => 'Devam et';

  @override
  String get onboardingLetsStart => 'Hadi başlayalım';

  @override
  String get onboardingSkip => 'Geç →';

  @override
  String get waterReminderTitle => 'Su hatırlatıcısı';

  @override
  String get waterReminderUpcoming => 'Sonraki su hatırlatması';

  @override
  String get waterReminderDisabled => 'Su hatırlatıcısı kapalı';

  @override
  String waterReminderNextTime(String time) {
    return 'Sonraki hatırlatma: $time';
  }

  @override
  String get waterReminderPermissionDenied =>
      'Bildirim izni verilmedi. Ayarlardan etkinleştirin.';

  @override
  String get waterReminderChannelName => 'Su hatırlatıcıları';

  @override
  String get waterReminderChannelDescription =>
      'Gün boyunca su içmeni hatırlatır';

  @override
  String get waterReminderNotificationMorningStart => '🌅 Güne suyla başla!';

  @override
  String get waterReminderNotificationMorning => '☀️ Sabah suyunu içtin mi?';

  @override
  String get waterReminderNotificationBeforeLunch =>
      '💧 Öğle yemeğinden önce su zamanı!';

  @override
  String get waterReminderNotificationAfterLunch =>
      '🥗 Öğle yemeğinden sonra su iç!';

  @override
  String get waterReminderNotificationEnergy => '⚡ Enerji için su iç!';

  @override
  String get waterReminderNotificationAfternoon =>
      '🌿 Öğleden sonra su zamanı!';

  @override
  String get waterReminderNotificationBeforeDinner =>
      '🍽️ Akşam yemeğinden önce su iç!';

  @override
  String get waterReminderNotificationLastGlass => '🌙 Günün son bardağı!';

  @override
  String get waterReminderNotificationDefault => '💧 Su içme zamanı!';

  @override
  String get waterReminderMessageOne =>
      'Bir bardak su iç, kendini daha iyi hisset! 🌊';

  @override
  String get waterReminderMessageTwo =>
      'Susuzluk yorgunluğa neden olabilir. Su zamanı! 💪';

  @override
  String get waterReminderMessageThree =>
      'Sağlıklı kalmak için bir bardak su iç! ✨';

  @override
  String get waterReminderMessageFour =>
      'Vücudunun suya ihtiyacı var. Kendine iyi bak! 💧';

  @override
  String get waterReminderMessageFive => 'Bir nefes al ve bir bardak su iç! 🌿';

  @override
  String get waterReminderMessageSix => 'Öğleden sonra da su içmeyi unutma! 💦';

  @override
  String get waterReminderMessageSeven =>
      'Öğle yemeğinden önce bir bardak su iç! 🥗';

  @override
  String get waterReminderMessageEight =>
      'Akşam yemeğinden önce su içmeyi unutma! 🍽️';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileGuestTitle => 'Profiline\ngiriş yap';

  @override
  String get profileGuestSubtitle =>
      'Profil bilgilerini yönet,\nayarlarını kendine göre özelleştir.';

  @override
  String get profileGuestFeatureEdit => 'Profil bilgilerini düzenle';

  @override
  String get profileGuestFeatureSettings => 'Ayarları yönet';

  @override
  String get profileGuestFeaturePrivacy => 'Gizlilik ve güvenliği yönet';

  @override
  String get profileSectionAccountSettings => 'Hesap ve Ayarlar';

  @override
  String get profileSectionNotifications => 'Bildirimler';

  @override
  String get profileSectionSupport => 'Destek';

  @override
  String get profileEditMenu => 'Profili düzenle';

  @override
  String get profilePatientCodeMenu => 'Hasta kodum';

  @override
  String get privacyPolicyTitle => 'Gizlilik Politikası';

  @override
  String get termsOfServiceTitle => 'Kullanım Koşulları';

  @override
  String get aboutUsTitle => 'Hakkımızda';

  @override
  String get profileLogout => 'Çıkış';

  @override
  String get profileLogoutTitle => 'Çıkış yap';

  @override
  String get profileLogoutMessage =>
      'Hesabınızdan çıkmak istediğinizden emin misiniz?';

  @override
  String get profileDeleteAccount => 'Hesabı sil';

  @override
  String get profileDeleteAccountMessage =>
      'Hesabınız devre dışı bırakılacak. İstediğiniz zaman yeniden etkinleştirebilirsiniz.';

  @override
  String get profileDeleteConfirm => 'Sil';

  @override
  String get profileLoadFailed => 'Bilgiler yüklenemedi';

  @override
  String get profileLoadErrorDescription =>
      'İnternet bağlantınızı kontrol edip tekrar deneyin.';

  @override
  String get profileRetry => 'Tekrar dene';

  @override
  String get patientCodeTitle => 'Hasta kodum';

  @override
  String get patientCodeCopied => 'Hasta kodu kopyalandı';

  @override
  String patientCodeShareText(String patientCode) {
    return 'SağlamQal hasta kodum: $patientCode';
  }

  @override
  String get patientCodeShareSubject => 'SağlamQal hasta kodu';

  @override
  String get patientCodeCopy => 'Kodu kopyala';

  @override
  String get patientCodeShare => 'Paylaş';

  @override
  String get patientCodeHeaderTitle => 'Diyetisyeniniz sizi bu kodla bulabilir';

  @override
  String get patientCodeHeaderDescription =>
      'Aşağıdaki kodu diyetisyeninizle paylaşın. Bu kod sayesinde sizi bulup hasta olarak davet edebilir.';

  @override
  String get patientCodeLabel => 'Hasta kodu';

  @override
  String get patientCodePrivacyNote =>
      'Kodunuzu yalnızca iletişim kurmak istediğiniz diyetisyenle paylaşın.';

  @override
  String get patientCodeNotFoundTitle => 'Hasta kodu bulunamadı';

  @override
  String get patientCodeNotFoundDescription =>
      'Şu anda hesabınız için bir hasta kodu bulunmuyor.';

  @override
  String get profileEditTitle => 'Profil düzenleme';

  @override
  String get profileImageCaptureError => 'Fotoğraf çekilirken bir hata oluştu';

  @override
  String get profileImageSelectionError =>
      'Fotoğraf seçilirken bir hata oluştu';

  @override
  String get profileNoChanges => 'Kaydedilecek değişiklik yok';

  @override
  String get profileAvatarUpdated => 'Profil fotoğrafı güncellendi';

  @override
  String get profileAvatarDeleted => 'Profil fotoğrafı silindi';

  @override
  String get profileSaved => 'Profil kaydedildi';

  @override
  String get aboutUsEmail => 'E-posta';

  @override
  String get aboutUsWebsite => 'Web sitesi';

  @override
  String aboutUsInvalidLink(String url) {
    return 'Geçersiz bağlantı: $url';
  }

  @override
  String aboutUsLinkOpenFailed(String url) {
    return 'Bağlantı açılamadı: $url';
  }

  @override
  String aboutUsLinkError(String error) {
    return 'Bir hata oluştu: $error';
  }

  @override
  String get profileEditPersonalInfo => 'Kişisel bilgiler';

  @override
  String get profileEditFirstName => 'Ad';

  @override
  String get profileEditFirstNameHint => 'Adınızı girin';

  @override
  String get profileEditLastName => 'Soyad';

  @override
  String get profileEditLastNameHint => 'Soyadınızı girin';

  @override
  String get profileEditEmail => 'E-posta';

  @override
  String get profileEditPhone => 'Telefon numarası';

  @override
  String get profileEditBirthday => 'Doğum tarihi';

  @override
  String get profileEditBirthdayHint => 'Doğum tarihinizi seçin';

  @override
  String get profileEditPhysicalInfo => 'Fiziksel bilgiler';

  @override
  String get profileEditHeight => 'Boy';

  @override
  String get profileEditCurrentWeight => 'Mevcut kilo';

  @override
  String get profileEditTargetWeight => 'Hedef kilo';

  @override
  String get profileEditUnitCm => 'cm';

  @override
  String get profileEditUnitKg => 'kg';

  @override
  String get profileEditProgressMessage => 'Harika gidiyorsun! Doğru yoldasın.';

  @override
  String get profileEditPreferences => 'Tercihler';

  @override
  String get profileEditGender => 'Cinsiyet';

  @override
  String get profileEditActivityLevel => 'Aktivite seviyesi';

  @override
  String get profileEditGoal => 'Hedefin';

  @override
  String get profileEditConsistencyHint =>
      'Tutarlılık önemlidir. Küçük adımlar büyük değişimlere yol açar!';

  @override
  String get profileActivitySedentary => 'Hareketsiz';

  @override
  String get profileActivityLight => 'Az aktif';

  @override
  String get profileActivityModerate => 'Orta aktif';

  @override
  String get profileActivityActive => 'Aktif';

  @override
  String get profileActivityVeryActive => 'Çok aktif';

  @override
  String get profileGoalLoseWeight => 'Kilo vermek';

  @override
  String get profileGoalMaintainWeight => 'Kiloyu korumak';

  @override
  String get profileGoalGainWeight => 'Kilo almak';

  @override
  String get profileAvatarChangeTitle => 'Profil fotoğrafını değiştir';

  @override
  String get profileAvatarChangeSubtitle =>
      'Yeni fotoğraf çek veya galeriden seç';

  @override
  String get profileAvatarCamera => 'Kamera';

  @override
  String get profileAvatarCameraSubtitle => 'Yeni fotoğraf çek';

  @override
  String get profileAvatarGallery => 'Galeri';

  @override
  String get profileAvatarGallerySubtitle => 'Fotoğraf seç';

  @override
  String get profileAvatarDelete => 'Profil fotoğrafını sil';

  @override
  String get profileAvatarCropTitle => 'Profil fotoğrafını seç';

  @override
  String get profileAvatarCropArea => 'Profil fotoğrafında görünecek alan';

  @override
  String get profileAvatarCropMoveHint =>
      'Fotoğrafı hareket ettir ve yakınlaştır';

  @override
  String get profileAvatarCropDone => 'Hazır';

  @override
  String get profileAvatarCropError => 'Fotoğraf kırpılırken bir hata oluştu';

  @override
  String get profileAvatarImageOpenError => 'Fotoğraf açılamadı';

  @override
  String get profileAvatarImageOpenErrorDescription =>
      'Başka bir fotoğraf seçip tekrar deneyin.';

  @override
  String get profileEditSaveChanges => 'Değişiklikleri kaydet';

  @override
  String get commonCancel => 'İptal';

  @override
  String get commonConfirm => 'Onayla';

  @override
  String get commonRetry => 'Tekrar dene';

  @override
  String get commonGoBack => 'Geri dön';

  @override
  String get commonLogin => 'Giriş yap';

  @override
  String get commonRegister => 'Kayıt ol';

  @override
  String get datePickerBirthDate => 'Doğum tarihi';

  @override
  String get refreshRefreshing => 'Yenileniyor...';

  @override
  String get refreshUpdated => 'Yenilendi';

  @override
  String get rulerTapValueToEdit => 'Değiştirmek için sayıya dokunun';

  @override
  String get rulerManualInput => 'Sayıyı manuel girin';

  @override
  String get errorPageNotFoundTitle => 'Sayfa bulunamadı';

  @override
  String get errorPageNotFoundSubtitle =>
      'Aradığınız sayfa mevcut değil veya kaldırılmış.';

  @override
  String get errorPageNetworkTitle => 'Bağlantı hatası';

  @override
  String get errorPageNetworkSubtitle =>
      'İnternet bağlantınızı kontrol edin ve tekrar deneyin.';

  @override
  String get errorPageServerTitle => 'Sunucu hatası';

  @override
  String get errorPageServerSubtitle =>
      'Sunucuda bir sorun oluştu. Lütfen daha sonra tekrar deneyin.';

  @override
  String get errorPageUnknownTitle => 'Bir hata oluştu';

  @override
  String get errorPageUnknownSubtitle =>
      'Beklenmeyen bir hata oluştu. Lütfen tekrar deneyin.';
}
