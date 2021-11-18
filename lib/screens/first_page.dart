import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app_firebase/db_firebase/database.dart';
import 'package:test_app_firebase/model/data_model.dart';
import 'package:test_app_firebase/prev/data_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Database db;
  List<DataModel> dataList = [];
  initialise() {
    db = Database();
    db.initiliase();
    db.read().then((value) => {
      setState(() {
        dataList = value;
      })
    });
  }

  @override
  void dispose() {

    super.dispose();
  }


  // List<DataModel> dataList = [];
  @override
  void initState() {
    super.initState();
    initialise();
  }



  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider =  Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        // title: Text("Test Screen"),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_none,
                  size: 25.0,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Icon(
                  Icons.search,
                  size: 25.0,
                ),
              ],
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

              Text('الرئيسية',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
            Expanded(
              child:dataProvider.list!=null ?

              ListView.builder(
                  itemCount: dataProvider.list.length,itemBuilder: (BuildContext context,int index){
                    DataModel item = dataProvider.list[index];
                    print('timeStamp################################## '+item.date);
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),

                  width: MediaQuery.of(context).size.width,
                  margin:  EdgeInsets.only(top: 10.0),
                  child: Container(
                    margin:  EdgeInsets.all( 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            item.imgUrl,
                            height: 150.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Text(item.description,style: TextStyle(
                          fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.grey
                        ),),

                        SizedBox(height: 10.0,),
                        Row(children: [
                          Text('المصدر:'+item.src,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,style: TextStyle(
                              fontSize: 10.0,fontWeight: FontWeight.w300,color: Colors.grey
                          ),),
                          Spacer(),
                          Text(item.date,style: TextStyle(
                              fontSize: 10.0,fontWeight: FontWeight.w300,color: Colors.grey
                          ),),
                        ],)

                      ],
                    ),
                  ),
                );
              }): Center(
                child: CircularProgressIndicator(),
      ),
            ),

          ],
        ),
      ),
    );
  }
}
