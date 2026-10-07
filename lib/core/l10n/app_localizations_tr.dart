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
}
