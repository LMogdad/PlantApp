import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planet_app/bloc/nav_bar_bloc/nav_bar_bloc.dart';
import 'package:planet_app/bloc/nav_bar_bloc/nav_bar_event.dart';
import 'package:planet_app/bloc/nav_bar_bloc/nav_bar_state.dart';
import 'package:planet_app/screens/ai_chat_screen.dart';
import 'package:planet_app/screens/home_screen.dart';
import 'package:planet_app/screens/schedule_screen.dart';
import 'package:planet_app/screens/search_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const HomeScreen(),
      const ScheduleScreen(),
      const SearchScreen(),
      const AIChatScreen(),
    ];
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        child: BottomAppBar(
          height: 60,
          color: Colors.white,
          elevation: 0,
          child: BlocBuilder<NavBarBloc, NavBarState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavBarIcon(
                    icon: Icons.home_filled,
                    index: 0,
                    isSelected: state.selection == 0,
                  ),
                  NavBarIcon(
                    icon: Icons.timer_rounded,
                    index: 1,
                    isSelected: state.selection == 1,
                  ),
                  NavBarIcon(
                    icon: Icons.search,
                    index: 2,
                    isSelected: state.selection == 2,
                  ),
                  NavBarIcon(
                    icon: Icons.api_rounded,
                    index: 3,
                    isSelected: state.selection == 3,
                  ),
                ],
              );
            },
          ),
        ),
      ),
      body: BlocBuilder<NavBarBloc, NavBarState>(
        builder: (context, state) {
          return screens[state.selection];
        },
      ),
    );
  }
}

class NavBarIcon extends StatelessWidget {
  const NavBarIcon({
    super.key,
    required this.icon,
    required this.index,
    required this.isSelected,
  });
  final IconData icon;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<NavBarBloc>().add(SelectScreenEvent(index));
      },
      icon: Icon(
        icon,
        color: isSelected ? const Color(0xff9ac7d6) : Colors.black,
      ),
    );
  }
}
