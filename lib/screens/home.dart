// Dart imports
import 'dart:io';

// Packages Flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Packages Project
import 'package:bands_vote_app/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Bands Mock

  List<Band> bands = [
    Band(bandId: '1', bandName: 'Simple Plan', bandCount: 5),
    Band(bandId: '2', bandName: 'Jimmy Eat World', bandCount: 2),
    Band(bandId: '3', bandName: 'Green Day', bandCount: 7),
    Band(bandId: '4', bandName: 'Linkin Park', bandCount: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bands Vote',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple,
        elevation: 2,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) =>
            _bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.purple,
        elevation: 2,
        // ignore: avoid_print
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.bandId),
      direction: DismissDirection.startToEnd,
      // ignore: avoid_print
      onDismissed: (direction) => print(
          'Dismiss Direction: $direction\nBand Name: ${band.bandName}\nBand Id: ${band.bandId}'),
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.delete_sweep_rounded,
              color: Colors.white,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Delete Band...',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            band.bandName.substring(0, 2),
          ),
          backgroundColor: Colors.purple[600],
        ),
        title: Text(band.bandName),
        trailing: Text(
          '${band.bandCount}',
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
        // ignore: avoid_print
        onTap: () => print(band.bandName),
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add new band name:'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                child: const Text('Add'),
                textColor: Colors.purple,
                elevation: 5,
                // ignore: avoid_print
                onPressed: () => addBandToList(textController.text),
              ),
            ],
          );
        },
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text('Add new band name:'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Add'),
              // ignore: avoid_print
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Dismiss'),
              // ignore: avoid_print
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      // TODO: 'add Band name to database'
      bands.add(
        Band(bandId: DateTime.now().toString(), bandName: name, bandCount: 0),
      );
      setState(() {});
    }

    Navigator.pop(context);
  }
}
