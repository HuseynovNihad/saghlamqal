import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../favorites/presentation/bloc/favorites_bloc.dart';
import '../../data/models/collection_icon_styles.dart';

class CreateCollectionBottomSheet extends StatefulWidget {
  const CreateCollectionBottomSheet({super.key});

  @override
  State<CreateCollectionBottomSheet> createState() =>
      _CreateCollectionBottomSheetState();
}

class _CreateCollectionBottomSheetState
    extends State<CreateCollectionBottomSheet> {
  final _nameController = TextEditingController();
  String? _selectedIconId;

  final List<Map<String, String>> _icons = const [
    {'id': 'gym', 'label': 'İdman'},
    {'id': 'breakfast', 'label': 'Səhər yeməyi'},
    {'id': 'lunch', 'label': 'Nahar'},
    {'id': 'dinner', 'label': 'Axşam yeməyi'},
    {'id': 'snack', 'label': 'Snack'},
    {'id': 'salad', 'label': 'Salat'},
    {'id': 'fruit', 'label': 'Meyvə'},
    {'id': 'drink', 'label': 'İçki'},
    {'id': 'diet', 'label': 'Diyet'},
    {'id': 'protein', 'label': 'Protein'},
    {'id': 'vegan', 'label': 'Vegan'},
    {'id': 'dessert', 'label': 'Desert'},
  ];

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty || _selectedIconId == null) return;

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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
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
          Text('Yeni kolleksiya', style: AppTextStyles.h2),
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
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Kolleksiya adı...',
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
            'İkon seç',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          12.hs,

          // İkon grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.9,
            ),
            itemCount: _icons.length,
            itemBuilder: (context, index) {
              final icon = _icons[index];
              final id = icon['id']!;
              final isSelected = _selectedIconId == id;

              return GestureDetector(
                onTap: () => setState(() => _selectedIconId = id),
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
                      Text(
                        icon['label']!,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: CollectionIconStyles.textColor(id),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                'Yarat',
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
