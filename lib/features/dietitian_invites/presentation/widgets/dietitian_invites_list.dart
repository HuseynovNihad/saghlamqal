import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/dietitian_invite_entity.dart';
import '../bloc/dietitian_invites_bloc.dart';
import 'dietitian_invite_card.dart';
import 'dietitian_invites_empty_state.dart';

class DietitianInvitesList extends StatelessWidget {
  final List<DietitianInviteEntity> invites;
  final String? loadingInviteId;

  const DietitianInvitesList({
    super.key,
    required this.invites,
    this.loadingInviteId,
  });

  @override
  Widget build(BuildContext context) {
    if (invites.isEmpty) {
      return const DietitianInvitesEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<DietitianInvitesBloc>().add(
          const DietitianInvitesRequested(),
        );
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 28.h),
        itemCount: invites.length,
        separatorBuilder: (_, __) {
          return SizedBox(height: 12.h);
        },
        itemBuilder: (context, index) {
          final invite = invites[index];

          return DietitianInviteCard(
            invite: invite,
            isLoading: loadingInviteId == invite.id,
          );
        },
      ),
    );
  }
}
