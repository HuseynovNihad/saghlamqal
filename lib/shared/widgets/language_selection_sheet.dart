import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kalori_tracker/core/constants/app_colors.dart';
import 'package:kalori_tracker/core/l10n/localization_extension.dart';
import 'package:kalori_tracker/core/localization/app_language.dart';
import 'package:kalori_tracker/core/localization/locale_cubit.dart';

import '../../core/constants/app_text_styles.dart';
import '../../core/utils/asset_extension.dart';

Future<void> showLanguageSelectionSheet(BuildContext context) {
  final cubit = context.read<LocaleCubit>();

  return showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    backgroundColor: AppColors.surface,
    barrierColor: AppColors.headline.withValues(alpha: 0.35),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: const _LanguageSelectionSheet(),
    ),
  );
}

class _LanguageSelectionSheet extends StatefulWidget {
  const _LanguageSelectionSheet();

  @override
  State<_LanguageSelectionSheet> createState() =>
      _LanguageSelectionSheetState();
}

class _LanguageSelectionSheetState extends State<_LanguageSelectionSheet> {
  bool _isSaving = false;
  bool _hasError = false;

  Future<void> _selectLanguage(AppLanguage? language) async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
      _hasError = false;
    });

    try {
      await context.read<LocaleCubit>().changeLanguage(language);

      if (!mounted) return;

      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _isSaving = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.languageTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.headline,
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<LocaleCubit, AppLanguage?>(
              builder: (context, selectedLanguage) {
                return LanguagePicker(
                  selectedLanguage: selectedLanguage,
                  enabled: !_isSaving,
                  onChanged: _selectLanguage,
                );
              },
            ),
            if (_isSaving) ...[
              const SizedBox(height: 16),
              const Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
            if (_hasError) ...[
              const SizedBox(height: 16),
              Text(
                context.l10n.languageSaveError,
                style: const TextStyle(color: AppColors.error),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({
    super.key,
    required this.selectedLanguage,
    required this.onChanged,
    this.enabled = true,
  });

  final AppLanguage? selectedLanguage;
  final ValueChanged<AppLanguage?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _LanguageOptionTile(
          title: context.l10n.systemLanguage,
          selected: selectedLanguage == null,
          onTap: enabled ? () => onChanged(null) : null,
        ),
        const SizedBox(height: 8),
        for (final language in AppLanguage.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _LanguageOptionTile(
              title: language.nativeName,
              flagAsset: language.flagAsset,
              selected: selectedLanguage == language,
              onTap: enabled ? () => onChanged(language) : null,
            ),
          ),
      ],
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({
    required this.title,
    required this.selected,
    required this.onTap,
    this.flagAsset,
  });

  final String title;
  final String? flagAsset;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.primary.withValues(alpha: 0.12)
          : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.borderColor,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        enabled: onTap != null,
        selected: selected,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: SizedBox(
          width: 24,
          height: 16,
          child: Center(
            child: flagAsset != null
                ? flagAsset!.svg(width: 24, height: 16, fit: BoxFit.contain)
                : const Icon(
                    Icons.phone_iphone_rounded,
                    color: AppColors.bodyText,
                    size: 24,
                  ),
          ),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? AppColors.headline : AppColors.bodyText,
          ),
        ),
        trailing: Icon(
          selected
              ? Icons.check_circle_rounded
              : Icons.radio_button_unchecked_rounded,
          color: selected ? AppColors.primary : AppColors.borderColor,
        ),
        onTap: onTap,
      ),
    );
  }
}
