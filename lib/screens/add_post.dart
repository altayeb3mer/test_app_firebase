import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:test_app_firebase/db_firebase/database.dart';
import 'package:test_app_firebase/model/data_model.dart';
import 'package:test_app_firebase/prev/data_provider.dart';
import 'package:test_app_firebase/provider/loading_provider.dart';

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Firebase Storage Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: UploadingImageToFirebaseStorage(),
//     );
//   }
// }

final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Database db;
  TextEditingController controllerDesc;
  TextEditingController controllerSrc;

  @override
  void initState() {
    db = Database();
    db.initiliase();
    controllerDesc = TextEditingController();
    controllerSrc = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }


  DataProvider dataProvider;
  LoadingProvider loadingProvider;



  File _imageFile;

  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');

    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => addDataToFire(value,context),
        );
  }

  void addDataToFire(String value,BuildContext context) {
    print("Done: $value");
    DataModel _dataModel = DataModel(
        description: controllerDesc.text,
        src: controllerSrc.text,
        imgUrl: value,
        );

    dataProvider.addPost(_dataModel);
      controllerSrc.clear();
      controllerDesc.clear();
      _imageFile = null;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('تمت الاضافة بنجاح')));

    // db.create(_dataModel);
    // setState(() {
    //   controllerSrc.clear();
    //   controllerDesc.clear();
    //   _imageFile = null;
    // });
    loadingProvider.setLoad(false);
  }

  @override
  Widget build(BuildContext context) {
    dataProvider =  Provider.of<DataProvider>(context);
    loadingProvider =  Provider.of<LoadingProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children:[ Container(
          margin: EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Text(
                'اضف بيانات جديدة',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
              Container(
                child: TextField(
                  controller: controllerDesc,
                  style:
                      TextStyle(fontSize: 20.0, height: 2.0, color: Colors.black),
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    hintText: 'اضف الوصف',
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: TextField(
                  controller: controllerSrc,
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    hintText: 'اضف المصدر',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: _imageFile != null
                      ? Image.file(_imageFile)
                      : FlatButton(
                          child: Icon(
                            Icons.add_a_photo,
                            size: 50,
                          ),
                    onPressed: pickImage,
                        ),
                ),
              ),
              uploadImageButton(context),
            ],
          ),
        ),

        loadingProvider.loading ? Center(
          child: CircularProgressIndicator(),
        ) : SizedBox(),

      ]),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Center(
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
              margin: const EdgeInsets.only(
                  top: 30, left: 20.0, right: 20.0, bottom: 20.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [yellow, orange],
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
              child: FlatButton(
                onPressed: () {
                  if (controllerDesc.text.isNotEmpty &&
                      controllerSrc.text.isNotEmpty &&
                      _imageFile!=null) {
                    loadingProvider.setLoad(true);
                    uploadImageToFirebase(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('جميع البيانات مطلوبة'),
                    ));
                  }
                },
                child: Text(
                  "اضف البيانات",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
