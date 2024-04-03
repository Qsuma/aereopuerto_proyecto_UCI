import 'package:aereopuerto/screens/crear_vuelo_screen.dart';
import 'package:aereopuerto/widgets/crear_vuelo.dart';
import 'package:aereopuerto/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aereopuerto/providers/vuelos_provider.dart';


class VuelosScreen extends StatefulWidget {
  const VuelosScreen({super.key});

  @override
  State<VuelosScreen> createState() => _VuelosScreenState();
}

class _VuelosScreenState extends State<VuelosScreen> {
 @override
 Widget build(BuildContext context) {
  final vuelosProvider = Provider.of<VuelosProvider>(context);
  
    return Scaffold(
      floatingActionButton: IconButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(const Color.fromARGB(156, 0, 0, 0))),
        iconSize: 40,
        color: Colors.blueAccent,
        onPressed: () {
        showDialog(context: context, builder: (context) => CrearVueloScreen(),);
      }, icon: const Icon(Icons.add)),
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Lista de Vuelos'),
      ),
      body: ListView.builder(
              itemCount: vuelosProvider.Vuelos.length,
              itemBuilder: (context, index) {
                final vuelo = vuelosProvider.Vuelos[index];
                return ListTile(
                 title: Text('Vuelo ${vuelo.cdigov}'),
                 subtitle: Text('${vuelo.origen} a ${vuelo.destino}'),
                 trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                     Provider.of<VuelosProvider>(context, listen: false).deleteVuelos(vuelo.cdigov.toString());
                    },
                 ),
                 onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => VueloDetailPage(vuelo: vuelo)));
                 },
                );
              },
    ));
          }
        }
     
    
 
