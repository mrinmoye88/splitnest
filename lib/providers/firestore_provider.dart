import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firestore_service.dart';
import '../models/expense_model.dart';
import '../models/chore_model.dart';
import '../models/dispute_model.dart';

final firestoreServiceProvider = Provider((ref) => FirestoreService());

final expensesStreamProvider = StreamProvider<List<ExpenseModel>>((ref) {
  return ref.watch(firestoreServiceProvider).getExpenses();
});

final choresStreamProvider = StreamProvider<List<ChoreModel>>((ref) {
  return ref.watch(firestoreServiceProvider).getChores();
});

final disputesStreamProvider = StreamProvider<List<DisputeModel>>((ref) {
  return ref.watch(firestoreServiceProvider).getDisputes();
});