import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'details.dart';
class show extends StatefulWidget {
  const show({Key? key});


  @override
  State<show> createState() => _showState();
}

class _showState extends State<show> {
  List<Map<String, String>> dataList = [];
  String name = "";
  String Username = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('dataList') ?? '[]';
    setState(() {
      dataList = List<Map<String, String>>.from(
        (json.decode(data) as List).map(
              (item) => Map<String, String>.from(item),
        ),
      );
    });
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('dataList', json.encode(dataList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Details",style:TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,
            fontSize: 18,color: Colors.black),),
       actions: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: ElevatedButton(
             style:  ElevatedButton.styleFrom(
             backgroundColor: Colors.black,
                 foregroundColor: Colors.white,
                 side: BorderSide(width:3, color:Colors.white), //border width and color
               elevation: 5,
               shape: RoundedRectangleBorder(
                   borderRadius:BorderRadius.circular(10)
               )),



               onPressed: () async {
            // Navigate to details screen and get data back
            final result = await Navigator.push(
           context,
            MaterialPageRoute(builder: (context) => details()),
            );

            // Update dataList with the returned data
             if (result != null) {
               setState(() {
               dataList.add(result);
               saveData(); // Save the updated data
               });
               }
               }, child: Text("Add",style: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,
           fontSize: 25),)),
         )
       ],

      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          var item = dataList[index];
          return Card(
            color: Colors.white,
            child: ListTile(

              title: Text(
                "Usertype:${item["Dropdown"]}\nName: ${item['Name']}\nUsername: ${item['Username']}\nPassword: ${item['Password']}",
                style:TextStyle(color: Colors.black,fontFamily: "Outfit",
                fontWeight: FontWeight.w100) ,),
              trailing: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        TextEditingController nameController =
                        TextEditingController(text: item['Name']);
                        TextEditingController usernameController =
                        TextEditingController(text: item['Username']);
                        TextEditingController passwordController =
                        TextEditingController(text: item['Password']);


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
                                            color: Colors.black,
                                            fontFamily: "Outfit",
                                            fontWeight: FontWeight.w100,
                                            fontSize: 18)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: usernameController,
                                    onChanged: (value) {
                                      setState(() {
                                        Username = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        hintText: "username",
                                        hintStyle: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Outfit",
                                            fontWeight: FontWeight.w100,
                                            fontSize: 18)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: passwordController,
                                    onChanged: (value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: "password",
                                      hintStyle: TextStyle(
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
                                      dataList[index]['Name'] =
                                          nameController.text;
                                      dataList[index]['Username'] =
                                          usernameController.text;
                                      dataList[index]['Password'] =
                                          passwordController.text;
                                    });
                                    saveData(); // Save the updated data
                                    Navigator.pop(context);
                                  },
                                  child: Text("Update",style: TextStyle(
                                      fontFamily: "Outfit",fontWeight: FontWeight.w100,
                                      fontSize: 16
                                  ),),
                                )
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
                          dataList.removeAt(index);
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
        },
      ),


    );
  }
}