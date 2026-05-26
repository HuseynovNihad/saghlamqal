import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/asset_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../cubit/water_reminder_cubit.dart';
import '../cubit/water_reminder_state.dart';

class WaterReminderTile extends StatelessWidget {
  final bool isLast;

  const WaterReminderTile({super.key, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<WaterReminderCubit>(),
      child: _Tile(isLast: isLast),
    );
  }
}

class _Tile extends StatelessWidget {
  final bool isLast;

  const _Tile({required this.isLast});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WaterReminderCubit, WaterReminderState>(
      listener: (context, state) {
        if (state.permissionDenied) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Bildiriş icazəsi verilmədi. Ayarlardan aktiv edin.',
              ),
              backgroundColor: Colors.red.shade400,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: 12.br,
                    ),
                    child: Center(
                      child: AppAssets.hydrationPrimary.svg(
                        width: 16,
                        height: 16,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ),
                  12.ws,
                  Expanded(
                    child: Text(
                      'Su xatırlatması',
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch.adaptive(
                      value: state.isEnabled,
                      onChanged: (v) =>
                          context.read<WaterReminderCubit>().toggle(v),
                      activeColor: AppColors.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
            ),
            if (!isLast) const Divider(height: 1, color: Color(0xFFF3F3F3)),
          ],
        );
      },
    );
  }
}
