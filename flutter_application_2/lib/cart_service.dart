import 'activity.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<Activity> _items = [];

  List<Activity> get items => _items;

  void addItem(Activity item) {
    _items.add(item);
  }

  void removeItem(Activity item) {
    _items.remove(item);
  }
}
