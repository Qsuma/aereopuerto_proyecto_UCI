import 'package:aereopuerto/providers/vuelos_provider.dart';
import 'package:aereopuerto/widgets/crear_vuelo.dart';
import 'package:aereopuerto/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
final vuelosProvider = Provider.of<VuelosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.red[300],
        title: Center(child: Text('Admin CRUD',)),
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
             vuelosProvider.postVuelo('2209','96101','92102', DateTime.now()) ;
                showDialog(context: context, builder: (context) => const CrearVuelo(),);
                // Acción para crear un vuelo
                // Implementa la lógica aquí
              },
              child: Text('Crear Vuelo'),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción para eliminar un vuelo
                // Implementa la lógica aquí
                vuelosProvider.deleteVuelos('7772');
              },
              child: Text('Eliminar Vuelo'),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción para modificar un vuelo
              vuelosProvider.patchVuelo('7772', 'Cuba', 'Plp', DateTime.now());  // Implementa la lógica aquí
              },
              child: Text('Modificar Vuelo'),
              
            ),
            ElevatedButton(
              onPressed: () {
                vuelosProvider.getVuelos();
                // Acción para mostrar vuelos
                // Implementa la lógica aquí
              },
              child: Text('Mostrar Vuelos'),
            ),
          ],
        ),
      ),
    );
  }
}