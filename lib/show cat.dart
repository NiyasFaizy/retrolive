import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cat.dart';
import 'class.dart';



class showcat extends StatefulWidget {
  const showcat({Key? key}) : super(key: key);

  @override
  State<showcat> createState() => _showcatState();
}

class _showcatState extends State<showcat> {
  String name = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString("cat") ?? "[]";
    var catProvider = Provider.of<CatProvider>(context, listen: false);

    setState(() {
      catProvider.cat = List<Map<String, String>>.from(
        (json.decode(data) as List).map(
              (items) => Map<String, String>.from(items),
        ),
      );
    });
  }

  void save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var catProvider = Provider.of<CatProvider>(context, listen: false);
    prefs.setString("cat", json.encode(catProvider.cat));
  }

  @override
  Widget build(BuildContext context) {
    var catProvider = Provider.of<CatProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Details",style: TextStyle(
          color: Colors.black,
          fontFamily: "Outfit",fontWeight: FontWeight.w100,
          fontSize: 20
        ),),

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(

             backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            side: BorderSide(width:3, color:Colors.white), //border width and color
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(10)
            )

              ),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => exppage(),
                  ),
                );

                // Update dataList with the returned data
                if (result != null) {
                  setState(() {
                    catProvider.cat.add(result);
                    save();
                  });
                }
              },
              child:Text("Add",style: TextStyle(
                  fontSize: 25,fontFamily: "Outfit",fontWeight: FontWeight.w100
              ),),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: catProvider.cat.length,
        itemBuilder: (BuildContext context, int index) {
          var items = catProvider.cat[index];
          TextEditingController nameController =
          TextEditingController(text: items['ABCD']);
          return Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                title: Text("Category:${items["ABCD"]}",style: TextStyle(
                  color: Colors.black,fontFamily: "Outfit",fontWeight: FontWeight.w100
                ),),
                trailing: SizedBox(
                  height: 50,
                  width: 100,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: IconButton(
                          color: Colors.black,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => Container(
                                height: MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: SimpleDialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: nameController,
                                        onChanged: (value) {
                                          setState(() {
                                            name = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Name",
                                          hintStyle: TextStyle(
                                            fontFamily: "Outfit",
                                            fontWeight: FontWeight.w100,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width * 0.3, 55),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          catProvider.cat[index]['ABCD'] =
                                              nameController.text;
                                        });
                                        save();
                                        Navigator.pop(context);
                                      },
                                      child: Text("Update"),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: Icon((Icons.edit)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: IconButton(
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              catProvider.cat.removeAt(index);
                              save();
                            });
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}