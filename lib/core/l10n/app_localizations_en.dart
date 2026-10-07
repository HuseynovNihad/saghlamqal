// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get languageTitle => 'Language';

  @override
  String get systemLanguage => 'System language';

  @override
  String get continueButton => 'Continue';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get languageSaveError =>
      'Could not save your language. Please try again';

  @override
  String get authGenericError => 'Something went wrong. Please try again';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authEmailHint => 'Enter your email';

  @override
  String get authEmailExample => 'example@email.com';

  @override
  String get authEmailRequired => 'Enter your email';

  @override
  String get authEmailInvalid => 'Enter a valid email address';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authPasswordHint => 'Enter your password';

  @override
  String get authPasswordRequired => 'Enter your password';

  @override
  String get authPasswordMinLength => 'Password must be at least 6 characters';

  @override
  String get authConfirmPasswordLabel => 'Confirm password';

  @override
  String get authConfirmPasswordHint => 'Re-enter your password';

  @override
  String get authConfirmPasswordRequired => 'Confirm your password';

  @override
  String get authPasswordsDoNotMatch => 'Passwords do not match';

  @override
  String get authLoginTitle => 'Sign in';

  @override
  String get authLoginButton => 'Sign in';

  @override
  String get authForgotPasswordLink => 'Forgot your password?';

  @override
  String get authOr => 'or';

  @override
  String get authContinueWithGoogle => 'Continue with Google';

  @override
  String get authNoAccount => 'Don\'t have an account?';

  @override
  String get authRegisterLink => 'Sign up';

  @override
  String get authHaveAccount => 'Already have an account?';

  @override
  String get authRegisterButton => 'Create account';

  @override
  String get authFirstNameLabel => 'First name';

  @override
  String get authFirstNameHint => 'Enter your first name';

  @override
  String get authLastNameLabel => 'Last name';

  @override
  String get authLastNameHint => 'Enter your last name';

  @override
  String get authGoogleIdTokenMissing =>
      'Could not get the Google ID token. Please try again.';

  @override
  String get authGoogleLoginFailed =>
      'Could not sign in with Google. Please try again.';

  @override
  String get authGoogleLoginError =>
      'An error occurred while signing in with Google.';

  @override
  String get authGoogleCredentialsMissing =>
      'Could not retrieve Google sign-in information';

  @override
  String get authAccountDeactivatedTitle => 'Account deactivated';

  @override
  String get authAccountDeactivatedMessage =>
      'Your account has been deactivated. A verification code will be sent to your email to reactivate it.';

  @override
  String get authReactivateButton => 'Reactivate';

  @override
  String get authPasswordNotSetTitle => 'Password not set';

  @override
  String get authPasswordNotSetMessage =>
      'This account was created with Google. Set a password for your account to sign in with email and password.';

  @override
  String get authSetPasswordButton => 'Set password';

  @override
  String get authForgotPasswordTitle => 'Forgot Password';

  @override
  String get authForgotPasswordDescription =>
      'Enter your email address and we\'ll send you a password reset code';

  @override
  String get authPasswordResetCodeSent => 'Password reset code sent';

  @override
  String get authSendCodeButton => 'Send Code';

  @override
  String get authBackButton => 'Go back';

  @override
  String get authNewPasswordTitle => 'New Password';

  @override
  String get authNewPasswordDescription => 'Enter your new password';

  @override
  String get authNewPasswordLabel => 'New password';

  @override
  String get authPasswordResetSuccess =>
      'Your password has been updated successfully';

  @override
  String get authUpdatePasswordButton => 'Update Password';

  @override
  String get authOtpCodeResent => 'A new code has been sent';

  @override
  String get authOtpDidNotReceive => 'Didn\'t receive the code?';

  @override
  String get authOtpResend => 'Resend';

  @override
  String authOtpSecondsRemaining(int seconds) {
    return '$seconds sec';
  }

  @override
  String get authOtpEmailVerificationTitle => 'Email Verification';

  @override
  String get authOtpPasswordResetTitle => 'Password Reset';

  @override
  String get authOtpAccountRestoreTitle => 'Account Recovery';

  @override
  String get authOtpEmailVerificationDescription =>
      'Enter the 6-digit code sent to your email';

  @override
  String get authOtpPasswordResetDescription =>
      'Enter the 6-digit code sent to your email to reset your password';

  @override
  String get authOtpAccountRestoreDescription =>
      'Enter the 6-digit code sent to your email to restore your account';

  @override
  String get authPhoneNumberLabel => 'Phone number';

  @override
  String get authRegistrationBack => 'Back';

  @override
  String authRegistrationStep(int current, int total) {
    return 'Registration $current / $total';
  }

  @override
  String get profileBirthdayRequired => 'Select your date of birth';

  @override
  String get profileGenderRequired => 'Select your gender';

  @override
  String get profileActivityLevelRequired => 'Select your activity level';

  @override
  String get profileGoalRequired => 'Select your goal';

  @override
  String get profileWeightHeightInvalid =>
      'Enter valid weight and height values';

  @override
  String get profilePersonalInfoTitle => 'Personal information';

  @override
  String get profilePersonalInfoDescription =>
      'Complete the basic information so we can get to know you better.';

  @override
  String get profileBodyMetricsTitle => 'Body metrics';

  @override
  String get profileBodyMetricsDescription =>
      'Your height and weight help us calculate your daily needs.';

  @override
  String get profileActivityLevelTitle => 'Activity level';

  @override
  String get profileActivityLevelDescription =>
      'Choose the physical activity level that best matches a typical day.';

  @override
  String get profileGoalTitle => 'Your goal';

  @override
  String get profileGoalDescription =>
      'SağlamQal will personalize your plan based on the goal you choose.';

  @override
  String get profileLastStep => 'Final step';

  @override
  String get profileCompleteTitle => 'Let\'s complete your profile';

  @override
  String get profileCompleteDescription =>
      'We need a few details to prepare a calorie and nutrition plan for you.';

  @override
  String get profileTargetWeightLabel => 'Target weight';

  @override
  String get profileOptional => 'Optional';

  @override
  String get profileTargetWeightHint => 'For example: 65';

  @override
  String get profileInvalidWeight => 'Enter a valid weight';

  @override
  String get profileWeightRangeError => 'Weight must be between 20 and 500 kg';

  @override
  String get profilePrivacyNote =>
      'Your information is used only to create a personalized plan for you.';

  @override
  String get profileCompleteButton => 'Complete profile';

  @override
  String get profileBirthdayLabel => 'Date of birth';

  @override
  String get profileBirthdaySelect => 'Select your date of birth';

  @override
  String profileBirthdayWithAge(String date, int age) {
    return '$date ($age years old)';
  }

  @override
  String get profileGenderLabel => 'Gender';

  @override
  String get profileGenderMale => 'Male';

  @override
  String get profileGenderFemale => 'Female';

  @override
  String get profileWeightLabel => 'Weight';

  @override
  String get profileHeightLabel => 'Height';

  @override
  String get unitKg => 'kg';

  @override
  String get unitCm => 'cm';

  @override
  String get activitySedentaryLabel => 'Sedentary';

  @override
  String get activitySedentaryDescription => 'Little to no physical activity';

  @override
  String get activityLightLabel => 'Lightly active';

  @override
  String get activityLightDescription => 'Light exercise 1-3 days a week';

  @override
  String get activityModerateLabel => 'Moderately active';

  @override
  String get activityModerateDescription => 'Moderate exercise 3-5 days a week';

  @override
  String get activityActiveLabel => 'Very active';

  @override
  String get activityActiveDescription => 'Intense exercise 6-7 days a week';

  @override
  String get activityVeryActiveLabel => 'Extremely active';

  @override
  String get activityVeryActiveDescription =>
      'Exercise twice a day or do heavy physical work';

  @override
  String get goalLoseWeightLabel => 'Lose weight';

  @override
  String get goalLoseWeightDescription =>
      'I want to lose weight with a calorie deficit';

  @override
  String get goalMaintainWeightLabel => 'Maintain weight';

  @override
  String get goalMaintainWeightDescription =>
      'I want to maintain my current weight';

  @override
  String get goalGainWeightLabel => 'Gain weight';

  @override
  String get goalGainWeightDescription =>
      'I want to gain weight with a calorie surplus';

  @override
  String get validationRequired => 'This field cannot be empty';

  @override
  String get validationPhoneRequired => 'Enter your phone number';

  @override
  String get validationPhoneDigitsOnly =>
      'Phone number must contain digits only';

  @override
  String get validationPhoneInvalid => 'Enter a valid phone number';

  @override
  String get homeGreetingMorning => 'Good morning';

  @override
  String get homeGreetingAfternoon => 'Good afternoon';

  @override
  String get homeGreetingEvening => 'Good evening';

  @override
  String get homeGuest => 'Guest';

  @override
  String get homeTodayStoryReady => 'Your story for today is ready to begin.';

  @override
  String get navHome => 'Home';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navProfile => 'My profile';

  @override
  String get homePhotoScanTitle => 'Take a photo,\nlearn the calories';

  @override
  String get homePhotoScanSubtitle => 'Learn the calories in seconds';

  @override
  String get homePhotoScanOpenCamera => 'Open camera';

  @override
  String get homeGuestPreviewTitle => 'A healthy life\nis in your hands.';

  @override
  String get homeGuestFeatureCalories => 'Daily calorie & macro tracking';

  @override
  String get homeGuestFeatureHydration => 'Water intake tracking';

  @override
  String get homeGuestFeatureHistory => 'History of scanned products';

  @override
  String get homeDailyRecommendation => 'Daily recommendation';

  @override
  String get macroProtein => 'Protein';

  @override
  String get macroCarbohydrate => 'Carbohydrates';

  @override
  String get macroFat => 'Fat';

  @override
  String get nutritionEnergyUpper => 'ENERGY';

  @override
  String get nutritionDurationUpper => 'DURATION';

  @override
  String get nutritionServingUpper => 'SERVING';

  @override
  String get nutritionProteinUpper => 'PROTEIN';

  @override
  String get nutritionCarbohydrateUpper => 'CARBOHYDRATES';

  @override
  String get nutritionCarbsShortUpper => 'CARBS';

  @override
  String get nutritionFatUpper => 'FAT';

  @override
  String get unitKcal => 'kcal';

  @override
  String get unitGram => 'g';

  @override
  String get unitMinuteShort => 'min';

  @override
  String get unitPerson => 'person';

  @override
  String get unitLiter => 'L';

  @override
  String get homeHydrationTitle => 'Hydration';

  @override
  String homeHydrationRecommendation(String value) {
    return 'Recommended: $value';
  }

  @override
  String get homeMealOfTheDayUpper => 'MEAL OF THE DAY';

  @override
  String get homeViewRecipe => 'View recipe';

  @override
  String get homeIngredients => 'Ingredients';

  @override
  String get homePreparationSteps => 'Preparation steps';

  @override
  String get homeRecentProductsTitle => 'Recently scanned';

  @override
  String get homeViewAll => 'View all';

  @override
  String homeRecentProductsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count products',
      one: '1 product',
    );
    return '$_temp0';
  }

  @override
  String get homeNoProductsScanned => 'No products have been\nscanned yet';

  @override
  String get homeScanProductsHint => 'Scan a barcode to add products';

  @override
  String get homeScanNow => 'Scan now';

  @override
  String get commonProduct => 'Product';

  @override
  String get commonVitamins => 'Vitamins';

  @override
  String commonTodayAt(String time) {
    return 'Today, $time';
  }

  @override
  String commonYesterdayAt(String time) {
    return 'Yesterday, $time';
  }

  @override
  String homeProductAddedFavorite(String product) {
    return '$product was added to favorites';
  }

  @override
  String homeProductRemovedFavorite(String product) {
    return '$product was removed from favorites';
  }

  @override
  String get homeBarcodeScanTitle => 'Scan Barcode';

  @override
  String get homeBarcodeScanSubtitle =>
      'Instantly check the product\'s calories';

  @override
  String get photoScanTitle => 'Search by photo';

  @override
  String get photoScanTipGoodLight => 'Good lighting';

  @override
  String get photoScanTipFitFrame => 'Fit in frame';

  @override
  String get photoScanTipKeepSteady => 'Hold steady';

  @override
  String get photoScanAnalyzingTitle => 'Analyzing product...';

  @override
  String get photoScanAnalyzingDuration => 'This usually takes 10-15 seconds';

  @override
  String get photoScanAnalyzingExtended =>
      'It\'s taking a little longer, please wait...';

  @override
  String get photoScanStepCapturedTitle => 'Photo captured successfully';

  @override
  String get photoScanStepCapturedSubtitle => 'Quality checked';

  @override
  String get photoScanStepAnalyzingTitle => 'Analyzing product';

  @override
  String get photoScanStepAnalyzingSubtitle => 'AI is analyzing the image';

  @override
  String get photoScanStepSearchingTitle => 'Searching for a matching product';

  @override
  String get photoScanStepSearchingSubtitle => 'Searching the database';

  @override
  String get photoScanStepPreparingTitle => 'Preparing result';

  @override
  String get photoScanStepPreparingSubtitle => 'Preparing information';

  @override
  String get photoScanStepCompleted => 'Completed';

  @override
  String get photoScanErrorTitle => 'An error occurred';

  @override
  String get photoScanNotFoodTitle => 'No food detected';

  @override
  String get photoScanNotFoodDescription =>
      'Please take a photo of something to eat or drink.';

  @override
  String photoScanNutritionValues(String amount, String unit) {
    return 'Nutrition values per $amount $unit';
  }

  @override
  String get photoScanCalories => 'Calories';

  @override
  String get photoScanAgain => 'Retake photo';

  @override
  String get unitMilligram => 'mg';

  @override
  String get networkTimeoutError =>
      'The connection timed out. Please check your internet connection.';

  @override
  String get networkServerError => 'A server error occurred.';

  @override
  String get networkNoConnectionError => 'No internet connection.';

  @override
  String get networkUnexpectedError => 'An unexpected error occurred.';
}
