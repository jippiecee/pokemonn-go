import 'package:flutter/material.dart';
import 'package:flutter_apps/data/pokemon_data.dart';
import 'package:flutter_apps/models/pokemon.dart';
import 'package:flutter_apps/pages/detail_page.dart';
import 'package:flutter_apps/widgets/pokemon_card.dart';
import 'package:flutter_apps/widgets/pokemon_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Pokemon> pokemon = dataPokemon;
  String q = "";
  bool favOnly = false;
  final Set<String> favs = {};
  final TextEditingController sc = TextEditingController();

  void toggleFav(String name) {
    setState(() {
      if (favs.contains(name)) { favs.remove(name); } else { favs.add(name); }
    });
  }

  Future<void> bukaDetail(Pokemon pokemon, bool isFavorite) async {
    final res = await Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(pokemon: pokemon, type: pokemon.type, isFavorite: isFavorite)));
    if (res != null) {
      setState(() {
        if (res) { favs.add(pokemon.name); } else { favs.remove(pokemon.name); }
      });
    }
  }

  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    var ss = MediaQuery.of(context).size;

    final hasil = dataPokemon.where((p) {
      final k = q.toLowerCase();
      final cocok = p.name.toLowerCase().contains(k);
      final cocokFav = !favOnly || favs.contains(p.name);
      return cocok && cocokFav;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Pokémon GO", style: TextStyle(fontFamily: "Pokemon", fontSize: 32, color: Colors.amber)),
        centerTitle: true,
        actions: [Text('$ss')],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: sc,
                onChanged: (v) { setState(() { q = v; }); },
                decoration: InputDecoration(
                    hintText: "Search Pokemon",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Switch(value: favOnly, onChanged: (v) { setState(() { favOnly = v; }); }),
          ]),
        ),
        Expanded(
          child: LayoutBuilder(builder: (context, c) {
            if (c.maxWidth <= 504) {
              return ListView.builder(
                itemBuilder: (context, i) {
                  final pk = hasil[i];
                  final f = favs.contains(pk.name);
                  return PokemonList(
                    pokemon: pk,
                    isFavorite: f,
                    onTap: () { bukaDetail(pk, f); },
                    onFavoriteTap: () { toggleFav(pk.name); },
                    type: pk.type,
                  );
                },
                itemCount: hasil.length,
              );
            } else {
              int col = 2;
              if (c.maxWidth >= 768 && c.maxWidth < 1024) { col = 3; }
              if (c.maxWidth >= 1024) col = 4;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: col, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 3 / 4),
                itemBuilder: (context, i) {
                  final pk = hasil[i];
                  final f = favs.contains(pk.name);
                  return PokemonCard(
                    pokemon: pk,
                    type: hasil[i].type,
                    isFavorite: f,
                    onTap: () => bukaDetail(pk, f),
                    onFavoriteTap: () => toggleFav(pk.name),
                  );
                },
                itemCount: hasil.length,
              );
            }
          }),
        ),
      ]),
    );
  }
}