import '../config/import.dart';

class FirebaseCrud {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  insertIntoCollection({collectionname, jsondata}) async {
    try {
      CollectionReference usersRef = await firestore.collection(collectionname);

      return usersRef.add(jsondata).then((value) {
        print("added successfully");

        return value;
      }).catchError((error) => Utils().toast(message: error.toString()));
    } catch (e) {
      print(e.toString());
    }
  }

  updateCollectiondata({docid, collectionname, jsondata}) {
    DocumentReference docRef = firestore.collection(collectionname).doc(docid);
    docRef
        .update(jsondata)
        .then((value) => print("updated successfully"))
        .catchError((error) => Utils().toast(message: error.toString()));
  }

  getfromcollectionwhere({collectionname, fieldname, fieldvalue}) {
    return firestore
        .collection(collectionname)
        .where(fieldname, isEqualTo: fieldvalue)
        .get();
  }
  getfromcollectionwheresnapshots({collectionname, fieldname, fieldvalue}) {
    return firestore
        .collection(collectionname)
        .where(fieldname, isEqualTo: fieldvalue)
        .snapshots();
  }
  getfromcollectiondoublewheresnapshots({collectionname, fieldname, fieldvalue,fieldname1, fieldvalue1}) {
    return firestore
        .collection(collectionname)
        .where(fieldname, isEqualTo: fieldvalue)
        .where(fieldname1, isEqualTo: fieldvalue1)
        .snapshots();
  }

  getfromcollection({collectionname}) {
    return firestore.collection(collectionname) .snapshots();
  }
}
