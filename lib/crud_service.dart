import 'package:cloud_firestore/cloud_firestore.dart';

class CrudService {
  CrudService({FirebaseFirestore? firestore})
    : _items = (firestore ?? FirebaseFirestore.instance).collection('items');

  final CollectionReference<Map<String, dynamic>> _items;

  Stream<QuerySnapshot<Map<String, dynamic>>> getItems() =>
      _items.orderBy('createdAt', descending: false).snapshots();

  Future<void> addItem(String name) async {
    await _items.add({'name': name, 'createdAt': Timestamp.now()});
  }

  Future<void> updateItem(String id, String name) async {
    await _items.doc(id).update({'name': name});
  }

  Future<void> deleteItem(String id) async {
    await _items.doc(id).delete();
  }
}
