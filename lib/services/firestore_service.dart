import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense_model.dart';
import '../models/chore_model.dart';
import '../models/dispute_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- Expenses ---
  Stream<List<ExpenseModel>> getExpenses() {
    return _db.collection('expenses').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ExpenseModel.fromMap(doc.id, doc.data())).toList());
  }

  Future<void> addExpense(ExpenseModel expense) async {
    await _db.collection('expenses').add(expense.toMap());
  }

  // --- Chores ---
  Stream<List<ChoreModel>> getChores() {
    return _db.collection('chores').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ChoreModel.fromMap(doc.id, doc.data())).toList());
  }

  Future<void> toggleChoreStatus(String choreId, bool isDone) async {
    await _db.collection('chores').doc(choreId).update({'isDone': isDone});
  }

  // --- Disputes ---
  Stream<List<DisputeModel>> getDisputes() {
    return _db.collection('disputes').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => DisputeModel.fromMap(doc.id, doc.data())).toList());
  }
}