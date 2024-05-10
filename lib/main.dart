import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'widgets/expenses_home.dart';

void main() {
  runApp(const MyApp());
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then(
  //   (_) => ),
}

var myColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 59, 96, 179),
);
var myDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 59, 96, 179),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      themeMode: ThemeMode.light,
      // darkTheme: ThemeData.dark(),

      theme: ThemeData().copyWith(
        colorScheme: myColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: myColorScheme.onPrimaryContainer,
          foregroundColor: myColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: myColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: myColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: myColorScheme.onSecondaryContainer,
                fontSize: 17,
              ),
            ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),

      darkTheme: ThemeData.dark().copyWith(
        colorScheme: myDarkColorScheme,
        bottomSheetTheme: const BottomSheetThemeData()
            .copyWith(backgroundColor: myDarkColorScheme.onPrimaryContainer),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: myDarkColorScheme.onPrimaryContainer,
          foregroundColor: myDarkColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: myDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: myDarkColorScheme.onPrimaryContainer,
            foregroundColor: myDarkColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: myDarkColorScheme.onSecondaryContainer,
                fontSize: 17,
              ),
              bodyLarge: const TextStyle(color: Colors.white),
              titleMedium: const TextStyle(color: Colors.white),
            ),
        // iconTheme: const IconThemeData(
        //   color: Color.fromARGB(255, 255, 124, 77),
        // ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
          counterStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      home: const Expenses(),
    );
  }
}
