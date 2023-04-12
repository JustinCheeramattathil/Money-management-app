import '../../../models/category/category_model.dart';
import '../../../models/transaction/transaction_model.dart';
import 'package:hive/hive.dart';

const TRANSACTION_DB_NAME = 'transactio-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _db.put(obj.id, obj);
  }
}
