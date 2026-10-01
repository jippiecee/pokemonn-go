import 'package:flutter/material.dart';
import 'package:flutter_apps/widgets/type_chip.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Hero(
              tag: "pokemon-image",
              child: Image.asset(
                "assets/bulbasaur.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Text("Bulbasaur")),
                  TypeChip()
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
