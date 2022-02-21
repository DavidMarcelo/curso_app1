//import 'dart:html';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/banda.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Banda> bandas = [
    Banda(id: '3', name: 'Korn', votes: 4),
    Banda(id: '4', name: 'MM', votes: 1),
    Banda(id: '2', name: 'Slipnot', votes: 6),
    Banda(id: '1', name: 'Queen', votes: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nombre de Bandas",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        elevation: 1,
      ),
      body: ListView.builder(
          //El item builder mas que nada sirve para crear cada uno de los elementos de la lista.
          itemCount: bandas.length,
          itemBuilder: (context, i) => _BandasTile(bandas[i])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBanda, //() {},
      ),
    );
  }

  _BandasTile(Banda banda) {
    return Dismissible(
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print("Direction: $direction");
        print("ID: ${banda.id}");
        //Todo: llamar el borrado en el server
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Eliminar Banda',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(banda.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(banda.name),
        trailing: Text(
          '${banda.votes}',
          style: TextStyle(fontSize: 30),
        ),
        onTap: () {
          print("Tap" + banda.name);
        },
      ),
    );
  }

  addNewBanda() {
    //Esto sirve para obtener el valor que se agrega en el textField para agregar una nueva banda
    final textController = new TextEditingController();
    if (Platform.isAndroid) {
      //Todo esto sera para android exclusivamente
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Nueva banda agregada: "),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                child: Text("Agregar"),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandaName(textController.text),
              )
            ],
          );
        },
      );
    }
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text("Nombre de la nueva banda: "),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandaName(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  void addBandaName(String name) {
    if (name.length >= 1) {
      //Agregar la nueva banda
      this
          .bandas
          .add(new Banda(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
