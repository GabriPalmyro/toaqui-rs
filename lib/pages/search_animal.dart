import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encontre_sua_crianca/model/animal.dart';
import 'package:encontre_sua_crianca/widgets/card_animal.dart';
import 'package:encontre_sua_crianca/widgets/footer_widget.dart';
import 'package:flutter/material.dart';

class SearchAnimalPage extends StatefulWidget {
  const SearchAnimalPage({super.key});

  @override
  State<SearchAnimalPage> createState() => _SearchAnimalPageState();
}

class _SearchAnimalPageState extends State<SearchAnimalPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Animal> foundAnimals = [];
  List<Animal> displayedAnimals = [];
  int page = 1;
  int numberOfAnimals = 0;

  TextEditingController searchAnimalController = TextEditingController();

  bool isLoading = true;

  void addMoreAnimals() {
    final dif = numberOfAnimals - displayedAnimals.length;
    setState(() {
      displayedAnimals.addAll(
        foundAnimals.sublist(
          (page - 1) * 25,
          dif > 25 ? page * 25 : ((page - 1) * 25 + dif),
        ),
      );
    });
  }

  void _fetchAllAnimalData() {
    setState(() {
      isLoading = true;
    });
    firestore.collection('animals').get().then((snapshot) {
      foundAnimals.clear();
      for (var doc in snapshot.docs) {
        final animal = Animal.fromMap(doc.data());
        foundAnimals.add(animal);
      }
      numberOfAnimals = foundAnimals.length;
      addMoreAnimals();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    _fetchAllAnimalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        if (isLoading) ...{
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        } else if (displayedAnimals.isEmpty) ...{
          const Expanded(
            child: Center(
              child: Text('Nenhum animal encontrado'),
            ),
          ),
        } else ...{
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                'Total de registros: $numberOfAnimals',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[800]),
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              interactive: true,
              trackVisibility: true,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio:  1.2,
                  crossAxisCount: width > 1200
                      ? 3
                      : width < 1200 && width > 800
                          ? 2
                          : 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: displayedAnimals.length,
                itemBuilder: (context, index) {
                  final animal = displayedAnimals[index];
                  return CardAnimal(animal: animal);
                },
              ),
            ),
          ),
          if (displayedAnimals.length < numberOfAnimals) ...{
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  page++;
                });
                addMoreAnimals();
              },
              child: const Text('Carregar mais'),
            ),
          },
          const SizedBox(height: 12),
          const FooterWidget(),
        }
      ],
    );
  }
}
