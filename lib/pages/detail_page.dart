import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apps/models/pokemon.dart';
import 'package:flutter_apps/widgets/type_chip.dart';

class DetailPage extends StatefulWidget {
  final Pokemon pokemon;
  final String type;
  final bool isFavorite;

  const DetailPage({super.key, required this.pokemon, required this.type, required this.isFavorite});

  Color warna() {
    if (type.contains('Water')) return Colors.blue;
    if (type.contains('Poison')) return Colors.purple;
    if (type.contains("Grass")) return Colors.green;
    if (type.contains('Electric')) return Colors.amber;
    if (type.contains("Dragon")) return Colors.indigo;
    if (type.contains('Fire')) return Colors.red;
    if (type.contains('Ice')) return Colors.teal;
    if (type.contains("Normal")) return Colors.grey;
    if (type.contains('Fighting')) return Colors.orange;
    return Colors.amber;
  }

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool fav;
  bool bisaPop = false;
  int cur = 0;
  final CarouselSliderController ctrl = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    fav = widget.isFavorite;
  }

  void balik() {
    if (bisaPop) return;
    setState(() { bisaPop = true; });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) { Navigator.pop(context, fav); }
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.pokemon;

    return PopScope(
      canPop: bisaPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        balik();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(p.name, style: TextStyle(fontFamily: 'Pokemon', fontWeight: FontWeight.w900, fontSize: 32)),
          leading: IconButton(onPressed: balik, icon: Icon(Icons.arrow_back_outlined)),
          backgroundColor: widget.warna().withOpacity(0.2),
          actions: [
            IconButton(
                onPressed: () { setState(() { fav = !fav; }); },
                icon: fav ? Icon(Icons.favorite, color: Colors.pink) : Icon(Icons.favorite_border_rounded, color: Colors.grey)),
            SizedBox(width: 15),
          ],
          centerTitle: true,
        ),
        body: LayoutBuilder(builder: (context, c) {
          if (c.maxWidth > 768) {
            return Row(children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                    tag: p.name,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(p.image, fit: BoxFit.cover))),
              )),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(p.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black, fontFamily: "Poppins")),
                      SizedBox(height: 15),
                      TypeChip(type: p.type),
                      SizedBox(height: 15),
                      Text('Base Power: ${p.basePower}', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: "Poppins")),
                      SizedBox(height: 15),
                      Text('Deskripsi', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, fontFamily: "Poppins")),
                      SizedBox(height: 3),
                      Text(p.description, textAlign: TextAlign.justify, style: TextStyle(fontSize: 15)),
                      SizedBox(height: 15),
                      Text('Skill', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Row(children: [
                        Wrap(
                            children: p.skills
                                .map((e) => Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), topLeft: Radius.circular(30)),
                                          border: Border.all(color: widget.warna(), width: 2, style: BorderStyle.solid)),
                                      child: Row(children: [Icon(Icons.star), SizedBox(width: 5), Text(e)]),
                                    ))
                                .toList()),
                      ]),
                      SizedBox(height: 5),
                      CarouselSlider.builder(
                        options: CarouselOptions(aspectRatio: 2.0, enlargeCenterPage: false, viewportFraction: 1),
                        itemCount: p.movies.length ~/ 2,
                        itemBuilder: (context, i, r) {
                          final a = i * 2;
                          final b = a + 1;
                          return Row(
                              children: [a, b].map((x) {
                            return Expanded(
                                flex: 1,
                                child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    child: Image.network(p.movies[x], fit: BoxFit.cover)));
                          }).toList());
                        },
                      ),
                    ]),
                  ),
                ),
              ),
            ]);
          } else {
            return SingleChildScrollView(
              child: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(p.image))),
                Container(
                  margin: EdgeInsetsDirectional.only(start: 14, end: 14, top: 20),
                  padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(10.0)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(p.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black)),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: Colors.blue, width: 1, style: BorderStyle.solid)),
                      child: Text(p.type, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 15),
                    Text('Base Power: ${p.basePower}', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black)),
                    SizedBox(height: 15),
                    Text('Deskripsi', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                    SizedBox(height: 3),
                    Text(p.description, textAlign: TextAlign.justify, style: TextStyle(fontSize: 15)),
                    SizedBox(height: 15),
                    Text('Skill', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Wrap(
                        children: p.skills
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(width: 0.1, color: Colors.black, style: BorderStyle.solid)),
                                    child: Row(children: [Icon(Icons.star), SizedBox(width: 5), Text(e)]),
                                  ),
                                ))
                            .toList()),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      child: CarouselSlider(
                        items: p.movies.map((m) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: ClipRRect(borderRadius: BorderRadius.circular(25), child: Image.network(m, fit: BoxFit.cover)),
                            );
                          });
                        }).toList(),
                        carouselController: ctrl,
                        options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            onPageChanged: (i, reason) { setState(() { cur = i; }); }),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: p.movies.asMap().entries.map((en) {
                        return GestureDetector(
                          onTap: () => ctrl.animateToPage(en.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                                    .withValues(alpha: cur == en.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                  ]),
                ),
              ]),
            );
          }
        }),
      ),
    );
  }
}