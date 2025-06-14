import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'core/di/app_module.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Modular.setInitialRoute('/splash');

  runApp(ModularApp(module: AppModule(), child: const PokemonApp()));
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pokédex App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.red,
        primaryColor: Colors.black,
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      ),
      routerConfig: Modular.routerConfig,
    );
  }
}
