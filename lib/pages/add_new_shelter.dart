import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encontre_sua_crianca/model/shelter.dart';
import 'package:encontre_sua_crianca/pages/select_location_page.dart';
import 'package:encontre_sua_crianca/widgets/footer_widget.dart';
import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';

class AddNewShelterPage extends StatefulWidget {
  const AddNewShelterPage({super.key});

  @override
  State<AddNewShelterPage> createState() => _AddNewShelterPageState();
}

class _AddNewShelterPageState extends State<AddNewShelterPage> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  final TextEditingController _shelterNameController = TextEditingController();
  GeocodingResult? _locationResult;
  List<String> _shelterNeedsSelected = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> _sheltersNeeds = [
    'Ração',
    'Medicamentos',
    'Roupas',
    'Brinquedos',
    'Cobertores',
    'Produtos de limpeza',
    'Produtos de higiene',
    'Materiais de construção',
    'Móveis',
    'Eletrodomésticos',
    'Powerbanks',
    'Dinheiro',
    'Outros',
  ];

  List<Shelter> _shelters = [];

  void _addNewShelter() async {
    final String shelterName = _shelterNameController.text;
    final String locationName = _locationResult!.formattedAddress!;
    final double latitude = _locationResult!.geometry.location.lat;
    final double longitude = _locationResult!.geometry.location.lng;

    final Shelter shelter = Shelter(
      name: shelterName,
      location: locationName,
      latitude: latitude,
      longitude: longitude,
      needs: _shelterNeedsSelected,
    );

    final DocumentReference shelterRef = _firestore.collection('shelters').doc();
    await shelterRef.set(shelter.toMap());
    setState(() {
      _shelters.add(shelter);
    });
    _resetFields();
  }

  void _getAllShelters() async {
    final QuerySnapshot querySnapshot = await _firestore.collection('shelters').get();
    final List<Shelter> shelters = querySnapshot.docs.map((doc) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Shelter.fromMap(data);
    }).toList();
    setState(() {
      _shelters = shelters;
    });
  }

  void _resetFields() {
    _shelterNameController.clear();
    setState(() {
      _locationResult = null;
      _shelterNeedsSelected.clear();
    });
  }

  @override
  void initState() {
    _getAllShelters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const SizedBox(height: 18),
          TextFormField(
            controller: _shelterNameController,
            decoration: const InputDecoration(
              labelText: 'Nome do Abrigo',
              hintText: 'Informe o nome do abrigo',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Necessidades do Abrigo:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _sheltersNeeds
                .map(
                  (need) => FilterChip(
                    label: Text(need),
                    selected: _shelterNeedsSelected.contains(need),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _shelterNeedsSelected.add(need);
                        } else {
                          _shelterNeedsSelected.remove(need);
                        }
                      });
                    },
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    final GeocodingResult? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectLocationPage(
                          onNext: (result) {
                            Navigator.pop(context, result);
                          },
                        ),
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        _locationResult = result;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                    maximumSize: const Size(double.infinity, 40),
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFff5757),
                  ),
                  child: const Text('Adicionar Localização'),
                ),
              ),
              if (_locationResult != null) ...[
                const SizedBox(width: 12),
                Expanded(child: Text(_locationResult!.formattedAddress!)),
              ],
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (_locationResult != null) {
                _addNewShelter();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor, selecione a localização do abrigo.'),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 60),
              maximumSize: const Size(double.infinity, 60),
              backgroundColor: const Color(0xFFff5757),
              textStyle: const TextStyle(color: Colors.white),
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Cadastrar Novo Abrigo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(),
          // maps of all shelters
          const Text(
            'Abrigos Cadastrados',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 400,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(target: LatLng(-30.033056, -51.230000), zoom: 11),
              markers: _shelters
                  .map(
                    (shelter) => Marker(
                      markerId: MarkerId(shelter.name),
                      position: LatLng(shelter.latitude, shelter.longitude),
                      infoWindow: InfoWindow(
                        title: '${shelter.name} - ${shelter.needs.join(', ')}',
                        snippet: shelter.location,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Necessidades: ${shelter.needs.join(', ')}'),
                                  const SizedBox(height: 4),
                                  Text('Localização: ${shelter.location}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                  .toSet(),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          const SizedBox(height: 24),
          const FooterWidget(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
