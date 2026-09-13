import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import 'bloc/dietitian_invites_bloc.dart';
import 'widgets/dietitian_invites_error_state.dart';
import 'widgets/dietitian_invites_list.dart';

class DietitianInvitesPage extends StatelessWidget {
  const DietitianInvitesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = sl<DietitianInvitesBloc>();

    bloc.add(const DietitianInvitesRequested());

    return BlocProvider.value(
      value: bloc,
      child: const _DietitianInvitesView(),
    );
  }
}

class _DietitianInvitesView extends StatelessWidget {
  const _DietitianInvitesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const CustomAppBar(title: 'Dietoloq dəvətləri'),
      body: BlocConsumer<DietitianInvitesBloc, DietitianInvitesState>(
        listener: (context, state) {
          if (state is DietitianInviteActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
                ),
                backgroundColor: AppColors.success,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DietitianInvitesInitial ||
              state is DietitianInvitesLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is DietitianInvitesError) {
            return DietitianInvitesErrorState(
              message: state.message,
              onRetry: () {
                context.read<DietitianInvitesBloc>().add(
                  const DietitianInvitesRequested(),
                );
              },
            );
          }

          if (state is DietitianInvitesLoaded) {
            return DietitianInvitesList(invites: state.invites);
          }

          if (state is DietitianInviteActionLoading) {
            return DietitianInvitesList(
              invites: state.invites,
              loadingInviteId: state.inviteId,
            );
          }

          if (state is DietitianInviteActionSuccess) {
            return DietitianInvitesList(invites: state.invites);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
