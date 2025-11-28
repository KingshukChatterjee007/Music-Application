import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

// Imports
import 'package:music_app/bloc/album_bloc.dart';
import 'package:music_app/bloc/boarding_bloc.dart';
import 'package:music_app/bloc/home_bloc.dart';
import 'package:music_app/bloc/player_bloc.dart';
import 'package:music_app/db_helper/db_helper.dart';
import 'package:music_app/res/app_colors.dart';
import 'package:music_app/view/on_boarding/on_boarding.dart'; // Correct Import

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BoardingBLoc(pageController: PageController()),
        ),
        BlocProvider(create: (_) => HomeBloc(dbHelper: DbHelper())),
        BlocProvider(create: (_) => PlayerBloc(player: AudioPlayer())),
        BlocProvider(
          create: (_) => AlbumBloc(pageController: PageController()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Music Player',

        // Light Theme
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          primaryColor: blueBackground,
          colorScheme: ColorScheme.fromSeed(
            seedColor: blueBackground,
            brightness: Brightness.light,
            surface: backgroundColor,
          ),
          useMaterial3: true,
          iconTheme: const IconThemeData(color: Colors.black87),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black87),
            titleLarge: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Dark Theme
        darkTheme: ThemeData(
          scaffoldBackgroundColor: darkBackgroundColor,
          primaryColor: blueBackground,
          colorScheme: ColorScheme.fromSeed(
            seedColor: blueBackground,
            brightness: Brightness.dark,
            surface: darkBackgroundColor,
          ),
          useMaterial3: true,
          iconTheme: const IconThemeData(color: Colors.white),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
            titleLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        themeMode: ThemeMode.system,

        // Pointing directly to OnBoarding now
        home: const OnBoarding(),
      ),
    );
  }
}
