// ignore_for_file: non_constant_identifier_names

import 'package:aereopuerto/providers/bloc/loguinBloc/login_bloc.dart';
import 'package:aereopuerto/providers/bloc/loguinBloc/provider.dart';
import 'package:aereopuerto/screens/login_screen.dart';
import 'package:flutter/material.dart';


import '../providers/user_provider.dart';
import '../widgets/alarms_dialog.dart';

class RegisterScreen extends StatelessWidget {
  final userRegisterProvider = UserProvider();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[_crearFondo(context), _login_form(context)],
    ));
  }

  Widget _crearFondo(BuildContext context) {
   

    final fondoMorado = Container(
      height:  MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: <Color>[Colors.black, Colors.blueAccent])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(top: -50.0, right: -10.0, child: circulo),
        Positioned(top: 120.0, right: 20.0, child: circulo),
        Positioned(top: -50.0, left: -20.0, child: circulo),
      ],
    );
  }

  Widget _login_form(BuildContext context) {
    final bloc = ProviderP.of(context);
    

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 100.0,
          )),
          Container(
            width:  MediaQuery.of(context).size.width * 0.85,
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
                color: Colors.white,
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
                Text(
                  'Registrar Usuario',
                  style: const TextStyle(
                      fontSize: 25.0,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                _crearName(bloc),
                const SizedBox(
                  height: 15.0,
                ),
                _crearApellidos(bloc),
                const SizedBox(
                  height: 15.0,
                ),
                _crearEmail(bloc),
                const SizedBox(
                  height: 15.0,
                ),
                _crearPassword(bloc),
                const SizedBox(
                  height: 20.0,
                ),
                _crearBoton(bloc)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Ya tiene cuenta???'),
              GestureDetector(
                child: Text(
                  'Iniciar Sesión',
                  style: const TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
                onTap: () {
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              hintText: 'ejemplo@gmail.com',
              labelText: 'Correo',
              errorText: snapshot.error?.toString(),
              suffixIcon: const Icon(Icons.email),
            ),
            onChanged: (value) => bloc.changeEmail(
                value), //también se puede utilizar "bloc.changeEmail" en su lugar
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
          child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                hintText: '**********',
                labelText: 'Contraseña',
                errorText: snapshot.error?.toString(),
                suffixIcon: const Icon(Icons.lock_outline),
              ),
              onChanged: bloc.changePassword),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.registerFormValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 0.0),
          onPressed: snapshot.hasData ? () => _register(bloc, context) : null,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
        );
      },
    );
  }

  _register(LoginBloc bloc, BuildContext context) async {
    final info = await userRegisterProvider.registerUser(
        bloc.name, bloc.lastName, bloc.email, bloc.password);
    if (info['ok']) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Registro Exitoso')));
 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    } else {
      Alarm().showAlarm(
          context, 'Existe Mail', 'Error!!!');
    }

//verifico
  }
}

Widget _crearName(LoginBloc bloc) {
  return StreamBuilder(
    stream: bloc.nameStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            hintText: 'Digite su Carnet',
            labelText: 'Carnet',
            errorText: snapshot.error?.toString(),
            suffixIcon: const Icon(Icons.account_circle_sharp),
          ),
          onChanged: (value) => bloc.changeName(
              value), //también se puede utilizar "bloc.changeEmail" en su lugar
        ),
      );
    },
  );
}

Widget _crearApellidos(LoginBloc bloc) {
  return StreamBuilder(
    stream: bloc.lastNameStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            hintText: 'Digite su Nombre de Usuario',
            labelText: 'Nombre de Usuario',
            errorText: snapshot.error?.toString(),
            suffixIcon: const Icon(Icons.account_circle_sharp),
          ),
          onChanged: (value) => bloc.changeLastName(
              value), //también se puede utilizar "bloc.changeEmail" en su lugar
        ),
      );
    },
  );
}
