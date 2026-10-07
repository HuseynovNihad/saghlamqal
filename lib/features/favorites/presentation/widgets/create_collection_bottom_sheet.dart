import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/l10n/localization_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../bloc/favorites_bloc.dart';
import '../../data/models/collection_icon_styles.dart';

class CreateCollectionBottomSheet extends StatefulWidget {
  const CreateCollectionBottomSheet({super.key});

  @override
  State<CreateCollectionBottomSheet> createState() =>
      _CreateCollectionBottomSheetState();
}

class _CreateCollectionBottomSheetState
    extends State<CreateCollectionBottomSheet> {
  final TextEditingController _nameController = TextEditingController();

  String? _selectedIconId;

  static const List<String> _iconIds = [
    'gym',
    'breakfast',
    'lunch',
    'dinner',
    'snack',
    'salad',
    'fruit',
    'drink',
    'diet',
    'protein',
    'vegan',
    'dessert',
  ];

  String _getIconLabel(BuildContext context, String id) {
    return switch (id) {
      'gym' => context.l10n.favoritesIconGym,
      'breakfast' => context.l10n.favoritesIconBreakfast,
      'lunch' => context.l10n.favoritesIconLunch,
      'dinner' => context.l10n.favoritesIconDinner,
      'snack' => context.l10n.favoritesIconSnack,
      'salad' => context.l10n.favoritesIconSalad,
      'fruit' => context.l10n.favoritesIconFruit,
      'drink' => context.l10n.favoritesIconDrink,
      'diet' => context.l10n.favoritesIconDiet,
      'protein' => context.l10n.favoritesIconProtein,
      'vegan' => context.l10n.favoritesIconVegan,
      'dessert' => context.l10n.favoritesIconDessert,
      _ => id,
    };
  }

  void _submit() {
    final name = _nameController.text.trim();

    if (name.isEmpty || _selectedIconId == null) {
      return;
    }

    context.read<FavoritesBloc>().add(
      CreateCollectionEvent(
        name: name,
        description: _selectedIconId!,
        icon: _selectedIconId!,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        top: 24,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: 4.br,
              ),
            ),
          ),

          20.hs,

          Text(
            context.l10n.favoritesCreateCollectionTitle,
            style: AppTextStyles.h2,
          ),

          16.hs,

          Row(
            children: [
              if (_selectedIconId != null) ...[
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: CollectionIconStyles.colors(_selectedIconId!),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: 14.br,
                  ),
                  child: Center(
                    child: Text(
                      CollectionIconStyles.emoji(_selectedIconId!),
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),

                12.ws,
              ],

              Expanded(
                child: TextField(
                  controller: _nameController,
                  onChanged: (_) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: context.l10n.favoritesCollectionNameHint,
                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: 12.br,
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: 12.br,
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),

          20.hs,

          Text(
            context.l10n.favoritesSelectIcon,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),

          12.hs,

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.9,
            ),
            itemCount: _iconIds.length,
            itemBuilder: (context, index) {
              final id = _iconIds[index];
              final isSelected = _selectedIconId == id;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIconId = id;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: CollectionIconStyles.colors(id),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: 14.br,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        CollectionIconStyles.emoji(id),
                        style: const TextStyle(fontSize: 22),
                      ),

                      4.hs,

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          _getIconLabel(context, id),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: CollectionIconStyles.textColor(id),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          20.hs,

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed:
                  _nameController.text.trim().isNotEmpty &&
                      _selectedIconId != null
                  ? _submit
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: Colors.grey.shade200,
                shape: RoundedRectangleBorder(borderRadius: 14.br),
                elevation: 0,
              ),
              child: Text(
                context.l10n.favoritesCreate,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
