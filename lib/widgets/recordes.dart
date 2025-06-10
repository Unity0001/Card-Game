import 'package:cardgame/constants.dart';
import 'package:cardgame/pages/recordes_page.dart';
import 'package:cardgame/theme.dart';
import 'package:flutter/material.dart';

class Recordes extends StatefulWidget {
  const Recordes({super.key});

  @override
  State<Recordes> createState() => _RecordesState();
}

class _RecordesState extends State<Recordes> {
  showRecordes(Modo modo) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => RecordesPage(modo: modo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final listTileHeight = screenHeight * 0.07;
    final iconSize = screenHeight * 0.03; 

    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                'Recordes',
                style: TextStyle(
                  color: PokemonTheme.color,
                  fontSize: screenHeight * 0.04, 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(
              width: screenWidth * 1.9,
              height: listTileHeight,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Modo Normal',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(Icons.chevron_right, size: iconSize),
                onTap: () => showRecordes(Modo.normal),
              ),
            ),

            SizedBox(
              width: screenWidth * 0.9,
              height: listTileHeight,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Modo Pokemon',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(Icons.chevron_right, size: iconSize),
                onTap: () => showRecordes(Modo.pokemon),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
