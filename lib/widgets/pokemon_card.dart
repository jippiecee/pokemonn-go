import 'package:flutter/material.dart';
import 'package:flutter_apps/models/pokemon.dart';
import 'package:flutter_apps/pages/detail_page.dart';
import 'package:flutter_apps/widgets/type_chip.dart';

class PokemonCard extends StatelessWidget {
  //properties
  final Pokemon pokemon;

  //constructor
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {

    void detailPage(Pokemon) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailPage(pokemon: pokemon)),
      );
    }

    return InkWell(
      onTap: () {
        detailPage(Pokemon);
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Hero(
              tag: pokemon.name,
              child: Image.asset(
                pokemon.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Text(pokemon.name)),
                  TypeChip(type: pokemon.type),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
