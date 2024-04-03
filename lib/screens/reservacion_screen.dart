import 'package:aereopuerto/providers/vuelos_provider.dart';
import 'package:aereopuerto/screens/crear_reservacion.dart';
import 'package:aereopuerto/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ReservacionScreen extends StatelessWidget {
  const ReservacionScreen({super.key});

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: Text('Lista de Vuelos'),
      ),
      body: Consumer<VuelosProvider>(
        builder: (context, vuelosProvider, child) {
          return ListView.builder(
            itemCount: vuelosProvider.Vuelos.length,
            itemBuilder: (context, index) {
              final vuelo = vuelosProvider.Vuelos[index];
              return ListTile(
               title: Text('Vuelo ${vuelo.cdigov}'),
                 subtitle: Text('${vuelo.origen} a ${vuelo.destino}'),// Asume que cdigov es el código del vuelo
                onTap: () {
                
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CrearReservacionScreen(vuelo:vuelo),
                    ),
                 );
                },
              );
            },
          );
        },
      ),
    );
 }
}