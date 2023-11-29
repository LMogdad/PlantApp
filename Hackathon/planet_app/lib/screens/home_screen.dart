import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planet_app/bloc/home_bloc/home_bloc.dart';
import 'package:planet_app/bloc/home_bloc/home_event.dart';
import 'package:planet_app/bloc/home_bloc/home_state.dart';
import 'package:planet_app/supabase/supabase.dart';
import 'package:planet_app/widgets/home_bar.dart';
import 'package:planet_app/widgets/planet_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.white, Color(0xffe4e4e4)],
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              children: [
                SizedBox(
                  height: 45,
                  child: ClipOval(
                    child: Image.asset("assets\\profile.jpg"),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.notifications_active_outlined),
                const SizedBox(width: 16),
                const Icon(Icons.settings_outlined),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Hey Miqdad",
              style: TextStyle(
                color: Color(0xff91A37F),
                fontSize: 17,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Help Us To Save Our Mother Earth",
              style: TextStyle(
                color: Color(0xff394929),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              decoration: BoxDecoration(
                color: const Color(0xffE6FFD6),
                borderRadius: BorderRadius.circular(25),
              ),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HomeBar(
                        onTap: () async {
                          context.read<HomeBloc>().add(SelectTabEvent(0));
                        },
                        text: "Houseplants",
                        isSelected: state.selection == 0,
                      ),
                      HomeBar(
                        onTap: () {
                          context.read<HomeBloc>().add(SelectTabEvent(1));
                        },
                        text: "Evergreen trees",
                        isSelected: state.selection == 1,
                      ),
                      HomeBar(
                        onTap: () {
                          context.read<HomeBloc>().add(SelectTabEvent(2));
                        },
                        text: "Palm Tree",
                        isSelected: state.selection == 2,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (oldstate, newstate) {
              if (newstate is SelectState) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              return FutureBuilder(
                future: SupabaseNetworking().getPlants(state.selection + 1),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: snapshot.data!.isEmpty ? 1 : 2,
                        shrinkWrap: true,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 4 / 5,
                        children: [
                          if (snapshot.data!.isEmpty)
                            const Center(child: CircularProgressIndicator()),
                          if (snapshot.data != [])
                            ...snapshot.data!
                                .map((plant) => PlantContainer(plant: plant))
                                .toList(),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
