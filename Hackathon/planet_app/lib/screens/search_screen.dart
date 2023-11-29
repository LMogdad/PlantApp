import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planet_app/bloc/search_bloc/search_bloc.dart';
import 'package:planet_app/bloc/search_bloc/search_event.dart';
import 'package:planet_app/bloc/search_bloc/search_state.dart';
import 'package:planet_app/supabase/supabase.dart';
import 'package:planet_app/widgets/planet_container.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
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
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
        child: SafeArea(
          child: ListView(
            children: [
              TextField(
                onChanged: (value) {
                  context.read<SearchBloc>().add(SearchPlantEvent(value));
                },
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff9ac7d6).withOpacity(0.35),
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintText: "Search",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none, width: 0),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
              const Divider(),
              BlocBuilder<SearchBloc, SearchState>(
                buildWhen: (oldstate, newstate) {
                  if (newstate is SelectState) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  return FutureBuilder(
                    future: SupabaseNetworking().searchPlant(state.searchText),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 1,
                            shrinkWrap: true,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 5 / 4,
                            children: [
                              if (snapshot.data!.isEmpty)
                                const Center(child: Text("Does not found")),
                              if (snapshot.data != [])
                                ...snapshot.data!
                                    .map(
                                        (plant) => PlantContainer(plant: plant))
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
        ),
      ),
    );
  }
}
