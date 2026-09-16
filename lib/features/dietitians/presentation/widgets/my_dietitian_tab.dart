import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/dietitians_bloc.dart';
import 'dietitian_invite_card.dart';
import 'dietitian_section_header.dart';
import 'dietitian_tip_card.dart';
import 'my_dietitian_card.dart';

class MyDietitianTab extends StatelessWidget {
  const MyDietitianTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DietitiansBloc, DietitiansState>(
      listener: (context, state) {
        if (state is DietitiansLoaded && state.message != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message!)));
        }
      },
      builder: (context, state) {
        // ─────────────────────────────────────────────
        // INITIAL LOADING
        // ─────────────────────────────────────────────

        if (state is DietitiansInitial || state is DietitiansLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // ─────────────────────────────────────────────
        // ERROR
        // ─────────────────────────────────────────────

        if (state is DietitiansError) {
          return _ErrorView(
            message: state.message,
            onRetry: () {
              context.read<DietitiansBloc>().add(DietitiansRequested());
            },
          );
        }

        if (state is! DietitiansLoaded) {
          return const SizedBox.shrink();
        }

        // ─────────────────────────────────────────────
        // CONTENT
        // ─────────────────────────────────────────────

        return RefreshIndicator(
          onRefresh: () async {
            context.read<DietitiansBloc>().add(DietitiansRefreshed());
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 125),
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              // ─────────────────────────────────────
              // INVITES
              // ─────────────────────────────────────
              if (state.hasInvites) ...[
                DietitianSectionHeader(
                  title: 'Gələn dəvətlər',
                  badge: state.invites.length.toString(),
                ),

                const SizedBox(height: 12),

                ...state.invites.map(
                  (invite) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DietitianInviteCard(
                      invite: invite,
                      isLoading: state.isInviteLoading(invite.id),
                      onAccept: () {
                        context.read<DietitiansBloc>().add(
                          DietitianInviteAccepted(inviteId: invite.id),
                        );
                      },
                      onReject: () {
                        context.read<DietitiansBloc>().add(
                          DietitianInviteRejected(inviteId: invite.id),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],

              // ─────────────────────────────────────
              // MY DIETITIAN
              // ─────────────────────────────────────
              const DietitianSectionHeader(title: 'Mənim dietoloqum'),

              const SizedBox(height: 12),

              if (state.myDietitian != null)
                MyDietitianCard(
                  dietitian: state.myDietitian!,
                  activeDietPlan: state.activeDietPlan,
                  dailyCheckIns: state.dailyCheckIns,
                  isCheckInsLoading: state.isCheckInsLoading,
                )
              else
                const _NoDietitianCard(),

              const SizedBox(height: 18),

              const DietitianTipCard(),
            ],
          ),
        );
      },
    );
  }
}

// ───────────────────────────────────────────────────────────
// NO DIETITIAN
// ───────────────────────────────────────────────────────────

class _NoDietitianCard extends StatelessWidget {
  const _NoDietitianCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
      ),
      child: const Column(
        children: [
          Icon(Icons.person_search_rounded, size: 44, color: Color(0xFF7B8D93)),

          SizedBox(height: 12),

          Text(
            'Aktiv dietoloqun yoxdur',
            style: TextStyle(
              color: Color(0xFF153A45),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 6),

          Text(
            'Dietoloq dəvətini qəbul etdikdən sonra '
            'məlumatları burada görünəcək.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7B8D93),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────
// ERROR
// ───────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, size: 42),

            const SizedBox(height: 12),

            Text(message, textAlign: TextAlign.center),

            const SizedBox(height: 16),

            FilledButton(
              onPressed: onRetry,
              child: const Text('Yenidən yoxla'),
            ),
          ],
        ),
      ),
    );
  }
}
