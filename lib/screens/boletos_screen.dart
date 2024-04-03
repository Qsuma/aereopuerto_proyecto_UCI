import 'package:aereopuerto/providers/boleto_provider.dart';
import 'package:aereopuerto/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoletoScreen extends StatelessWidget {
  const BoletoScreen({super.key});

 @override
 Widget build(BuildContext context) {
    final boletoProvider = Provider.of<BoletoProvider>(context);

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: Center(child: Text('Admin CRUD Boletos')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
               // boletoProvider.postBoleto('69', '7007',);
                // Acción para crear un boleto
              },
              child: Text('Crear Boleto'),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción para eliminar un boleto
                // Implementa la lógica aquí
             //   boletoProvider.deleteBoletos('69');
              },
              child: Text('Eliminar Boleto'),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción para modificar un boleto
                // Implementa la lógica aquí
                //boletoProvider.patchBoleto('2','90000', '1119');
              },
              child: Text('Modificar Boleto'),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción para mostrar boletos
                // Implementa la lógica aquí
                boletoProvider.getBoletos();
              },
              child: Text('Mostrar Boletos'),
            ),
          ],
        ),
      ),
    );
 }
}