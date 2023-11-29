import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planet_app/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:planet_app/bloc/schedule_bloc/schedule_event.dart';
import 'package:planet_app/models/plant_model.dart';
import 'package:planet_app/supabase/supabase.dart';

class SchedualeContainer extends StatelessWidget {
  const SchedualeContainer({super.key, required this.plant});
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.grey.withOpacity(0.75),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              plant.name!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "watering once every ${plant.frequency} week/s",
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              onPressed: () async {
                await SupabaseNetworking()
                    .water(plant.id!, int.parse(plant.frequency!));
                // ignore: use_build_context_synchronously
                context.read<ScheduleBloc>().add(SelectDateEvent(
                    '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'));
              },
              icon: const Icon(
                Icons.water_drop,
                size: 35,
                color: Color(0xff9ac7d6),
              ),
            )
          ],
        ),
      ),
    );
  }
}
