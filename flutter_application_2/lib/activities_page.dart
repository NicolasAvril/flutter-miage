import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'activity.dart';
import 'activity_detail_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';

class ActivitiesPage extends StatefulWidget {
  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<String> categories = [
    'Tous',
    'Sport',
    'Shopping',
    'Ludique'
  ]; // Ajout si besoin

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: categories.length);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future<List<Activity>> fetchActivities(String category) async {
    QuerySnapshot querySnapshot;
    if (category == 'Tous') {
      querySnapshot =
          await FirebaseFirestore.instance.collection('activities').get();
    } else {
      querySnapshot = await FirebaseFirestore.instance
          .collection('activities')
          .where('category', isEqualTo: category)
          .get();
    }

    return querySnapshot.docs.map((doc) {
      return Activity.fromFirestore(doc);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Activités', style: TextStyle(color: theme.primaryColorLight)),
        backgroundColor: Colors.deepPurple[400],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.amber[700],
          labelColor: theme.primaryColorLight,
          unselectedLabelColor: Colors.brown[300],
          tabs:
              categories.map((String category) => Tab(text: category)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categories.map((String category) {
          return FutureBuilder<List<Activity>>(
            future: fetchActivities(category),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Erreur de chargement: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('Aucune activité trouvée'));
              } else {
                List<Activity> activities = snapshot.data!;
                return ListView.builder(
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    var activity = activities[index];
                    return ListTile(
                      leading: Image.network(activity.imageUrl,
                          width: 100, height: 100, fit: BoxFit.cover),
                      title: Text(activity.title,
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 53, 11))),
                      subtitle: Text(
                          '${activity.location} - \$${activity.price.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.deepPurple[300])),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ActivityDetailPage(activity: activity)));
                      },
                    );
                  },
                );
              }
            },
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Activités'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Panier'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CartPage()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
        break;
      default:
        break;
    }
  }
}

extension on Activity {
  static Activity fromFirestore(Map<String, dynamic> data) {
    return Activity(
      imageUrl: data['url'],
      title: data['title'],
      location: data['place'],
      price: data['price'],
      category: data['category'],
      minParticipants: data['minpeople'],
    );
  }
}
