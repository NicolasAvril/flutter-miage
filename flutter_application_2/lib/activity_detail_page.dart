import 'package:flutter/material.dart';
import 'activity.dart';
import 'cart_service.dart'; 

class ActivityDetailPage extends StatelessWidget {
  final Activity activity;

  ActivityDetailPage({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activity.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: <Widget>[
          Image.network(activity.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(activity.title,
                style: Theme.of(context).textTheme.headline6),
          ),
          Text('Catégorie: ${activity.category}'),
          Text('Lieu: ${activity.location}'),
          Text('Nombre minimum de personnes: ${activity.minParticipants}'),
          Text('Prix: \$${activity.price}'),
          ElevatedButton(
            child: Text('Ajouter au panier'),
            onPressed: () {
              // Logique pour ajouter l'activité au panier
              CartService().addItem(activity);
              // Afficher un message de confirmation
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Activité ajoutée au panier')),
              );
            },
          ),
        ],
      ),
    );
  }
}
