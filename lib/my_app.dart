import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/page_base.dart';
import 'providers/app_state.dart';
import 'providers/places_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()),
        ChangeNotifierProvider(create: (context) => PlacesState()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const PageBase(),
      ),
    );
  }
}
