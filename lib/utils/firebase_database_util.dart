import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_diary/models/diary_model.dart';

class FirebaseDatabaseUtil {
  DatabaseReference _diarysRef;
  FirebaseDatabase database = new FirebaseDatabase();
  DatabaseError error;

  static final FirebaseDatabaseUtil _instance =
      new FirebaseDatabaseUtil.internal();
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    _diarysRef =
        database.reference().child('diarys').child(auth.currentUser.uid);
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
  }

  DatabaseError getError() {
    return error;
  }

  DatabaseReference getdiarys() {
    return _diarysRef;
  }

  adddiary(DiaryModel diary) async {
    _diarysRef.push().set(<String, String>{
      "title": diary.title,
      "content": diary.content,
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void deletediary(DiaryModel diary) async {
    await _diarysRef.child(diary.uid).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updatediary(DiaryModel diary) async {
    await _diarysRef.child(diary.uid).update({
      "title": diary.title,
      "content": diary.content,
    }).then((_) {
      print('Transaction  committed.');
    });
  }
}
