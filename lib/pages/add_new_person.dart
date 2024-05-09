// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encontre_sua_crianca/model/person.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewPersonPage extends StatefulWidget {
  const AddNewPersonPage({Key? key}) : super(key: key);

  @override
  State<AddNewPersonPage> createState() => _AddNewPersonPageState();
}

class _AddNewPersonPageState extends State<AddNewPersonPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _contactPhoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _observationsController = TextEditingController();
  final TextEditingController _physicalCharacteristicsController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();

  String? photoUrl;
  XFile? photoFile;

  bool isLoading = false;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes = List<FocusNode>.generate(9, (index) => FocusNode());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _parentNameController.dispose();
    _cityController.dispose();
    _contactPhoneController.dispose();
    _locationController.dispose();
    _observationsController.dispose();
    _physicalCharacteristicsController.dispose();
    _adressController.dispose();
    _focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  void _requestFocus(int index) {
    FocusScope.of(context).requestFocus(_focusNodes[index]);
  }

  void _sendNewPerson() async {
    setState(() {
      isLoading = true;
    });

    final now = DateTime.now();

    if (photoFile != null) {
      await uploadFile(photoFile!).then((value) {
        photoUrl = value;
      });
    }

    Person person = Person(
      name: _nameController.text,
      age: _ageController.text,
      city: _cityController.text,
      contactPhone: _contactPhoneController.text,
      location: _locationController.text,
      adress: _adressController.text,
      observations: _observationsController.text,
      parentName: _parentNameController.text,
      photoUrl: photoUrl,
      createdAt: now,
    );

    try {
      await firestore.collection('pessoas').add(person.toMap());
      _resetFields();
      setState(() {
        isLoading = false;
      });
      _showSnackbar('Pessoa cadastrada com sucesso', true);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showSnackbar('Erro ao cadastrar pessoa', false);
    }
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );

    if (pickedFile != null) {
      setState(() {
        photoFile = pickedFile;
      });
    } else {
      log('No image selected.');
    }
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 40,
    );

    if (pickedFile != null) {
      setState(() {
        photoFile = pickedFile;
      });
    } else {
      print('No image selected.');
    }
  }

  Future<String?> uploadFile(XFile file) async {
    try {
      var snapshot = await storage.ref().child('fotos/${_nameController.text}_${DateTime.now().millisecondsSinceEpoch}').putData(
            await (file.readAsBytes()),
            SettableMetadata(contentType: 'image/jpeg'),
          );
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      log('Erro ao fazer upload da imagem: $e');
      return null;
    }
  }

  _resetFields() {
    _nameController.clear();
    _ageController.clear();
    _parentNameController.clear();
    _cityController.clear();
    _contactPhoneController.clear();
    _locationController.clear();
    _observationsController.clear();
    _physicalCharacteristicsController.clear();
    _adressController.clear();
    photoUrl = null;
    photoFile = null;
  }

  _showSnackbar(String message, bool isSucess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: isSucess ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _nameController,
                  focusNode: _focusNodes[0],
                  decoration: const InputDecoration(
                    labelText: 'Nome Completo (Obrigatório)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onEditingComplete: () => _requestFocus(1),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _ageController,
                  focusNode: _focusNodes[1],
                  decoration: const InputDecoration(
                    labelText: 'Idade',
                    hintText: 'Informe a idade da pessoa desaparecida (ou data de nascimento)',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: () => _requestFocus(2),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _parentNameController,
                  focusNode: _focusNodes[2],
                  decoration: const InputDecoration(
                    labelText: 'Nome Pai/Nome Mãe ou de um responsável',
                    hintText: 'Informe o nome do pai, mãe ou responsável',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: () => _requestFocus(3),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _cityController,
                  focusNode: _focusNodes[3],
                  decoration: const InputDecoration(
                    labelText: 'Cidade',
                    hintText: 'Informe a cidade de onde a pessoa morava',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: () => _requestFocus(4),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _contactPhoneController,
                  focusNode: _focusNodes[4],
                  decoration: const InputDecoration(
                    labelText: 'Telefone do Responsável',
                    hintText: 'Informe um telefone para contato do responsável pela pessoa desaparecida',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: () => _requestFocus(5),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _locationController,
                  focusNode: _focusNodes[5],
                  decoration: const InputDecoration(
                    labelText: 'Local de Abrigo',
                    hintText: 'Informe o local onde a pessoa está',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: () => _requestFocus(6),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _adressController,
                  focusNode: _focusNodes[6],
                  decoration: const InputDecoration(
                    labelText: 'Endereço do abrigo',
                    hintText: 'Forneça se tiver, para facilitar a localização',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: () => _requestFocus(7),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _physicalCharacteristicsController,
                  focusNode: _focusNodes[7],
                  decoration: const InputDecoration(
                    labelText: 'Características Fisicas',
                    hintText: 'Informe características físicas da pessoa desaparecida',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: () => _requestFocus(8),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _observationsController,
                  focusNode: _focusNodes[8],
                  decoration: const InputDecoration(
                    labelText: 'Observações Adicionais',
                    hintText: 'Informe outras informações relevantes que possam ajudar na localização da pessoa desaparecida',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: () => _sendNewPerson(),
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () async {
                    if (MediaQuery.of(context).size.width > 1200) {
                      imgFromGallery();
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Escolher uma opção'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.photo_library),
                                  title: const Text('Escolher da Galeria'),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    imgFromGallery();
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text('Tirar uma foto'),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    imgFromCamera();
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancelar'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Adicionar Foto'),
                ),
                const SizedBox(height: 12),
                if (photoFile != null)
                  Image.network(
                    photoFile!.path,
                    width: 200,
                    height: 200,
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _sendNewPerson();
                    } else {
                      _showSnackbar('Preencha todos os campos obrigatórios', false);
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
                    'Cadastrar Nova Pessoa',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Color(0xFFff5757),
              ),
            ),
          ),
      ],
    );
  }
}
