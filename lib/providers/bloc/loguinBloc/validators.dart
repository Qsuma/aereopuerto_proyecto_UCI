import 'dart:async';

mixin Validators {
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern.toString());

    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email no es correcto');
    }
  });
  final validarUsername =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    // Pattern pattern =
    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    // RegExp regExp = RegExp(pattern.toString());

    if (email.length>5) {
      sink.add(email);
    } else {
      sink.addError('Nombre de Usuario no es correcto');
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Este campo debe de tener mas de 6 caracteres');
    }
  });
  final validarNombre =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isNotEmpty) {
      sink.add(name);
    } else {
      sink.addError('Debe poner el nombre');
    }
  });
  final validarApellidos = StreamTransformer<String, String>.fromHandlers(
      handleData: (lastName, sink) {
    if (lastName.isNotEmpty) {
      sink.add(lastName);
    } else {
      sink.addError('Debe poner los apellidos');
    }
  });
}
