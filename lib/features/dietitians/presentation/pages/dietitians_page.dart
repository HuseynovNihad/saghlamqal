import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../bloc/dietitians_bloc.dart';
import '../widgets/dietitians_header.dart';
import '../widgets/dietitians_segmented_control.dart';
import '../widgets/discover/dietitians_discover_tab.dart';
import '../widgets/my_dietitian_tab.dart';

class DietitiansPage extends StatefulWidget {
  const DietitiansPage({super.key});

  @override
  State<DietitiansPage> createState() => _DietitiansPageState();
}

class _DietitiansPageState extends State<DietitiansPage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DietitiansBloc>()..add(DietitiansRequested()),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const DietitiansHeader(),

              DietitiansSegmentedControl(
                selectedIndex: _selectedTab,
                onChanged: (index) {
                  if (_selectedTab == index) return;

                  setState(() {
                    _selectedTab = index;
                  });
                },
              ),

              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  child: _selectedTab == 0
                      ? const MyDietitianTab(key: ValueKey('my-dietitian'))
                      : const DietitiansDiscoverTab(key: ValueKey('discover')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
