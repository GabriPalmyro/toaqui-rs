import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encontre_sua_crianca/model/person.dart';
import 'package:encontre_sua_crianca/widgets/card_person.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchPersonPage extends StatefulWidget {
  const SearchPersonPage({super.key});

  @override
  State<SearchPersonPage> createState() => _SearchPersonPageState();
}

class _SearchPersonPageState extends State<SearchPersonPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Person> foundPersons = [];
  List<Person> displayedPersons = [];
  int page = 1;
  int numberOfRegisters = 0;

  TextEditingController searchController = TextEditingController();
  ScrollController scolController = ScrollController();

  bool isLoading = true;
  bool isPaginating = true;

  void addMorePersons() {
    final dif = numberOfRegisters - displayedPersons.length;
    setState(() {
      displayedPersons.addAll(
        foundPersons.sublist(
          (page - 1) * 25,
          dif > 25 ? page * 25 : ((page - 1) * 25 + dif),
        ),
      );
    });
  }

  void _fetchAllData() {
    setState(() {
      isLoading = true;
    });
    firestore.collection('pessoas').get().then((snapshot) {
      foundPersons.clear();
      for (var doc in snapshot.docs) {
        final person = Person.fromMap(doc.data());
        foundPersons.add(person);
      }
      numberOfRegisters = foundPersons.length;
      addMorePersons();
      setState(() {
        isLoading = false;
      });
    });
  }

  void _fetchFilteredData([
    String searchText = '',
  ]) {
    setState(() {
      isLoading = true;
    });
    displayedPersons.clear();
    for (var person in foundPersons) {
      if (person.name.toLowerCase().contains(searchText.toLowerCase()) ||
          (person.age ?? '').toString().contains(searchText) ||
          (person.location ?? '').toLowerCase().contains(searchText.toLowerCase()) ||
          (person.contactPhone ?? '').contains(searchText)) {
        displayedPersons.add(person);
      }
    }
    numberOfRegisters = displayedPersons.length;
    addMorePersons();
    setState(() {
      isLoading = false;
    });
  }

  void _resetPagination() {
    setState(() {
      page = 1;
      displayedPersons.clear();
      isPaginating = true;
    });
  }

  void _searchPerson(String searchText) {
    _resetPagination();
    if (searchController.text.isNotEmpty) {
      isPaginating = false;
      _fetchFilteredData(searchController.text);
    } else {
      isPaginating = true;
      _fetchAllData();
    }
  }

  @override
  void initState() {
    _fetchAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: _searchPerson,
                  decoration: InputDecoration(
                    labelText: 'Procurar',
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextButton(
                        onPressed: () {
                          _searchPerson(searchController.text);
                        },
                        child: Text(
                          'Buscar',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Theme.of(context).primaryColor,
                ),
                splashColor: Theme.of(context).primaryColor,
                onPressed: () {
                  searchController.clear();
                  _resetPagination();
                  _fetchAllData();
                },
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text(
            'Busque pelo nome e encontre a pessoas que foram salvas e estão em abrigos após as enchentes no RS.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        if (isLoading) ...{
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        } else if (displayedPersons.isEmpty) ...{
          const Expanded(
            child: Center(
              child: Text('Nenhuma pessoa encontrada'),
            ),
          ),
        } else ...{
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                'Total de registros: $numberOfRegisters',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[800]),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedPersons.length,
              itemBuilder: (context, index) {
                final person = displayedPersons[index];
                return (!person.isTest || !kDebugMode) ? CardPerson(person: person) : const SizedBox();
              },
            ),
          ),
          if (displayedPersons.length < numberOfRegisters) ...{
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  page++;
                });
                addMorePersons();
              },
              child: const Text('Carregar mais'),
            ),
          },
          const SizedBox(height: 12),
        },
      ],
    );
  }
}
