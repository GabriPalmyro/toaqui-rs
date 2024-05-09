// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encontre_sua_crianca/model/animal.dart';
import 'package:encontre_sua_crianca/widgets/footer_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewAnimalPage extends StatefulWidget {
  const AddNewAnimalPage({super.key});

  @override
  State<AddNewAnimalPage> createState() => _AddNewAnimalPageState();
}

class _AddNewAnimalPageState extends State<AddNewAnimalPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _animalNameController = TextEditingController();
  final TextEditingController _contactPhoneController = TextEditingController();
  final TextEditingController _shelterLocationController = TextEditingController();
  final TextEditingController _additionalInfoController = TextEditingController();
  final TextEditingController _physicalCharacteristicsController = TextEditingController();

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
    _focusNodes = List<FocusNode>.generate(6, (index) => FocusNode());
  }

  @override
  void dispose() {
    _animalNameController.dispose();
    _contactPhoneController.dispose();
    _shelterLocationController.dispose();
    _additionalInfoController.dispose();
    _physicalCharacteristicsController.dispose();
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _requestFocus(int index) {
    FocusScope.of(context).requestFocus(_focusNodes[index]);
  }

  void _sendNewAnimal() async {
    setState(() {
      isLoading = true;
    });

    final now = DateTime.now();

    if (photoFile != null) {
      await uploadFile(photoFile!).then((value) {
        photoUrl = value;
      });
    }

    Animal animal = Animal(
      name: _animalNameController.text,
      location: _shelterLocationController.text,
      phone: _contactPhoneController.text,
      photo: photoUrl,
      createdAt: now,
    );

    try {
      await firestore.collection('animals').add(animal.toMap());
      _resetFields();
      setState(() {
        isLoading = false;
      });
      _showSnackbar('Animal cadastrado com sucesso', true);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showSnackbar('Erro ao cadastrar animal', false);
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
    }
  }

  Future<String?> uploadFile(XFile file) async {
    try {
      var snapshot = await storage.ref().child('dogs/${_animalNameController.text}_${DateTime.now().millisecondsSinceEpoch}').putData(
            await (file.readAsBytes()),
            SettableMetadata(contentType: 'image/jpeg'),
          );
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  _resetFields() {
    _animalNameController.clear();
    _contactPhoneController.clear();
    _shelterLocationController.clear();
    _additionalInfoController.clear();
    _physicalCharacteristicsController.clear();
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
                  controller: _animalNameController,
                  focusNode: _focusNodes[0],
                  decoration: const InputDecoration(
                    labelText: 'Nome do Animal',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: () => _requestFocus(1),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _contactPhoneController,
                  focusNode: _focusNodes[1],
                  decoration: const InputDecoration(
                    labelText: 'Telefone do Responsável',
                    hintText: 'Informe um telefone para contato do responsável pelo animal',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: () => _requestFocus(2),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _shelterLocationController,
                  focusNode: _focusNodes[2],
                  decoration: const InputDecoration(
                    labelText: 'Endereço do Abrigo',
                    hintText: 'Forneça o endereço do abrigo, se disponível',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: () => _requestFocus(3),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _physicalCharacteristicsController,
                  focusNode: _focusNodes[3],
                  decoration: const InputDecoration(
                    labelText: 'Características Físicas',
                    hintText: 'Informe as características físicas do animal',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: () => _requestFocus(4),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _additionalInfoController,
                  focusNode: _focusNodes[4],
                  decoration: const InputDecoration(
                    labelText: 'Informações Adicionais',
                    hintText: 'Informe outras informações relevantes sobre o animal',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: () => _sendNewAnimal(),
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
                      if (photoFile != null) {
                        _sendNewAnimal();
                      } else {
                        _showSnackbar('Adicione uma foto do animal para identificação', false);
                      }
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
                    'Cadastrar Novo Animal',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 24),
                const FooterWidget(),
                const SizedBox(height: 32),
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
