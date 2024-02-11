import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';
import 'add_activity_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;
  TextEditingController? _birthdayController;
  TextEditingController? _addressController;
  TextEditingController? _postalCodeController;
  TextEditingController? _cityController;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    _birthdayController = TextEditingController();
    _addressController = TextEditingController();
    _postalCodeController = TextEditingController();
    _cityController = TextEditingController();
    loadUserProfile();
  }

  void loadUserProfile() async {
    if (user != null) {
      var userData = await _firestore.collection('users').doc(user!.uid).get();
      var data = userData.data();
      if (data != null) {
        _birthdayController?.text = data['birthday'] ?? '';
        _addressController?.text = data['address'] ?? '';
        _postalCodeController?.text = data['postalCode'] ?? '';
        _cityController?.text = data['city'] ?? '';
      }
    }
  }

  void saveUserProfile() async {
    if (user != null) {
      await _firestore.collection('users').doc(user!.uid).set({
        'birthday': _birthdayController?.text,
        'address': _addressController?.text,
        'postalCode': _postalCodeController?.text,
        'city': _cityController?.text,
      }, SetOptions(merge: true)).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profil mis à jour avec succès')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de mise à jour: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Login (readonly): ${user?.email ?? 'Non connecté'}'),
              TextFormField(
                decoration: InputDecoration(labelText: 'Anniversaire'),
                controller: _birthdayController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Adresse'),
                controller: _addressController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Code Postal'),
                keyboardType: TextInputType.number,
                controller: _postalCodeController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ville'),
                controller: _cityController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveUserProfile,
                child: Text('Valider'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddActivityPage()));
                },
                child: Text('Ajouter une nouvelle activité'),
              ),
              ElevatedButton(
                onPressed: () {
                  _auth.signOut().then((_) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      ModalRoute.withName('/'),
                    );
                  });
                },
                child: Text('Se déconnecter'),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
