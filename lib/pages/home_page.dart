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
    var screenSize = MediaQuery.of(
      context,
    ).size; //mengatahui resolusi layar device

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pokémon GO",
          style: TextStyle(
            fontFamily: "Pokemon",
            fontSize: 32,
            color: Colors.amber,
          ),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.favorite_border_rounded),
          SizedBox(width: 15,)
        ],
          // Text('$screenSize')
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                //425 Mobile
                //768 Tablet
                //1024 Desktop
                if (constraints.maxWidth <= 425) {
                  return ListView.builder(
                    itemBuilder: (context, index) =>
                        PokemonList(pokemon: pokemon[index]),
                    itemCount: pokemon.length,
                  );
                } else if (constraints.maxWidth <= 768) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return PokemonCard(pokemon: pokemon[index], type: pokemon[index].type,);
                    },
                    itemCount: pokemon.length,
                  );
                } else {
                  return GridView.builder(
                    itemBuilder: (context, index) =>
                        PokemonCard(pokemon: pokemon[index], type: pokemon[index].type,),
                    itemCount: pokemon.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
