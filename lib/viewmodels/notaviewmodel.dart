import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/nota.dart';
import 'package:firebase_database/firebase_database.dart';

class NotaViewModel extends ChangeNotifier {
  final _dbRef = FirebaseDatabase.instance.ref('notas');

  List<Nota> _notas = [];
  List<Nota> get notas => List.unmodifiable(_notas);

  void create(Nota nota) {
    nota.id = Uuid().v4();

    _dbRef.child(nota.id).set(nota.toJson());
  }

  void delete(String id) {
    _dbRef.child(id).remove();
  }

  void update(Nota nota) {
    _dbRef.child(nota.id).update(nota.toJson());
  }

  void read() {
    _dbRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value == null) {
        _notas = [];
      } else {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        _notas =
            data.entries.map((entry) {
              final notaMap = Map<String, dynamic>.from(entry.value as Map);
              return Nota.fromJson(notaMap);
            }).toList();
      }

      notifyListeners();
    });
  }
}
