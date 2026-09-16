import 'package:flutter/material.dart';

import '../../domain/entities/daily_meal_check_ins_entity.dart';
import '../../domain/entities/my_dietitian_entity.dart';
import '../../domain/entities/patient_diet_plan_entity.dart';
import 'diet_plan_summary_card.dart';
import 'dietitian_avatar.dart';
import 'dietitian_quick_action.dart';

class MyDietitianCard extends StatelessWidget {
  final MyDietitianEntity dietitian;
  final PatientDietPlanEntity? activeDietPlan;
  final DailyMealCheckInsEntity? dailyCheckIns;

  final bool isCheckInsLoading;

  final VoidCallback? onDietPlanTap;
  final VoidCallback? onMessageTap;
  final VoidCallback? onAppointmentsTap;
  final VoidCallback? onProfileTap;

  const MyDietitianCard({
    super.key,
    required this.dietitian,
    this.activeDietPlan,
    this.dailyCheckIns,
    this.isCheckInsLoading = false,
    this.onDietPlanTap,
    this.onMessageTap,
    this.onAppointmentsTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black.withValues(alpha: 0.035)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.045),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        children: [
          _DietitianInfo(dietitian: dietitian, onProfileTap: onProfileTap),

          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 16),
            child: Row(
              children: [
                Expanded(
                  child: DietitianQuickAction(
                    icon: Icons.restaurant_menu_rounded,
                    label: 'Diet planım',
                    onTap: activeDietPlan != null ? onDietPlanTap : null,
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: DietitianQuickAction(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'Mesaj yaz',
                    onTap: onMessageTap,
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: DietitianQuickAction(
                    icon: Icons.calendar_month_outlined,
                    label: 'Görüşlər',
                    onTap: onAppointmentsTap,
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: DietitianQuickAction(
                    icon: Icons.badge_outlined,
                    label: 'Profilə bax',
                    onTap: onProfileTap,
                  ),
                ),
              ],
            ),
          ),

          if (activeDietPlan != null)
            Container(
              margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: DietPlanSummaryCard(
                dietPlan: activeDietPlan!,
                dailyCheckIns: dailyCheckIns,
                isCheckInsLoading: isCheckInsLoading,
                onTap: onDietPlanTap,
              ),
            )
          else
            const _NoActivePlan(),
        ],
      ),
    );
  }
}

class _DietitianInfo extends StatelessWidget {
  final MyDietitianEntity dietitian;
  final VoidCallback? onProfileTap;

  const _DietitianInfo({required this.dietitian, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    final info = dietitian.dietitian;

    return InkWell(
      onTap: onProfileTap,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 17, 14, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DietitianAvatar(
              initials: _initials(info.firstName, info.lastName),
              imageUrl: info.imageUrl,
              size: 72,
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          info.fullName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF112B36),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(width: 5),

                      Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: Color(0xFF21B968),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 13,
                        ),
                      ),
                    ],
                  ),

                  if (info.title != null && info.title!.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(
                      info.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.blueGrey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],

                  if (info.clinicName != null &&
                      info.clinicName!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      info.clinicName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.blueGrey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],

                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      const _ActiveRelationBadge(),

                      if (info.rating > 0)
                        _RatingBadge(
                          rating: info.rating,
                          reviewCount: info.reviewCount,
                        ),
                    ],
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 28),
              child: Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF173B46),
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String? firstName, String? lastName) {
    final first = firstName?.trim() ?? '';
    final last = lastName?.trim() ?? '';

    final firstInitial = first.isNotEmpty ? first[0] : '';

    final lastInitial = last.isNotEmpty ? last[0] : '';

    final result = '$firstInitial$lastInitial'.toUpperCase();

    return result.isEmpty ? 'D' : result;
  }
}

class _ActiveRelationBadge extends StatelessWidget {
  const _ActiveRelationBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F8EF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_rounded, size: 14, color: Color(0xFF20A85B)),
          SizedBox(width: 4),
          Text(
            'Aktiv əlaqə',
            style: TextStyle(
              color: Color(0xFF208E51),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const _RatingBadge({required this.rating, required this.reviewCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7E6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 14, color: Color(0xFFFFB224)),
          const SizedBox(width: 3),
          Text(
            '$rating ($reviewCount)',
            style: const TextStyle(
              color: Color(0xFF8B6A25),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoActivePlan extends StatelessWidget {
  const _NoActivePlan();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9EEEE)),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.restaurant_menu_rounded,
            color: Color(0xFF809096),
            size: 21,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Hazırda aktiv diet planın yoxdur.',
              style: TextStyle(color: Color(0xFF7B8D93), fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
