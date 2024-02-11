import 'package:flutter/material.dart';
import 'cart_service.dart'; 
import 'activity.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Activity> cartItems = [];

  @override
  void initState() {
    super.initState();
    // Initialiser les éléments du panier
    cartItems = CartService().items;
  }

  double getTotalPrice() {
    return cartItems.fold(0, (total, current) => total + current.price);
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: Text("Mon Panier"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                Activity item = cartItems[index];
                return ListTile(
                  leading: Image.network(item.imageUrl),
                  title: Text(item.title),
                  subtitle: Text("${item.location} - \$${item.price}"),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      CartService().removeItem(item);
                      setState(() {
                        // Mettre à jour l'état pour refléter le changement dans l'interface utilisateur
                        cartItems = CartService().items;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Total: \$${totalPrice.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
