import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_az.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('az'),
    Locale('en'),
    Locale('ru'),
    Locale('tr'),
  ];

  /// No description provided for @languageTitle.
  ///
  /// In az, this message translates to:
  /// **'Dil seçimi'**
  String get languageTitle;

  /// No description provided for @systemLanguage.
  ///
  /// In az, this message translates to:
  /// **'Sistem dili'**
  String get systemLanguage;

  /// No description provided for @continueButton.
  ///
  /// In az, this message translates to:
  /// **'Davam et'**
  String get continueButton;

  /// No description provided for @settingsTitle.
  ///
  /// In az, this message translates to:
  /// **'Ayarlar'**
  String get settingsTitle;

  /// No description provided for @languageSaveError.
  ///
  /// In az, this message translates to:
  /// **'Dil seçimi saxlanmadı. Yenidən cəhd edin'**
  String get languageSaveError;

  /// No description provided for @authGenericError.
  ///
  /// In az, this message translates to:
  /// **'Xəta baş verdi, yenidən cəhd edin'**
  String get authGenericError;

  /// No description provided for @authEmailLabel.
  ///
  /// In az, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @authEmailHint.
  ///
  /// In az, this message translates to:
  /// **'Emailinizi daxil edin'**
  String get authEmailHint;

  /// No description provided for @authEmailExample.
  ///
  /// In az, this message translates to:
  /// **'example@email.com'**
  String get authEmailExample;

  /// No description provided for @authEmailRequired.
  ///
  /// In az, this message translates to:
  /// **'Email daxil edin'**
  String get authEmailRequired;

  /// No description provided for @authEmailInvalid.
  ///
  /// In az, this message translates to:
  /// **'Düzgün email daxil edin'**
  String get authEmailInvalid;

  /// No description provided for @authPasswordLabel.
  ///
  /// In az, this message translates to:
  /// **'Şifrə'**
  String get authPasswordLabel;

  /// No description provided for @authPasswordHint.
  ///
  /// In az, this message translates to:
  /// **'Şifrənizi daxil edin'**
  String get authPasswordHint;

  /// No description provided for @authPasswordRequired.
  ///
  /// In az, this message translates to:
  /// **'Şifrə daxil edin'**
  String get authPasswordRequired;

  /// No description provided for @authPasswordMinLength.
  ///
  /// In az, this message translates to:
  /// **'Şifrə ən az 6 simvol olmalıdır'**
  String get authPasswordMinLength;

  /// No description provided for @authConfirmPasswordLabel.
  ///
  /// In az, this message translates to:
  /// **'Şifrəni təsdiqlə'**
  String get authConfirmPasswordLabel;

  /// No description provided for @authConfirmPasswordHint.
  ///
  /// In az, this message translates to:
  /// **'Şifrənizi təkrar daxil edin'**
  String get authConfirmPasswordHint;

  /// No description provided for @authConfirmPasswordRequired.
  ///
  /// In az, this message translates to:
  /// **'Şifrəni təsdiqləyin'**
  String get authConfirmPasswordRequired;

  /// No description provided for @authPasswordsDoNotMatch.
  ///
  /// In az, this message translates to:
  /// **'Şifrələr uyğun deyil'**
  String get authPasswordsDoNotMatch;

  /// No description provided for @authLoginTitle.
  ///
  /// In az, this message translates to:
  /// **'Daxil ol'**
  String get authLoginTitle;

  /// No description provided for @authLoginButton.
  ///
  /// In az, this message translates to:
  /// **'Daxil ol'**
  String get authLoginButton;

  /// No description provided for @authForgotPasswordLink.
  ///
  /// In az, this message translates to:
  /// **'Şifrənizi unutmusunuz?'**
  String get authForgotPasswordLink;

  /// No description provided for @authOr.
  ///
  /// In az, this message translates to:
  /// **'və ya'**
  String get authOr;

  /// No description provided for @authContinueWithGoogle.
  ///
  /// In az, this message translates to:
  /// **'Google ilə davam et'**
  String get authContinueWithGoogle;

  /// No description provided for @authNoAccount.
  ///
  /// In az, this message translates to:
  /// **'Hesabın yoxdur?'**
  String get authNoAccount;

  /// No description provided for @authRegisterLink.
  ///
  /// In az, this message translates to:
  /// **'Qeydiyyat'**
  String get authRegisterLink;

  /// No description provided for @authHaveAccount.
  ///
  /// In az, this message translates to:
  /// **'Hesabın var?'**
  String get authHaveAccount;

  /// No description provided for @authRegisterButton.
  ///
  /// In az, this message translates to:
  /// **'Qeydiyyatdan keç'**
  String get authRegisterButton;

  /// No description provided for @authFirstNameLabel.
  ///
  /// In az, this message translates to:
  /// **'Ad'**
  String get authFirstNameLabel;

  /// No description provided for @authFirstNameHint.
  ///
  /// In az, this message translates to:
  /// **'Adınızı daxil edin'**
  String get authFirstNameHint;

  /// No description provided for @authLastNameLabel.
  ///
  /// In az, this message translates to:
  /// **'Soyad'**
  String get authLastNameLabel;

  /// No description provided for @authLastNameHint.
  ///
  /// In az, this message translates to:
  /// **'Soyadınızı daxil edin'**
  String get authLastNameHint;

  /// No description provided for @authGoogleIdTokenMissing.
  ///
  /// In az, this message translates to:
  /// **'Google ID token alınmadı. Yenidən cəhd edin.'**
  String get authGoogleIdTokenMissing;

  /// No description provided for @authGoogleLoginFailed.
  ///
  /// In az, this message translates to:
  /// **'Google ilə giriş mümkün olmadı. Yenidən cəhd edin.'**
  String get authGoogleLoginFailed;

  /// No description provided for @authGoogleLoginError.
  ///
  /// In az, this message translates to:
  /// **'Google ilə giriş zamanı xəta baş verdi.'**
  String get authGoogleLoginError;

  /// No description provided for @authGoogleCredentialsMissing.
  ///
  /// In az, this message translates to:
  /// **'Google giriş məlumatları alınmadı'**
  String get authGoogleCredentialsMissing;

  /// No description provided for @authAccountDeactivatedTitle.
  ///
  /// In az, this message translates to:
  /// **'Hesab deaktivdir'**
  String get authAccountDeactivatedTitle;

  /// No description provided for @authAccountDeactivatedMessage.
  ///
  /// In az, this message translates to:
  /// **'Hesabınız deaktiv edilmişdir. Yenidən aktivləşdirmək üçün emailinizə doğrulama kodu göndəriləcək.'**
  String get authAccountDeactivatedMessage;

  /// No description provided for @authReactivateButton.
  ///
  /// In az, this message translates to:
  /// **'Aktivləşdir'**
  String get authReactivateButton;

  /// No description provided for @authPasswordNotSetTitle.
  ///
  /// In az, this message translates to:
  /// **'Şifrə təyin edilməyib'**
  String get authPasswordNotSetTitle;

  /// No description provided for @authPasswordNotSetMessage.
  ///
  /// In az, this message translates to:
  /// **'Bu hesab Google ilə yaradılıb. Email və şifrə ilə daxil olmaq üçün hesabınıza şifrə təyin edin.'**
  String get authPasswordNotSetMessage;

  /// No description provided for @authSetPasswordButton.
  ///
  /// In az, this message translates to:
  /// **'Şifrə təyin et'**
  String get authSetPasswordButton;

  /// No description provided for @authForgotPasswordTitle.
  ///
  /// In az, this message translates to:
  /// **'Şifrəni Unutdum'**
  String get authForgotPasswordTitle;

  /// No description provided for @authForgotPasswordDescription.
  ///
  /// In az, this message translates to:
  /// **'Email ünvanınızı daxil edin, şifrə sıfırlama kodu göndərəcəyik'**
  String get authForgotPasswordDescription;

  /// No description provided for @authPasswordResetCodeSent.
  ///
  /// In az, this message translates to:
  /// **'Şifrə sıfırlama kodu göndərildi'**
  String get authPasswordResetCodeSent;

  /// No description provided for @authSendCodeButton.
  ///
  /// In az, this message translates to:
  /// **'Kodu Göndər'**
  String get authSendCodeButton;

  /// No description provided for @authBackButton.
  ///
  /// In az, this message translates to:
  /// **'Geri qayıt'**
  String get authBackButton;

  /// No description provided for @authNewPasswordTitle.
  ///
  /// In az, this message translates to:
  /// **'Yeni Şifrə'**
  String get authNewPasswordTitle;

  /// No description provided for @authNewPasswordDescription.
  ///
  /// In az, this message translates to:
  /// **'Yeni şifrənizi daxil edin'**
  String get authNewPasswordDescription;

  /// No description provided for @authNewPasswordLabel.
  ///
  /// In az, this message translates to:
  /// **'Yeni şifrə'**
  String get authNewPasswordLabel;

  /// No description provided for @authPasswordResetSuccess.
  ///
  /// In az, this message translates to:
  /// **'Şifrəniz uğurla yeniləndi'**
  String get authPasswordResetSuccess;

  /// No description provided for @authUpdatePasswordButton.
  ///
  /// In az, this message translates to:
  /// **'Şifrəni Yenilə'**
  String get authUpdatePasswordButton;

  /// No description provided for @authOtpCodeResent.
  ///
  /// In az, this message translates to:
  /// **'Yeni kod göndərildi'**
  String get authOtpCodeResent;

  /// No description provided for @authOtpDidNotReceive.
  ///
  /// In az, this message translates to:
  /// **'Kodu almadınız?'**
  String get authOtpDidNotReceive;

  /// No description provided for @authOtpResend.
  ///
  /// In az, this message translates to:
  /// **'Yenidən göndər'**
  String get authOtpResend;

  /// OTP resend countdown
  ///
  /// In az, this message translates to:
  /// **'{seconds} san'**
  String authOtpSecondsRemaining(int seconds);

  /// No description provided for @authOtpEmailVerificationTitle.
  ///
  /// In az, this message translates to:
  /// **'Email Təsdiqləmə'**
  String get authOtpEmailVerificationTitle;

  /// No description provided for @authOtpPasswordResetTitle.
  ///
  /// In az, this message translates to:
  /// **'Şifrə Sıfırlama'**
  String get authOtpPasswordResetTitle;

  /// No description provided for @authOtpAccountRestoreTitle.
  ///
  /// In az, this message translates to:
  /// **'Hesab Bərpası'**
  String get authOtpAccountRestoreTitle;

  /// No description provided for @authOtpEmailVerificationDescription.
  ///
  /// In az, this message translates to:
  /// **'Emailinizə göndərilən 6 rəqəmli kodu daxil edin'**
  String get authOtpEmailVerificationDescription;

  /// No description provided for @authOtpPasswordResetDescription.
  ///
  /// In az, this message translates to:
  /// **'Şifrənizi yeniləmək üçün emailinizə göndərilən 6 rəqəmli kodu daxil edin'**
  String get authOtpPasswordResetDescription;

  /// No description provided for @authOtpAccountRestoreDescription.
  ///
  /// In az, this message translates to:
  /// **'Hesabınızı bərpa etmək üçün emailinizə göndərilən 6 rəqəmli kodu daxil edin'**
  String get authOtpAccountRestoreDescription;

  /// No description provided for @authPhoneNumberLabel.
  ///
  /// In az, this message translates to:
  /// **'Telefon nömrəsi'**
  String get authPhoneNumberLabel;

  /// No description provided for @authRegistrationBack.
  ///
  /// In az, this message translates to:
  /// **'Geri'**
  String get authRegistrationBack;

  /// Registration step indicator
  ///
  /// In az, this message translates to:
  /// **'Qeydiyyat {current} / {total}'**
  String authRegistrationStep(int current, int total);

  /// No description provided for @profileBirthdayRequired.
  ///
  /// In az, this message translates to:
  /// **'Doğum tarixini seçin'**
  String get profileBirthdayRequired;

  /// No description provided for @profileGenderRequired.
  ///
  /// In az, this message translates to:
  /// **'Cins seçin'**
  String get profileGenderRequired;

  /// No description provided for @profileActivityLevelRequired.
  ///
  /// In az, this message translates to:
  /// **'Aktivlik səviyyəsi seçin'**
  String get profileActivityLevelRequired;

  /// No description provided for @profileGoalRequired.
  ///
  /// In az, this message translates to:
  /// **'Məqsəd seçin'**
  String get profileGoalRequired;

  /// No description provided for @profileWeightHeightInvalid.
  ///
  /// In az, this message translates to:
  /// **'Çəki və boy məlumatlarını düzgün daxil edin'**
  String get profileWeightHeightInvalid;

  /// No description provided for @profilePersonalInfoTitle.
  ///
  /// In az, this message translates to:
  /// **'Şəxsi məlumatlar'**
  String get profilePersonalInfoTitle;

  /// No description provided for @profilePersonalInfoDescription.
  ///
  /// In az, this message translates to:
  /// **'Sizi daha yaxşı tanımaq üçün əsas məlumatları tamamlayın.'**
  String get profilePersonalInfoDescription;

  /// No description provided for @profileBodyMetricsTitle.
  ///
  /// In az, this message translates to:
  /// **'Bədən göstəriciləri'**
  String get profileBodyMetricsTitle;

  /// No description provided for @profileBodyMetricsDescription.
  ///
  /// In az, this message translates to:
  /// **'Boy və çəki məlumatlarınız gündəlik ehtiyacların hesablanmasına kömək edir.'**
  String get profileBodyMetricsDescription;

  /// No description provided for @profileActivityLevelTitle.
  ///
  /// In az, this message translates to:
  /// **'Aktivlik səviyyəsi'**
  String get profileActivityLevelTitle;

  /// No description provided for @profileActivityLevelDescription.
  ///
  /// In az, this message translates to:
  /// **'Adi gününüzə ən yaxın fiziki aktivlik səviyyəsini seçin.'**
  String get profileActivityLevelDescription;

  /// No description provided for @profileGoalTitle.
  ///
  /// In az, this message translates to:
  /// **'Məqsədiniz'**
  String get profileGoalTitle;

  /// No description provided for @profileGoalDescription.
  ///
  /// In az, this message translates to:
  /// **'SağlamQal planınızı seçdiyiniz məqsədə uyğun fərdiləşdirəcək.'**
  String get profileGoalDescription;

  /// No description provided for @profileLastStep.
  ///
  /// In az, this message translates to:
  /// **'Son addım'**
  String get profileLastStep;

  /// No description provided for @profileCompleteTitle.
  ///
  /// In az, this message translates to:
  /// **'Profilinizi tamamlayaq'**
  String get profileCompleteTitle;

  /// No description provided for @profileCompleteDescription.
  ///
  /// In az, this message translates to:
  /// **'Sizə uyğun kalori və qidalanma planı hazırlamaq üçün bir neçə məlumat lazımdır.'**
  String get profileCompleteDescription;

  /// No description provided for @profileTargetWeightLabel.
  ///
  /// In az, this message translates to:
  /// **'Hədəf çəki'**
  String get profileTargetWeightLabel;

  /// No description provided for @profileOptional.
  ///
  /// In az, this message translates to:
  /// **'İstəyə bağlı'**
  String get profileOptional;

  /// No description provided for @profileTargetWeightHint.
  ///
  /// In az, this message translates to:
  /// **'Məsələn: 65'**
  String get profileTargetWeightHint;

  /// No description provided for @profileInvalidWeight.
  ///
  /// In az, this message translates to:
  /// **'Düzgün çəki daxil edin'**
  String get profileInvalidWeight;

  /// No description provided for @profileWeightRangeError.
  ///
  /// In az, this message translates to:
  /// **'Çəki 20-500 kq aralığında olmalıdır'**
  String get profileWeightRangeError;

  /// No description provided for @profilePrivacyNote.
  ///
  /// In az, this message translates to:
  /// **'Məlumatlarınız yalnız sizə uyğun fərdi plan yaratmaq üçün istifadə olunur.'**
  String get profilePrivacyNote;

  /// No description provided for @profileCompleteButton.
  ///
  /// In az, this message translates to:
  /// **'Profili tamamla'**
  String get profileCompleteButton;

  /// No description provided for @profileBirthdayLabel.
  ///
  /// In az, this message translates to:
  /// **'Doğum tarixi'**
  String get profileBirthdayLabel;

  /// No description provided for @profileBirthdaySelect.
  ///
  /// In az, this message translates to:
  /// **'Doğum tarixini seçin'**
  String get profileBirthdaySelect;

  /// Formatted birthday with calculated age
  ///
  /// In az, this message translates to:
  /// **'{date} ({age} yaş)'**
  String profileBirthdayWithAge(String date, int age);

  /// No description provided for @profileGenderLabel.
  ///
  /// In az, this message translates to:
  /// **'Cins'**
  String get profileGenderLabel;

  /// No description provided for @profileGenderMale.
  ///
  /// In az, this message translates to:
  /// **'Kişi'**
  String get profileGenderMale;

  /// No description provided for @profileGenderFemale.
  ///
  /// In az, this message translates to:
  /// **'Qadın'**
  String get profileGenderFemale;

  /// No description provided for @profileWeightLabel.
  ///
  /// In az, this message translates to:
  /// **'Çəki'**
  String get profileWeightLabel;

  /// No description provided for @profileHeightLabel.
  ///
  /// In az, this message translates to:
  /// **'Boy'**
  String get profileHeightLabel;

  /// No description provided for @unitKg.
  ///
  /// In az, this message translates to:
  /// **'kq'**
  String get unitKg;

  /// No description provided for @unitCm.
  ///
  /// In az, this message translates to:
  /// **'sm'**
  String get unitCm;

  /// No description provided for @activitySedentaryLabel.
  ///
  /// In az, this message translates to:
  /// **'Oturaq'**
  String get activitySedentaryLabel;

  /// No description provided for @activitySedentaryDescription.
  ///
  /// In az, this message translates to:
  /// **'Demək olar ki, heç bir fiziki aktivlik yoxdur'**
  String get activitySedentaryDescription;

  /// No description provided for @activityLightLabel.
  ///
  /// In az, this message translates to:
  /// **'Az aktiv'**
  String get activityLightLabel;

  /// No description provided for @activityLightDescription.
  ///
  /// In az, this message translates to:
  /// **'Həftədə 1-3 gün yüngül idman'**
  String get activityLightDescription;

  /// No description provided for @activityModerateLabel.
  ///
  /// In az, this message translates to:
  /// **'Orta aktiv'**
  String get activityModerateLabel;

  /// No description provided for @activityModerateDescription.
  ///
  /// In az, this message translates to:
  /// **'Həftədə 3-5 gün orta səviyyəli idman'**
  String get activityModerateDescription;

  /// No description provided for @activityActiveLabel.
  ///
  /// In az, this message translates to:
  /// **'Çox aktiv'**
  String get activityActiveLabel;

  /// No description provided for @activityActiveDescription.
  ///
  /// In az, this message translates to:
  /// **'Həftədə 6-7 gün intensiv idman'**
  String get activityActiveDescription;

  /// No description provided for @activityVeryActiveLabel.
  ///
  /// In az, this message translates to:
  /// **'Həddindən çox aktiv'**
  String get activityVeryActiveLabel;

  /// No description provided for @activityVeryActiveDescription.
  ///
  /// In az, this message translates to:
  /// **'Gündə 2 dəfə idman və ya ağır fiziki iş'**
  String get activityVeryActiveDescription;

  /// No description provided for @goalLoseWeightLabel.
  ///
  /// In az, this message translates to:
  /// **'Çəki itirmək'**
  String get goalLoseWeightLabel;

  /// No description provided for @goalLoseWeightDescription.
  ///
  /// In az, this message translates to:
  /// **'Kalori defisiti ilə arıqlamaq istəyirəm'**
  String get goalLoseWeightDescription;

  /// No description provided for @goalMaintainWeightLabel.
  ///
  /// In az, this message translates to:
  /// **'Çəkini saxlamaq'**
  String get goalMaintainWeightLabel;

  /// No description provided for @goalMaintainWeightDescription.
  ///
  /// In az, this message translates to:
  /// **'Hazırkı çəkimi qorumaq istəyirəm'**
  String get goalMaintainWeightDescription;

  /// No description provided for @goalGainWeightLabel.
  ///
  /// In az, this message translates to:
  /// **'Çəki artırmaq'**
  String get goalGainWeightLabel;

  /// No description provided for @goalGainWeightDescription.
  ///
  /// In az, this message translates to:
  /// **'Kalori profisiti ilə çəki qazanmaq istəyirəm'**
  String get goalGainWeightDescription;

  /// No description provided for @validationRequired.
  ///
  /// In az, this message translates to:
  /// **'Bu sahə boş qala bilməz'**
  String get validationRequired;

  /// No description provided for @validationPhoneRequired.
  ///
  /// In az, this message translates to:
  /// **'Telefon nömrəsi daxil edin'**
  String get validationPhoneRequired;

  /// No description provided for @validationPhoneDigitsOnly.
  ///
  /// In az, this message translates to:
  /// **'Telefon yalnız rəqəmlərdən ibarət olmalıdır'**
  String get validationPhoneDigitsOnly;

  /// No description provided for @validationPhoneInvalid.
  ///
  /// In az, this message translates to:
  /// **'Düzgün telefon nömrəsi daxil edin'**
  String get validationPhoneInvalid;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['az', 'en', 'ru', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'az':
      return AppLocalizationsAz();
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
