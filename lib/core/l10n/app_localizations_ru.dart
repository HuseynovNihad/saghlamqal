// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get languageTitle => 'Выбор языка';

  @override
  String get systemLanguage => 'Язык системы';

  @override
  String get continueButton => 'Продолжить';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get languageSaveError =>
      'Не удалось сохранить язык. Попробуйте ещё раз';

  @override
  String get authGenericError => 'Произошла ошибка. Попробуйте ещё раз';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authEmailHint => 'Введите ваш email';

  @override
  String get authEmailExample => 'example@email.com';

  @override
  String get authEmailRequired => 'Введите email';

  @override
  String get authEmailInvalid => 'Введите корректный email';

  @override
  String get authPasswordLabel => 'Пароль';

  @override
  String get authPasswordHint => 'Введите пароль';

  @override
  String get authPasswordRequired => 'Введите пароль';

  @override
  String get authPasswordMinLength =>
      'Пароль должен содержать не менее 6 символов';

  @override
  String get authConfirmPasswordLabel => 'Подтвердите пароль';

  @override
  String get authConfirmPasswordHint => 'Введите пароль ещё раз';

  @override
  String get authConfirmPasswordRequired => 'Подтвердите пароль';

  @override
  String get authPasswordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get authLoginTitle => 'Войти';

  @override
  String get authLoginButton => 'Войти';

  @override
  String get authForgotPasswordLink => 'Забыли пароль?';

  @override
  String get authOr => 'или';

  @override
  String get authContinueWithGoogle => 'Продолжить с Google';

  @override
  String get authNoAccount => 'Нет аккаунта?';

  @override
  String get authRegisterLink => 'Регистрация';

  @override
  String get authHaveAccount => 'Уже есть аккаунт?';

  @override
  String get authRegisterButton => 'Зарегистрироваться';

  @override
  String get authFirstNameLabel => 'Имя';

  @override
  String get authFirstNameHint => 'Введите имя';

  @override
  String get authLastNameLabel => 'Фамилия';

  @override
  String get authLastNameHint => 'Введите фамилию';

  @override
  String get authGoogleIdTokenMissing =>
      'Не удалось получить Google ID token. Попробуйте ещё раз.';

  @override
  String get authGoogleLoginFailed =>
      'Не удалось войти через Google. Попробуйте ещё раз.';

  @override
  String get authGoogleLoginError => 'Произошла ошибка при входе через Google.';

  @override
  String get authGoogleCredentialsMissing =>
      'Не удалось получить данные для входа через Google';

  @override
  String get authAccountDeactivatedTitle => 'Аккаунт деактивирован';

  @override
  String get authAccountDeactivatedMessage =>
      'Ваш аккаунт деактивирован. Для повторной активации на ваш email будет отправлен код подтверждения.';

  @override
  String get authReactivateButton => 'Активировать';

  @override
  String get authPasswordNotSetTitle => 'Пароль не установлен';

  @override
  String get authPasswordNotSetMessage =>
      'Этот аккаунт создан через Google. Установите пароль, чтобы входить с помощью email и пароля.';

  @override
  String get authSetPasswordButton => 'Установить пароль';

  @override
  String get authForgotPasswordTitle => 'Забыли пароль';

  @override
  String get authForgotPasswordDescription =>
      'Введите адрес электронной почты, и мы отправим код для сброса пароля';

  @override
  String get authPasswordResetCodeSent => 'Код для сброса пароля отправлен';

  @override
  String get authSendCodeButton => 'Отправить код';

  @override
  String get authBackButton => 'Назад';

  @override
  String get authNewPasswordTitle => 'Новый пароль';

  @override
  String get authNewPasswordDescription => 'Введите новый пароль';

  @override
  String get authNewPasswordLabel => 'Новый пароль';

  @override
  String get authPasswordResetSuccess => 'Пароль успешно обновлён';

  @override
  String get authUpdatePasswordButton => 'Обновить пароль';

  @override
  String get authOtpCodeResent => 'Новый код отправлен';

  @override
  String get authOtpDidNotReceive => 'Не получили код?';

  @override
  String get authOtpResend => 'Отправить снова';

  @override
  String authOtpSecondsRemaining(int seconds) {
    return '$seconds сек';
  }

  @override
  String get authOtpEmailVerificationTitle => 'Подтверждение email';

  @override
  String get authOtpPasswordResetTitle => 'Сброс пароля';

  @override
  String get authOtpAccountRestoreTitle => 'Восстановление аккаунта';

  @override
  String get authOtpEmailVerificationDescription =>
      'Введите 6-значный код, отправленный на ваш email';

  @override
  String get authOtpPasswordResetDescription =>
      'Введите 6-значный код, отправленный на ваш email, чтобы сбросить пароль';

  @override
  String get authOtpAccountRestoreDescription =>
      'Введите 6-значный код, отправленный на ваш email, чтобы восстановить аккаунт';

  @override
  String get authPhoneNumberLabel => 'Номер телефона';

  @override
  String get authRegistrationBack => 'Назад';

  @override
  String authRegistrationStep(int current, int total) {
    return 'Регистрация $current / $total';
  }

  @override
  String get profileBirthdayRequired => 'Выберите дату рождения';

  @override
  String get profileGenderRequired => 'Выберите пол';

  @override
  String get profileActivityLevelRequired => 'Выберите уровень активности';

  @override
  String get profileGoalRequired => 'Выберите цель';

  @override
  String get profileWeightHeightInvalid =>
      'Введите корректные значения веса и роста';

  @override
  String get profilePersonalInfoTitle => 'Личная информация';

  @override
  String get profilePersonalInfoDescription =>
      'Заполните основную информацию, чтобы мы могли лучше вас узнать.';

  @override
  String get profileBodyMetricsTitle => 'Показатели тела';

  @override
  String get profileBodyMetricsDescription =>
      'Данные о росте и весе помогают рассчитать ваши ежедневные потребности.';

  @override
  String get profileActivityLevelTitle => 'Уровень активности';

  @override
  String get profileActivityLevelDescription =>
      'Выберите уровень физической активности, который лучше всего соответствует вашему обычному дню.';

  @override
  String get profileGoalTitle => 'Ваша цель';

  @override
  String get profileGoalDescription =>
      'SağlamQal персонализирует план в соответствии с выбранной вами целью.';

  @override
  String get profileLastStep => 'Последний шаг';

  @override
  String get profileCompleteTitle => 'Завершим ваш профиль';

  @override
  String get profileCompleteDescription =>
      'Нам нужно несколько данных, чтобы подготовить для вас план калорийности и питания.';

  @override
  String get profileTargetWeightLabel => 'Целевой вес';

  @override
  String get profileOptional => 'Необязательно';

  @override
  String get profileTargetWeightHint => 'Например: 65';

  @override
  String get profileInvalidWeight => 'Введите корректный вес';

  @override
  String get profileWeightRangeError => 'Вес должен быть в диапазоне 20–500 кг';

  @override
  String get profilePrivacyNote =>
      'Ваши данные используются только для создания персонального плана.';

  @override
  String get profileCompleteButton => 'Завершить профиль';

  @override
  String get profileBirthdayLabel => 'Дата рождения';

  @override
  String get profileBirthdaySelect => 'Выберите дату рождения';

  @override
  String profileBirthdayWithAge(String date, int age) {
    return '$date ($age лет)';
  }

  @override
  String get profileGenderLabel => 'Пол';

  @override
  String get profileGenderMale => 'Мужчина';

  @override
  String get profileGenderFemale => 'Женщина';

  @override
  String get profileWeightLabel => 'Вес';

  @override
  String get profileHeightLabel => 'Рост';

  @override
  String get unitKg => 'кг';

  @override
  String get unitCm => 'см';

  @override
  String get activitySedentaryLabel => 'Малоподвижный';

  @override
  String get activitySedentaryDescription =>
      'Практически нет физической активности';

  @override
  String get activityLightLabel => 'Низкая активность';

  @override
  String get activityLightDescription => 'Лёгкие тренировки 1–3 дня в неделю';

  @override
  String get activityModerateLabel => 'Средняя активность';

  @override
  String get activityModerateDescription =>
      'Умеренные тренировки 3–5 дней в неделю';

  @override
  String get activityActiveLabel => 'Высокая активность';

  @override
  String get activityActiveDescription =>
      'Интенсивные тренировки 6–7 дней в неделю';

  @override
  String get activityVeryActiveLabel => 'Очень высокая активность';

  @override
  String get activityVeryActiveDescription =>
      'Тренировки два раза в день или тяжёлая физическая работа';

  @override
  String get goalLoseWeightLabel => 'Снизить вес';

  @override
  String get goalLoseWeightDescription =>
      'Хочу похудеть с помощью дефицита калорий';

  @override
  String get goalMaintainWeightLabel => 'Сохранить вес';

  @override
  String get goalMaintainWeightDescription => 'Хочу сохранить текущий вес';

  @override
  String get goalGainWeightLabel => 'Набрать вес';

  @override
  String get goalGainWeightDescription =>
      'Хочу набрать вес с помощью профицита калорий';

  @override
  String get validationRequired => 'Это поле не может быть пустым';

  @override
  String get validationPhoneRequired => 'Введите номер телефона';

  @override
  String get validationPhoneDigitsOnly =>
      'Номер телефона должен содержать только цифры';

  @override
  String get validationPhoneInvalid => 'Введите корректный номер телефона';

  @override
  String get homeGreetingMorning => 'Доброе утро';

  @override
  String get homeGreetingAfternoon => 'Добрый день';

  @override
  String get homeGreetingEvening => 'Добрый вечер';

  @override
  String get homeGuest => 'Гость';

  @override
  String get homeTodayStoryReady => 'Ваша сегодняшняя история готова начаться.';

  @override
  String get navHome => 'Главная';

  @override
  String get navFavorites => 'Избранное';

  @override
  String get navProfile => 'Мой профиль';

  @override
  String get homePhotoScanTitle => 'Сделайте фото,\nузнайте калорийность';

  @override
  String get homePhotoScanSubtitle =>
      'Узнайте калорийность за несколько секунд';

  @override
  String get homePhotoScanOpenCamera => 'Открыть камеру';

  @override
  String get homeGuestPreviewTitle => 'Здоровая жизнь\nв ваших руках.';

  @override
  String get homeGuestFeatureCalories =>
      'Ежедневный учёт калорий и макронутриентов';

  @override
  String get homeGuestFeatureHydration => 'Контроль потребления воды';

  @override
  String get homeGuestFeatureHistory => 'История отсканированных продуктов';

  @override
  String get homeDailyRecommendation => 'Дневная рекомендация';

  @override
  String get macroProtein => 'Белок';

  @override
  String get macroCarbohydrate => 'Углеводы';

  @override
  String get macroFat => 'Жиры';

  @override
  String get nutritionEnergyUpper => 'ЭНЕРГИЯ';

  @override
  String get nutritionDurationUpper => 'ВРЕМЯ';

  @override
  String get nutritionServingUpper => 'ПОРЦИЯ';

  @override
  String get nutritionProteinUpper => 'БЕЛОК';

  @override
  String get nutritionCarbohydrateUpper => 'УГЛЕВОДЫ';

  @override
  String get nutritionCarbsShortUpper => 'УГЛ.';

  @override
  String get nutritionFatUpper => 'ЖИРЫ';

  @override
  String get unitKcal => 'ккал';

  @override
  String get unitGram => 'г';

  @override
  String get unitMinuteShort => 'мин';

  @override
  String get unitPerson => 'чел.';

  @override
  String get unitLiter => 'л';

  @override
  String get homeHydrationTitle => 'Гидратация';

  @override
  String homeHydrationRecommendation(String value) {
    return 'Рекомендуется: $value';
  }

  @override
  String get homeMealOfTheDayUpper => 'БЛЮДО ДНЯ';

  @override
  String get homeViewRecipe => 'Смотреть рецепт';

  @override
  String get homeIngredients => 'Ингредиенты';

  @override
  String get homePreparationSteps => 'Этапы приготовления';

  @override
  String get homeRecentProductsTitle => 'Недавно отсканированные';

  @override
  String get homeViewAll => 'Посмотреть все';

  @override
  String homeRecentProductsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count товара',
      many: '$count товаров',
      few: '$count товара',
      one: '$count товар',
    );
    return '$_temp0';
  }

  @override
  String get homeNoProductsScanned => 'Пока ни один продукт\nне отсканирован';

  @override
  String get homeScanProductsHint =>
      'Отсканируйте штрихкод, чтобы добавить продукт';

  @override
  String get homeScanNow => 'Сканировать';

  @override
  String get commonProduct => 'Продукт';

  @override
  String get commonVitamins => 'Витамины';

  @override
  String commonTodayAt(String time) {
    return 'Сегодня, $time';
  }

  @override
  String commonYesterdayAt(String time) {
    return 'Вчера, $time';
  }

  @override
  String homeProductAddedFavorite(String product) {
    return '$product добавлен в избранное';
  }

  @override
  String homeProductRemovedFavorite(String product) {
    return '$product удалён из избранного';
  }

  @override
  String get homeBarcodeScanTitle => 'Сканировать штрихкод';

  @override
  String get homeBarcodeScanSubtitle =>
      'Мгновенно узнайте калорийность продукта';

  @override
  String get photoScanTitle => 'Поиск по фото';

  @override
  String get photoScanTipGoodLight => 'Хорошее освещение';

  @override
  String get photoScanTipFitFrame => 'Поместите в кадр';

  @override
  String get photoScanTipKeepSteady => 'Держите неподвижно';

  @override
  String get photoScanAnalyzingTitle => 'Анализ продукта...';

  @override
  String get photoScanAnalyzingDuration => 'Обычно это занимает 10–15 секунд';

  @override
  String get photoScanAnalyzingExtended =>
      'Это занимает немного больше времени, пожалуйста, подождите...';

  @override
  String get photoScanStepCapturedTitle => 'Фото успешно сделано';

  @override
  String get photoScanStepCapturedSubtitle => 'Качество проверено';

  @override
  String get photoScanStepAnalyzingTitle => 'Анализ продукта';

  @override
  String get photoScanStepAnalyzingSubtitle => 'ИИ анализирует изображение';

  @override
  String get photoScanStepSearchingTitle => 'Поиск подходящего продукта';

  @override
  String get photoScanStepSearchingSubtitle => 'Поиск в базе данных';

  @override
  String get photoScanStepPreparingTitle => 'Подготовка результата';

  @override
  String get photoScanStepPreparingSubtitle => 'Подготовка информации';

  @override
  String get photoScanStepCompleted => 'Завершено';

  @override
  String get photoScanErrorTitle => 'Произошла ошибка';

  @override
  String get photoScanNotFoodTitle => 'Еда не обнаружена';

  @override
  String get photoScanNotFoodDescription =>
      'Пожалуйста, сфотографируйте еду или напиток.';

  @override
  String photoScanNutritionValues(String amount, String unit) {
    return 'Пищевая ценность на $amount $unit';
  }

  @override
  String get photoScanCalories => 'Калории';

  @override
  String get photoScanAgain => 'Сделать фото снова';

  @override
  String get unitMilligram => 'мг';

  @override
  String get networkTimeoutError =>
      'Время ожидания соединения истекло. Проверьте подключение к интернету.';

  @override
  String get networkServerError => 'Произошла ошибка сервера.';

  @override
  String get networkNoConnectionError => 'Нет подключения к интернету.';

  @override
  String get networkUnexpectedError => 'Произошла непредвиденная ошибка.';

  @override
  String get favoritesGuestTitle => 'Сохраняйте свои\nполезные выборы';

  @override
  String get favoritesGuestSubtitle =>
      'Сохраняйте отсканированные продукты\nи следите за калориями и составом.';

  @override
  String get favoritesGuestFeatureSaveProducts => 'Сохраняйте продукты';

  @override
  String get favoritesGuestFeatureCreateCollections => 'Создавайте коллекции';

  @override
  String get favoritesGuestFeatureFindAnytime => 'Находите в любое время';

  @override
  String get favoritesSearchHint => 'Поиск...';

  @override
  String get favoritesSavedProducts => 'Сохранённые продукты';

  @override
  String get favoritesTitle => 'Избранное';

  @override
  String favoritesSavedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count продукта сохранено',
      many: '$count продуктов сохранено',
      few: '$count продукта сохранено',
      one: '$count продукт сохранён',
      zero: 'Нет сохранённых продуктов',
    );
    return '$_temp0';
  }

  @override
  String get favoritesEmptyTitle => 'Пока ничего не сохранено';

  @override
  String get favoritesEmptySubtitle =>
      'Сканируйте продукты и добавляйте их в избранное';

  @override
  String get favoritesRetry => 'Попробовать снова';

  @override
  String get favoritesCreateCollectionTitle => 'Новая коллекция';

  @override
  String get favoritesCollectionNameHint => 'Название коллекции...';

  @override
  String get favoritesSelectIcon => 'Выберите значок';

  @override
  String get favoritesCreate => 'Создать';

  @override
  String get favoritesNew => 'Новая';

  @override
  String get favoritesIconGym => 'Спорт';

  @override
  String get favoritesIconBreakfast => 'Завтрак';

  @override
  String get favoritesIconLunch => 'Обед';

  @override
  String get favoritesIconDinner => 'Ужин';

  @override
  String get favoritesIconSnack => 'Перекус';

  @override
  String get favoritesIconSalad => 'Салат';

  @override
  String get favoritesIconFruit => 'Фрукты';

  @override
  String get favoritesIconDrink => 'Напитки';

  @override
  String get favoritesIconDiet => 'Диета';

  @override
  String get favoritesIconProtein => 'Белок';

  @override
  String get favoritesIconVegan => 'Веган';

  @override
  String get favoritesIconDessert => 'Десерт';

  @override
  String favoritesCollectionItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count продукта',
      many: '$count продуктов',
      few: '$count продукта',
      one: '$count продукт',
      zero: '0 продуктов',
    );
    return '$_temp0';
  }

  @override
  String favoritesCaloriesValue(int value) {
    return '$value ккал';
  }

  @override
  String favoritesProteinValue(int value) {
    return '$value г Б';
  }

  @override
  String favoritesCarbsValue(int value) {
    return '$value г У';
  }
}
