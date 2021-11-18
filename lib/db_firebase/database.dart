import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:test_app_firebase/model/data_model.dart';
class Database {
  FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  // Future<void> create(String name, String code) async {
  //   try {
  //     await firestore.collection("myData").add({
  //       'name': name,
  //       'code': code,
  //       'timestamp': FieldValue.serverTimestamp()
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  Future<void> create(DataModel _dataModel) async {

    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yy-MM-dd – kk:mm').format(now);

      await firestore.collection("myData").add({
        'description':_dataModel.description,
        'src':_dataModel.src,
        'imgUrl':_dataModel.imgUrl,
        'time':FieldValue.serverTimestamp(),
        'date':formattedDate
      });
      print('add done===========    > ');
    } catch (e) {
      print('add error===========  ###'+e.toString());
    }
  }



  Future<void> createUser(String name,String password) async {

    try {


      await firestore.collection("users").add({
        'name':name,
        'password':password,
        'time':FieldValue.serverTimestamp()
      });
      print('add user done===========    > ');
    } catch (e) {
      print('add user error===========  ###'+e.toString());
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("countries").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List<DataModel>> read() async {
    QuerySnapshot querySnapshot;
    List<DataModel> _list = [];
    List docs = [];
    try {
      querySnapshot = await firestore
          .collection('myData')
          // .orderBy('date')
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          DataModel _dataModel = DataModel();

          Map<String,dynamic> a = {
            "description": doc['description'],
            "src": doc["src"],
            "date":doc["date"],
            "imgUrl":doc["imgUrl"]
          };

          _dataModel= DataModel.fromMap(a);
          _list.add(_dataModel);
          print("readfireList==========================="+_list.toString());
          // docs.add(a);
        }
        return _list;
      }
    } catch (e) {
      print("readfireError==========================="+e.toString());
    }
  }

  Future<void> update(String id, String name, String code) async {
    try {
      await firestore
          .collection("countries")
          .doc(id)
          .update({'name': name, 'code': code});
    } catch (e) {
      print("update error==========================="+e.toString());
    }
  }
}
