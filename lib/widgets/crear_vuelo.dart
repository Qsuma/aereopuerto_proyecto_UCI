import 'package:flutter/material.dart';
class CrearVuelo extends StatelessWidget {
  const CrearVuelo({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                title: Text('Crear Vuelo'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Número de Vuelo',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Origen',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Destino',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Acción para crear el vuelo
                        // Implementa la lógica aquí
                        Navigator.pop(context); // Cierra el mensaje emergente
                      },
                      child: Text('Crear'),
                    ),
                  ],
                ),
              );
  }
}