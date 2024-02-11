import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddActivityPage extends StatefulWidget {
  @override
  _AddActivityPageState createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _minPeopleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _saveActivity() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('activities').add({
        'url': _imageUrlController.text,
        'title': _titleController.text,
        'category': _categoryController.text,
        'place': _locationController.text,
        'minpeople': int.parse(_minPeopleController.text),
        'price': double.parse(_priceController.text),
      });

      Navigator.of(context)
          .pop(); // Retourner à la page précédente après l'ajout
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une nouvelle activité'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Image URL'),
                  controller: _imageUrlController,
                  validator: (value) =>
                      value!.isEmpty ? 'Ce champ est requis' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Titre'),
                  controller: _titleController,
                  validator: (value) =>
                      value!.isEmpty ? 'Ce champ est requis' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Catégorie'),
                  controller: _categoryController,
                  validator: (value) =>
                      value!.isEmpty ? 'Ce champ est requis' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Lieu'),
                  controller: _locationController,
                  validator: (value) =>
                      value!.isEmpty ? 'Ce champ est requis' : null,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Nombre de personnes minimum'),
                  controller: _minPeopleController,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Ce champ est requis' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Prix'),
                  controller: _priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) =>
                      value!.isEmpty ? 'Ce champ est requis' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveActivity,
                  child: Text('Valider'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
