import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planet_app/bloc/detail_bloc/detail_bloc.dart';
import 'package:planet_app/bloc/home_bloc/home_bloc.dart';
import 'package:planet_app/bloc/nav_bar_bloc/nav_bar_bloc.dart';
import 'package:planet_app/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:planet_app/bloc/search_bloc/search_bloc.dart';
import 'package:planet_app/screens/get_started_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://otlmgvgtfiuwjjtspcma.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im90bG1ndmd0Zml1d2pqdHNwY21hIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY5OTc3NzIxNiwiZXhwIjoyMDE1MzUzMjE2fQ.ivEB30U4WmrvUWRdKFNuhdcYV9_zn4Ok3xC1kn1ty5g",
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavBarBloc>(
          create: (BuildContext context) => NavBarBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc(),
        ),
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => SearchBloc(),
        ),
        BlocProvider<DetailBloc>(
          create: (BuildContext context) => DetailBloc(),
        ),
        BlocProvider<ScheduleBloc>(
          create: (BuildContext context) => ScheduleBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const GetStartScreen(),
        theme: ThemeData(useMaterial3: false),
      ),
    );
  }
}
