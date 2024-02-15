import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'exp.dart';


class expcat extends StatefulWidget {
  const expcat({super.key});

  @override
  State<expcat> createState() => _expcatState();
}

class _expcatState extends State<expcat> {
  String dates = "";
  String caters = "";
  String spents = "";
  String payments="";


  List<Map<String, String>> datetime = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }
  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('datetime') ?? '[]';
    setState(() {
      datetime = List<Map<String, String>>.from(
        (json.decode(data) as List).map(
              (values) => Map<String, String>.from(values),
        ),
      );
    });
  }
  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('datetime', json.encode(datetime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Details",style: TextStyle(
            fontFamily: "Outfit",fontSize: 20,
            fontWeight: FontWeight.w100
        ),),
        backgroundColor: Colors.white,

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(style:ElevatedButton.styleFrom(

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
                      builder: (context) => date(),
                    ),
                  );

                  // Update dataList with the returned data
                  if (result != null) {
                    setState(() {
                      datetime.add(result);
                      saveData();
                    });
                  }
                }, child: Text("Add",style: TextStyle(
                    fontFamily: "Outfit",fontWeight: FontWeight.w100,
                    color: Colors.white
                ),)),
          ),
        ],
      ),
      body: ListView.builder(itemCount: datetime.length,
          itemBuilder: (BuildContext context, int index) {
            var items = datetime[index];
            TextEditingController(text: items['date']);
            TextEditingController(text: items["amount"]);

            return Card(
              color:Colors.white,
              child: ListTile(
                title: Text(
                  "date:${items["date"]}\nCategory:${items["drop"]}\nSpentAmount:${items["amount"]}\noptions:${items["options"]}",
                  style: TextStyle(color: Colors.black,fontFamily: "Outfit",
                      fontWeight: FontWeight.w100),
                ),
                trailing: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          TextEditingController dateController =
                          TextEditingController(text: items['date']);
                          TextEditingController cater =
                          TextEditingController(text: items['drop']);
                          TextEditingController spentController =
                          TextEditingController(text: items['amount']);
                          TextEditingController option =
                          TextEditingController(text: items['options']);
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
                                      controller: dateController,
                                      onChanged: (value) {
                                        setState(() {
                                          dates = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          labelText: "Date",
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Outfit",
                                              fontWeight: FontWeight.w100,
                                              fontSize: 18)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: cater,
                                      onChanged: (value) {
                                        setState(() {
                                          caters = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Category",
                                        labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Outfit",
                                            fontWeight: FontWeight.w100,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: spentController,
                                      onChanged: (value) {
                                        setState(() {
                                          spents = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          labelText: "SpentAmount",
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Outfit",
                                              fontWeight: FontWeight.w100,
                                              fontSize: 18)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: option,
                                      onChanged: (value) {
                                        setState(() {
                                          payments = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: "payment mode",
                                        labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Outfit",
                                            fontWeight: FontWeight.w100,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width * 0.3, 55),),
                                    onPressed: () {
                                      setState(() {
                                        datetime[index]['date'] =
                                            dateController.text;
                                        datetime[index]['drop'] =
                                            cater.text;
                                        datetime[index]['amount'] =
                                            spentController.text;
                                        datetime[index]['options'] =
                                            option.text;
                                      });
                                      saveData(); // Save the updated data
                                      Navigator.pop(context);
                                    },
                                    child: Text("Update",style: TextStyle(
                                        fontFamily: "Outfit",fontWeight: FontWeight.w100,
                                        fontSize: 16
                                    ),),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit,color: Colors.black,),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            datetime.removeAt(index);
                            saveData(); // Save the updated data
                          });
                        },
                        icon: Icon(Icons.delete,color: Colors.black,),
                      ),
                    ],
                  ),
                ),


              ),
            );
          }),
    );
  }
}