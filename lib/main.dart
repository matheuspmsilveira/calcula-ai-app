import 'package:calcula_ai/src/providers/home_view_provider.dart';
import 'package:calcula_ai/src/providers/papers_provider.dart';
import 'package:calcula_ai/src/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PapersProvider()),
        ChangeNotifierProvider(create: (context) => HomeViewProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldKey,
        title: 'Calcula.ai',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
  }
}
