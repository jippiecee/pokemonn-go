import 'package:flutter/material.dart';
import 'package:flutter_apps/models/pokemon.dart';

class DetailPage extends StatelessWidget {
  final Pokemon pokemon;

  const DetailPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pokemon.name)),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: Image.asset(pokemon.image),
            ),
          ),
          Text(
            pokemon.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(120), bottomRight:Radius.circular(120),), // Adjust radius here
            ),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Rounded Card'),
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Button'),
          )
        ],
      ),
    );
  }
}
