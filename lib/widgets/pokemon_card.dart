import 'package:flutter/material.dart';
import 'package:flutter_apps/models/pokemon.dart';

import '../pages/detail_page.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {

    // function intent ke detail_page
    void detailPage(Pokemon pokemon) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => DetailPage(pokemon: pokemon)),
      );
    }

    return InkWell(
      onTap: (){
        detailPage(pokemon);
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
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
          ],
        ),
      ),
    );
  }
}
