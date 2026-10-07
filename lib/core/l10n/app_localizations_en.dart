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

  @override
  String get favoritesGuestTitle => 'Save your\nhealthy choices';

  @override
  String get favoritesGuestSubtitle =>
      'Save scanned products and\ntrack their calories and nutrition.';

  @override
  String get favoritesGuestFeatureSaveProducts => 'Save products';

  @override
  String get favoritesGuestFeatureCreateCollections => 'Create collections';

  @override
  String get favoritesGuestFeatureFindAnytime => 'Find anytime';

  @override
  String get favoritesSearchHint => 'Search...';

  @override
  String get favoritesSavedProducts => 'Saved products';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String favoritesSavedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count products saved',
      one: '1 product saved',
      zero: 'No products saved',
    );
    return '$_temp0';
  }

  @override
  String get favoritesEmptyTitle => 'Nothing saved yet';

  @override
  String get favoritesEmptySubtitle =>
      'Scan products and add them to your favorites';

  @override
  String get favoritesRetry => 'Try again';

  @override
  String get favoritesCreateCollectionTitle => 'New collection';

  @override
  String get favoritesCollectionNameHint => 'Collection name...';

  @override
  String get favoritesSelectIcon => 'Select icon';

  @override
  String get favoritesCreate => 'Create';

  @override
  String get favoritesNew => 'New';

  @override
  String get favoritesIconGym => 'Gym';

  @override
  String get favoritesIconBreakfast => 'Breakfast';

  @override
  String get favoritesIconLunch => 'Lunch';

  @override
  String get favoritesIconDinner => 'Dinner';

  @override
  String get favoritesIconSnack => 'Snack';

  @override
  String get favoritesIconSalad => 'Salad';

  @override
  String get favoritesIconFruit => 'Fruit';

  @override
  String get favoritesIconDrink => 'Drink';

  @override
  String get favoritesIconDiet => 'Diet';

  @override
  String get favoritesIconProtein => 'Protein';

  @override
  String get favoritesIconVegan => 'Vegan';

  @override
  String get favoritesIconDessert => 'Dessert';

  @override
  String favoritesCollectionItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count products',
      one: '1 product',
      zero: '0 products',
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
    return '$value g C';
  }

  @override
  String get onboardingFirstTitle => 'Your first step';

  @override
  String get onboardingFirstHighlight => 'toward better health';

  @override
  String get onboardingFirstSubtitle =>
      'With SağlamQal, know what you eat every day, track it, and make better choices. Point the camera and we’ll do the rest.';

  @override
  String get onboardingSecondTitle => 'Take a photo';

  @override
  String get onboardingSecondHighlight => 'learn everything';

  @override
  String get onboardingSecondSubtitle =>
      'Take a photo and let AI show the calories and nutritional values in seconds.';

  @override
  String get onboardingThirdTitle => 'Stay hydrated';

  @override
  String get onboardingThirdHighlight => 'we’ll remind you';

  @override
  String get onboardingThirdSubtitle =>
      'Track your water intake throughout the day. SağlamQal will remind you when it’s time to drink.';

  @override
  String get onboardingFourthTitle => 'Save your favorites';

  @override
  String get onboardingFourthHighlight => 'view your history';

  @override
  String get onboardingFourthSubtitle =>
      'Add the products you like to your favorites. Your entire scan history stays in one place.';

  @override
  String get onboardingFifthTitle => 'What should we';

  @override
  String get onboardingFifthHighlight => 'cook today?';

  @override
  String get onboardingFifthSubtitle =>
      'Discover new healthy recipes every day, from ingredients to step-by-step instructions.';

  @override
  String get onboardingStart => 'Get started';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get onboardingLetsStart => 'Let’s start';

  @override
  String get onboardingSkip => 'Skip →';

  @override
  String get waterReminderTitle => 'Water reminder';

  @override
  String get waterReminderUpcoming => 'Upcoming water reminder';

  @override
  String get waterReminderDisabled => 'Water reminder is turned off';

  @override
  String waterReminderNextTime(String time) {
    return 'Next reminder: $time';
  }

  @override
  String get waterReminderPermissionDenied =>
      'Notification permission was denied. Enable it in Settings.';

  @override
  String get waterReminderChannelName => 'Water reminders';

  @override
  String get waterReminderChannelDescription =>
      'Reminds you to drink water throughout the day';

  @override
  String get waterReminderNotificationMorningStart =>
      '🌅 Start your day with water!';

  @override
  String get waterReminderNotificationMorning => '☀️ Had your morning water?';

  @override
  String get waterReminderNotificationBeforeLunch =>
      '💧 Time for water before lunch!';

  @override
  String get waterReminderNotificationAfterLunch =>
      '🥗 Drink some water after lunch!';

  @override
  String get waterReminderNotificationEnergy =>
      '⚡ Drink water for an energy boost!';

  @override
  String get waterReminderNotificationAfternoon =>
      '🌿 Time for some afternoon water!';

  @override
  String get waterReminderNotificationBeforeDinner =>
      '🍽️ Have some water before dinner!';

  @override
  String get waterReminderNotificationLastGlass =>
      '🌙 Time for your last glass of the day!';

  @override
  String get waterReminderNotificationDefault => '💧 Time to drink some water!';

  @override
  String get waterReminderMessageOne =>
      'Drink a glass of water and feel refreshed! 🌊';

  @override
  String get waterReminderMessageTwo =>
      'Dehydration can make you feel tired. Time for water! 💪';

  @override
  String get waterReminderMessageThree =>
      'Have a glass of water to stay healthy! ✨';

  @override
  String get waterReminderMessageFour =>
      'Your body needs water. Take care of yourself! 💧';

  @override
  String get waterReminderMessageFive =>
      'Take a breath and drink a glass of water! 🌿';

  @override
  String get waterReminderMessageSix =>
      'Don\'t forget to drink water this afternoon! 💦';

  @override
  String get waterReminderMessageSeven =>
      'Have a glass of water before lunch! 🥗';

  @override
  String get waterReminderMessageEight =>
      'Don\'t forget to drink water before dinner! 🍽️';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileGuestTitle => 'Sign in to\nyour profile';

  @override
  String get profileGuestSubtitle =>
      'Manage your profile information and\npersonalize your settings.';

  @override
  String get profileGuestFeatureEdit => 'Edit profile information';

  @override
  String get profileGuestFeatureSettings => 'Manage settings';

  @override
  String get profileGuestFeaturePrivacy => 'Manage privacy and security';

  @override
  String get profileSectionAccountSettings => 'Account & Settings';

  @override
  String get profileSectionNotifications => 'Notifications';

  @override
  String get profileSectionSupport => 'Support';

  @override
  String get profileEditMenu => 'Edit profile';

  @override
  String get profilePatientCodeMenu => 'My patient code';

  @override
  String get privacyPolicyTitle => 'Privacy Policy';

  @override
  String get termsOfServiceTitle => 'Terms of Service';

  @override
  String get aboutUsTitle => 'About Us';

  @override
  String get profileLogout => 'Log out';

  @override
  String get profileLogoutTitle => 'Log out';

  @override
  String get profileLogoutMessage =>
      'Are you sure you want to log out of your account?';

  @override
  String get profileDeleteAccount => 'Delete account';

  @override
  String get profileDeleteAccountMessage =>
      'Your account will be deactivated. You can reactivate it at any time.';

  @override
  String get profileDeleteConfirm => 'Delete';

  @override
  String get profileLoadFailed => 'Failed to load information';

  @override
  String get profileLoadErrorDescription =>
      'Check your internet connection and try again.';

  @override
  String get profileRetry => 'Try again';

  @override
  String get patientCodeTitle => 'My patient code';

  @override
  String get patientCodeCopied => 'Patient code copied';

  @override
  String patientCodeShareText(String patientCode) {
    return 'My SağlamQal patient code: $patientCode';
  }

  @override
  String get patientCodeShareSubject => 'SağlamQal patient code';

  @override
  String get patientCodeCopy => 'Copy code';

  @override
  String get patientCodeShare => 'Share';

  @override
  String get patientCodeHeaderTitle =>
      'Your dietitian can find you with this code';

  @override
  String get patientCodeHeaderDescription =>
      'Share the code below with your dietitian. They can use it to find you and invite you as a patient.';

  @override
  String get patientCodeLabel => 'Patient code';

  @override
  String get patientCodePrivacyNote =>
      'Only share your code with the dietitian you want to connect with.';

  @override
  String get patientCodeNotFoundTitle => 'Patient code not found';

  @override
  String get patientCodeNotFoundDescription =>
      'There is currently no patient code available for your account.';

  @override
  String get profileEditTitle => 'Edit profile';

  @override
  String get profileImageCaptureError =>
      'An error occurred while taking the photo';

  @override
  String get profileImageSelectionError =>
      'An error occurred while selecting the photo';

  @override
  String get profileNoChanges => 'No changes to save';

  @override
  String get profileAvatarUpdated => 'Profile photo updated';

  @override
  String get profileAvatarDeleted => 'Profile photo deleted';

  @override
  String get profileSaved => 'Profile saved';

  @override
  String get aboutUsEmail => 'Email';

  @override
  String get aboutUsWebsite => 'Website';

  @override
  String aboutUsInvalidLink(String url) {
    return 'Invalid link: $url';
  }

  @override
  String aboutUsLinkOpenFailed(String url) {
    return 'Could not open link: $url';
  }

  @override
  String aboutUsLinkError(String error) {
    return 'An error occurred: $error';
  }

  @override
  String get profileEditPersonalInfo => 'Personal information';

  @override
  String get profileEditFirstName => 'First name';

  @override
  String get profileEditFirstNameHint => 'Enter your first name';

  @override
  String get profileEditLastName => 'Last name';

  @override
  String get profileEditLastNameHint => 'Enter your last name';

  @override
  String get profileEditEmail => 'Email';

  @override
  String get profileEditPhone => 'Phone number';

  @override
  String get profileEditBirthday => 'Date of birth';

  @override
  String get profileEditBirthdayHint => 'Select your date of birth';

  @override
  String get profileEditPhysicalInfo => 'Body metrics';

  @override
  String get profileEditHeight => 'Height';

  @override
  String get profileEditCurrentWeight => 'Current weight';

  @override
  String get profileEditTargetWeight => 'Target weight';

  @override
  String get profileEditUnitCm => 'cm';

  @override
  String get profileEditUnitKg => 'kg';

  @override
  String get profileEditProgressMessage =>
      'Great progress! You\'re on the right track.';

  @override
  String get profileEditPreferences => 'Preferences';

  @override
  String get profileEditGender => 'Gender';

  @override
  String get profileEditActivityLevel => 'Activity level';

  @override
  String get profileEditGoal => 'Your goal';

  @override
  String get profileEditConsistencyHint =>
      'Consistency matters. Small steps lead to big changes!';

  @override
  String get profileActivitySedentary => 'Sedentary';

  @override
  String get profileActivityLight => 'Lightly active';

  @override
  String get profileActivityModerate => 'Moderately active';

  @override
  String get profileActivityActive => 'Active';

  @override
  String get profileActivityVeryActive => 'Very active';

  @override
  String get profileGoalLoseWeight => 'Lose weight';

  @override
  String get profileGoalMaintainWeight => 'Maintain weight';

  @override
  String get profileGoalGainWeight => 'Gain weight';

  @override
  String get profileAvatarChangeTitle => 'Change profile photo';

  @override
  String get profileAvatarChangeSubtitle =>
      'Take a new photo or choose from your gallery';

  @override
  String get profileAvatarCamera => 'Camera';

  @override
  String get profileAvatarCameraSubtitle => 'Take a new photo';

  @override
  String get profileAvatarGallery => 'Gallery';

  @override
  String get profileAvatarGallerySubtitle => 'Choose a photo';

  @override
  String get profileAvatarDelete => 'Delete profile photo';

  @override
  String get profileAvatarCropTitle => 'Choose profile photo';

  @override
  String get profileAvatarCropArea => 'Area visible in your profile photo';

  @override
  String get profileAvatarCropMoveHint => 'Move and zoom the photo';

  @override
  String get profileAvatarCropDone => 'Done';

  @override
  String get profileAvatarCropError =>
      'An error occurred while cropping the photo';

  @override
  String get profileAvatarImageOpenError => 'Could not open the photo';

  @override
  String get profileAvatarImageOpenErrorDescription =>
      'Choose another photo and try again.';

  @override
  String get profileEditSaveChanges => 'Save changes';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonRetry => 'Try again';

  @override
  String get commonGoBack => 'Go back';

  @override
  String get commonLogin => 'Log in';

  @override
  String get commonRegister => 'Sign up';

  @override
  String get datePickerBirthDate => 'Date of birth';

  @override
  String get refreshRefreshing => 'Refreshing...';

  @override
  String get refreshUpdated => 'Updated';

  @override
  String get rulerTapValueToEdit => 'Tap the number to edit';

  @override
  String get rulerManualInput => 'Enter number manually';

  @override
  String get errorPageNotFoundTitle => 'Page not found';

  @override
  String get errorPageNotFoundSubtitle =>
      'The page you are looking for does not exist or has been removed.';

  @override
  String get errorPageNetworkTitle => 'Connection error';

  @override
  String get errorPageNetworkSubtitle =>
      'Check your internet connection and try again.';

  @override
  String get errorPageServerTitle => 'Server error';

  @override
  String get errorPageServerSubtitle =>
      'There is a problem with the server. Please try again later.';

  @override
  String get errorPageUnknownTitle => 'Something went wrong';

  @override
  String get errorPageUnknownSubtitle =>
      'An unexpected error occurred. Please try again.';
}
