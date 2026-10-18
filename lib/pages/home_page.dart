import 'package:flutter/material.dart';
import 'package:flutter_apps/data/pokemon_data.dart';
import 'package:flutter_apps/models/pokemon.dart';
import 'package:flutter_apps/widgets/pokemon_card.dart';
import 'package:flutter_apps/widgets/pokemon_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Pokemon> pokemon = dataPokemon;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(title: Text("Pokemon GO`"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return PokemonList(pokemon: pokemon[index]);
              },
              itemCount: pokemon.length,
            ),
          ),
        ],
      ),
    );
  }
}
