import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ngo_happy_to_help/screens/delete_thought.dart';

class Database {
  final CollectionReference _reference =
      Firestore.instance.collection('images');

  Future<List<dynamic>> userData() async {
    ImageData u;
    await _reference.document('1').get().then((DocumentSnapshot snapshot) {
      // print(snapshot.data['images']);
      u = ImageData(images: snapshot.data['images']);
    }).catchError((onError) {
      print(onError);
      return null;
    });
    print(u.images.runtimeType);
    return u.images;
  }

  Future suggestionUpload(String name, String email, String suggestion) async {
    CollectionReference _ref = Firestore.instance.collection('suggestion');
    try {
      await _ref.document().setData({
        "name": name,
        "email": email,
        "suggestion": suggestion,
        "created": FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }

  Future donarListUpload(String name, String amount, bool pay) async {
    CollectionReference _ref = Firestore.instance.collection('donation');
    try {
      await _ref.document().setData({
        "name": name,
        "amount": amount,
        "pay": pay,
        "created": FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }

  Future deleteEvent(String uid) async {
    CollectionReference _ref = Firestore.instance.collection('ngo');
    try {
      await _ref.document(uid).delete();
    } catch (e) {
      print(e);
    }
  }

  Future deleteSuggestion(String uid) async {
    CollectionReference _ref = Firestore.instance.collection('suggestion');
    try {
      await _ref.document(uid).delete();
    } catch (e) {
      print(e);
    }
  }

  Future deleteDonar(String uid) async {
    CollectionReference _ref = Firestore.instance.collection('donation');
    try {
      await _ref.document(uid).delete();
    } catch (e) {
      print(e);
    }
  }

  Future deleteThought(String uid) async {
    CollectionReference _ref = Firestore.instance.collection('thought');
    try {
      await _ref.document(uid).delete();
    } catch (e) {
      print(e);
    }
  }
}

class ImageData {
  final images;
  ImageData({this.images});
}
