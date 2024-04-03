import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aereopuerto/providers/reservacion_provider.dart'; // Asegúrate de importar tu ReservacionProvider
import 'package:aereopuerto/models/vuelo.dart'; // Asegúrate de importar tu modelo de Vuelo

class CrearReservacionScreen extends StatefulWidget {
 final Vuelo vuelo;
 const CrearReservacionScreen({super.key, required this.vuelo});

 @override
 _CrearReservacionScreenState createState() => _CrearReservacionScreenState();
}

class _CrearReservacionScreenState extends State<CrearReservacionScreen> {
 final _formKey = GlobalKey<FormState>();
 String _nombreUsuario = '';


 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Reservación para el Vuelo ${widget.vuelo.cdigov}'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre del Usuario'),
                validator: (value) {
                 if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el nombre del usuario';
                 }
                 return null;
                },
                onSaved: (value) => _nombreUsuario = value!,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                 if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                   
                    Provider.of<ReservacionProvider>(context, listen: false).postReservacion( _nombreUsuario, widget.vuelo.cdigov.toString(),DateTime.now());
                  
                    Navigator.pop(context);
                 }
                },
                child: Text('Crear Reservación'),
              ),
            ],
          ),
        ),
      ),
    );
 }
}