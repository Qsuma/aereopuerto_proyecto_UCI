import 'package:aereopuerto/providers/bloc/loguinBloc/provider.dart';
import 'package:aereopuerto/providers/boleto_provider.dart';
import 'package:aereopuerto/providers/vuelos_provider.dart';
import 'package:aereopuerto/screens/boletos_screen.dart';
import 'package:aereopuerto/screens/home_screen.dart';
import 'package:aereopuerto/screens/login_screen.dart';
import 'package:aereopuerto/ui/theme.dart';
import 'package:aereopuerto/utils/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    final prefs = PreferenciasUsuario();
  await prefs.initPrefs(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VuelosProvider(),),
        ChangeNotifierProvider(create: (context) => BoletoProvider(),)
      ],
      child: ProviderP(
        
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme,
          home:  HomeScreen(),
        ),
      ),
    );
  }
}

