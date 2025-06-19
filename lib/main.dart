import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:praktikum_1/application/login/bloc/login_bloc.dart';
import 'package:praktikum_1/application/login/login.dart';
import 'package:praktikum_1/application/register/bloc/register_bloc.dart';
import 'package:praktikum_1/view/home.dart';
import 'package:praktikum_1/firebase_options.dart';




void main() async {
  // This part remains unchanged from your original main.dart B
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Init Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);



  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(firebaseAuth: FirebaseAuth.instance),
        ),
        BlocProvider<RegisterBloc>(
          create: (_) => RegisterBloc(firebaseAuth: FirebaseAuth.instance),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

// ✨ This MyApp widget is now matched with main.dart A's structure ✨
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Adoption',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),

      // ⛳ Awal aplikasi (Matched with A)
      initialRoute: '/login',

      // 🔧 Define named routes (Matched with A)
      routes: {
        '/login': (context) => const MyHomePage(), // Assumes LoginPage widget exists
        '/home': (context) => const MyHomePage(),
      },
    );
  }
}