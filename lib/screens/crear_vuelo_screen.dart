import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aereopuerto/providers/vuelos_provider.dart';

class CrearVueloScreen extends StatefulWidget {
 @override
 _CrearVueloScreenState createState() => _CrearVueloScreenState();
}

class _CrearVueloScreenState extends State<CrearVueloScreen> {
 final _formKey = GlobalKey<FormState>();
 String _codigov = '';
 String _origen = '';
 String _destino = '';
 DateTime _fechav = DateTime.now();

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Vuelo'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Código del Vuelo'),
                validator: (value) {
                 if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el código del vuelo';
                 }
                 return null;
                },
                onSaved: (value) => _codigov = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Origen'),
                validator: (value) {
                 if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el origen';
                 }
                 return null;
                },
                onSaved: (value) => _origen = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Destino'),
                validator: (value) {
                 if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el destino';
                 }
                 return null;
                },
                onSaved: (value) => _destino = value!,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                 if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  
                    Provider.of<VuelosProvider>(context, listen: false).postVuelo(_codigov, _origen, _destino, _fechav);
                   
                    Navigator.pop(context);
                 }
                },
                child: Text('Crear Vuelo'),
              ),
            ],
          ),
        ),
      ),
    );
 }
}