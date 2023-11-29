import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planet_app/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:planet_app/bloc/schedule_bloc/schedule_event.dart';
import 'package:planet_app/bloc/schedule_bloc/schedule_state.dart';
import 'package:planet_app/supabase/supabase.dart';
import 'package:planet_app/widgets/schedule_container.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ScheduleBloc>().add(SelectDateEvent(
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white, Color(0xffe4e4e4)],
          ),
        ),
        child: Column(
          children: [
            CalendarTimeline(
              initialDate: DateTime.now(),
              firstDate: DateTime(DateTime.now().year, DateTime.now().month - 1,
                  DateTime.now().day),
              lastDate: DateTime(DateTime.now().year, DateTime.now().month + 3,
                  DateTime.now().day),
              onDateSelected: (date) {
                date.day <= 9
                    ? context.read<ScheduleBloc>().add(SelectDateEvent(
                        "${date.year}-${date.month}-0${date.day}"))
                    : context.read<ScheduleBloc>().add(SelectDateEvent(
                        "${date.year}-${date.month}-${date.day}"));
              },
              leftMargin: 20,
              monthColor: Colors.blueGrey,
              dayColor: const Color(0xff9ac7d6),
              activeDayColor: Colors.white,
              activeBackgroundDayColor: const Color(0xff394929),
              dotsColor: Colors.white,
              selectableDayPredicate: (date) => date.day != 23,
              locale: 'en_ISO',
            ),
            const Divider(),
            BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                return Text(
                  "Plants Need to be water in ${state.date}",
                  style: const TextStyle(
                    color: Color(0xff394929),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                return FutureBuilder(
                    future: SupabaseNetworking().findByWaterDate(state.date),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                            children: snapshot.data!.map((plant) {
                          return SchedualeContainer(plant: plant);
                        }).toList());
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
