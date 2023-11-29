import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planet_app/bloc/detail_bloc/detail_bloc.dart';
import 'package:planet_app/bloc/detail_bloc/detail_event.dart';
import 'package:planet_app/bloc/detail_bloc/detail_state.dart';
import 'package:planet_app/models/plant_model.dart';
import 'package:planet_app/supabase/supabase.dart';

class PlantDetailScreen extends StatelessWidget {
  const PlantDetailScreen({super.key, required this.plant});
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.8,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              plant.image.toString(),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: const Icon(Icons.arrow_back_rounded),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.9,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${plant.name}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text("${plant.describtion}"),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 9 / 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: [
                        DetailContainer(
                            icon: Icons.date_range,
                            title: "FREQUENCY",
                            data: "${plant.frequency} weeks"),
                        DetailContainer(
                            icon: Icons.water_drop_outlined,
                            title: "WATER",
                            data: "${plant.water}"),
                        DetailContainer(
                            icon: Icons.wifi_channel_rounded,
                            title: "TEMP",
                            data: "${plant.temp}"),
                        DetailContainer(
                            icon: Icons.sunny,
                            title: "LIGHT",
                            data: "${plant.light}"),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        SupabaseNetworking().addPlant(plant.id!);
                        context.read<DetailBloc>().add(AddPlantEvent());
                      },
                      icon: BlocConsumer<DetailBloc, DetailState>(
                        listener: (context, state) {
                          plant.userAdd = true;
                        },
                        builder: (context, state) {
                          return Icon(
                            plant.userAdd!
                                ? Icons.water_drop
                                : Icons.add_circle_rounded,
                            size: 35,
                            color: const Color(0xff9ac7d6),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailContainer extends StatelessWidget {
  const DetailContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.data,
  });
  final IconData icon;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfff1f2f4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(title), Text(data)],
          ),
          const SizedBox(width: 8)
        ],
      ),
    );
  }
}
