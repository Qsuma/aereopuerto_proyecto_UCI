// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously




import 'package:aereopuerto/providers/bloc/loguinBloc/login_bloc.dart';
import 'package:aereopuerto/providers/bloc/loguinBloc/provider.dart';
import 'package:aereopuerto/screens/register_screen.dart';
import 'package:aereopuerto/screens/reservacion_screen.dart';
import 'package:aereopuerto/screens/vuelos_screen.dart';
import 'package:aereopuerto/utils/preferencias_usuario.dart';
import 'package:aereopuerto/utils/route_animation.dart';
import 'package:aereopuerto/widgets/alarms_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';





import '../providers/user_provider.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
   final prefs = PreferenciasUsuario();

  
  final _usernameController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  bool rememberme = false;

  bool showpass = true;
  final userRegisterProvider = UserProvider();
  @override
  void initState() {
     super.initState();
  
    
   
  
   
    final username = prefs.usuario;
    final password = prefs.password;
    _usernameController.text = username;
    _passwordController.text = password;
    if(username!=''){

       _loginRegistered();

    }
  
  }
 
 
  _loginRegistered() async{



    //aqui va el coso dese de cargar mientras espera
//TODO: ENVIAR ID
    Map info = await userRegisterProvider.loginUser(_usernameController.text, _passwordController.text);

  
    if (info['ok']) {
      if (rememberme) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('usuario', _usernameController.text);
          prefs.setString('password', _passwordController.text);
        });
      } else {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('usuario', '');
          prefs.setString('password', '');
        });
      }
(_usernameController.text=="reyjesus"||prefs.usuario=="reyjesus")?
Navigator.pushReplacement(
        context,
        crearRuta(
       
         const VuelosScreen() ,
            //RegisterScreen(),
            const Duration(milliseconds: 700)),
      )

:Navigator.pushReplacement(
        context,
        crearRuta(
        
         const ReservacionScreen() ,
            //RegisterScreen(),
            const Duration(milliseconds: 700)),
      );
    } else {
      Alarm().showAlarm(
          context, 'Ups!!!', info['mensaje']);
    }


}

  @override
  void dispose() {
  
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: true, 
        body: Stack(
          alignment: Alignment.topCenter,
            children: <Widget>[_crearFondo(context), 
             Center(child: _login_form(context))],
          ));
  }

  Widget _crearFondo(BuildContext context) {
    
    
    final fondoMorado = Container(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: <Color>[Colors.black, Colors.redAccent])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return SingleChildScrollView(
      
      child: Stack(
        children: <Widget>[
          fondoMorado,
          Positioned(top: 90.0, left: 30.0, child: circulo),
          Positioned(top: -40.0, right: -30.0, child: circulo),
          Positioned(top: -50.0, right: -10.0, child: circulo),
          Positioned(top: 120.0, right: 20.0, child: circulo),
          Positioned(top: -50.0, left: -20.0, child: circulo),
          // Container(
          //   padding:  EdgeInsets.only(top: 80.0),
          //   child: Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: <Widget>[
          //         SizedBox(
                    
          //           width: MediaQuery.of(context).size.width *0.1,
          //           child:   Image(image: AssetImage('assets/icon.png')),
          //         ),
          //        SizedBox(height: 10.0),
          //        Text(
          //           'Gestion Aeropuerto',
          //           style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 25.0),
          //         )
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _login_form(BuildContext context) {
    final bloc = ProviderP.of(context);
    
//saqui

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width* 0.70,
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 0.5),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      
                     'Iniciar Sesión',
                     maxLines: 1,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                          fontSize: 20.0,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ), 
           
                SizedBox(
                
                width: MediaQuery.of(context).size.width *0.05,
                child:   const Image(image: AssetImage('assets/icon.png')),
              ),
                  ],
                ),
                
                _crearEmail(bloc),
                const SizedBox(
                  height: 30.0,
                ),
                _crearPassword(bloc),
                const SizedBox(
                  height: 10.0,
                ),
                _checkbox(),
                const SizedBox(
                  height: 10.0,
                ),
                _crearBoton(bloc),
              ],
            ),
          ),
          //TeXTO A pantalla de registro
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('No tienes cuenta'),
              ElevatedButton(
            
                
                onPressed: () {
               Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => RegisterScreen(),)); 
                
              }, child: const Text(
                  ' registrate.',
                  style: TextStyle(
                      color: Color.fromARGB(255, 11, 11, 231), fontWeight: FontWeight.bold),
                ))
            ],
          ),
        ],
      ),
    );
  }

  Row _checkbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
       
            value: rememberme,
            onChanged: (value) => setState(() {
              rememberme = !rememberme;
            }),
          ),
        const Text('Recouerdame')
      ],
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              hintText: 'Inserte su Nombre de Usuario',
              labelText: 'Nombre de Usuario',
              errorText: snapshot.error?.toString(),
              suffixIcon: const Icon(Icons.alternate_email),
            ),
            onChanged: (value) => bloc.changeEmail(value),
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(

              // aqui es donde se va a hacer
              controller: _passwordController,
              obscureText: showpass,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: '**********',
                  labelText: 'Contraseña',
                  errorText: snapshot.error?.toString(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      !showpass ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        showpass = !showpass;
                      });
                    },
                  )),
              onChanged: bloc.changePassword),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc,) {
    String botontext = 'Loguin';
    return StreamBuilder(
      stream: bloc.loginFormValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 0.0),
            onPressed: snapshot.hasData
                ? () {
                    _login(bloc, context);
                   // Alarm().showAlarm(
                    //    context, ClassLocalizations.of(context).espere, '!!!');
                  }
                : null,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
              child: Text(botontext),
            ),
          );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
    //aqui va el coso dese de cargar mientras espera


   Map info = await userRegisterProvider.loginUser(_usernameController.text, _passwordController.text);

    if (info['ok']) {
      if (rememberme) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('usuario', _usernameController.text);
          prefs.setString('password', _passwordController.text);
        });
      } else {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('usuario', '');
          prefs.setString('password', '');
        });
      }
(_usernameController.text=="reyjesus"||prefs.usuario=="reyjesus")?
Navigator.pushReplacement(
        context,
        crearRuta(
       
         const VuelosScreen() ,
            //RegisterScreen(),
            const Duration(milliseconds: 700)),
      )

:Navigator.pushReplacement(
        context,
        crearRuta(
        
         const ReservacionScreen() ,
            //RegisterScreen(),
            const Duration(milliseconds: 700)),
      );
    } else {
      Alarm().showAlarm(
          context, 'Ups!!!', info['mensaje']);
    }

    
  }
}
