import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/asset_extension.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../cubit/water_reminder_cubit.dart';
import '../cubit/water_reminder_state.dart';

class WaterReminderCard extends StatelessWidget {
  const WaterReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<WaterReminderCubit>(),
      child: const _Card(),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterReminderCubit, WaterReminderState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: 16.br,
            border: Border.all(color: AppColors.borderColor, width: 0.8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: 10.p,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EEFF),
                  borderRadius: 14.br,
                ),
                child: AppAssets.hydration.svg(
                  width: 22,
                  height: 22,
                  color: const Color(0xFF4A6CF7),
                ),
              ),
              14.ws,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.isEnabled
                          ? 'Gələcək su xatırlatması'
                          : 'Su xatırlatması aktiv deyildir',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                    if (state.isEnabled) ...[
                      4.hs,
                      Text(
                        'Növbəti xatırlatma: ${state.nextReminderTime}',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 12,
                          color: const Color(0xFF8A8FA8),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
