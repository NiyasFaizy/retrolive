import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrolive/payment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'class.dart';



class second1 extends StatefulWidget {
  const second1({super.key});

  @override
  State<second1> createState() => _second1State();
}

class _second1State extends State<second1> {

  String name = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString("pay") ?? "[]";
    var payProvider = Provider.of<CatProvider>(context, listen: false);

    setState(() {
      payProvider.pay = List<Map<String, String>>.from(
        (json.decode(data) as List).map(
              (items) => Map<String, String>.from(items),
        ),
      );
    });
  }

  void save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var payProvider = Provider.of<CatProvider>(context, listen: false);
    prefs.setString("pay", json.encode(payProvider.pay));
  }


  @override
  Widget build(BuildContext context) {
    var payProvider = Provider.of<CatProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Details",style: TextStyle(
          fontFamily: "Outfit",fontWeight: FontWeight.w100
        ),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(style: ElevatedButton.styleFrom(
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
                  MaterialPageRoute(builder: (context) => turf()),
                );

                // Update dataList with the returned data
                if (result != null) {
                  setState(() {
                    payProvider.pay.add(result);
                    save();
                  });
                }
              },
              child: Text("Add",style: TextStyle(
                fontSize: 25,fontFamily: "Outfit",fontWeight: FontWeight.w100
              ),),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: payProvider.pay.length,
        itemBuilder: (BuildContext context, int index) {
          var items = payProvider.pay[index];
          TextEditingController nameController =
          TextEditingController(text: items['Paymentmode']);
          return Card(
            color: Colors.white,
            child: ListTile(
              title: Text("Paymentmode: ${items['Paymentmode']}",style: TextStyle(color: Colors.black,fontFamily: "Outfit",fontWeight: FontWeight.w100),),
              trailing: SizedBox(
                height: 80,
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.4,
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
                                        color: Colors.white,
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
                                      payProvider.pay[index]['Paymentmode'] =
                                          nameController.text;
                                    });
                                    save();
                                    Navigator.pop(context);
                                  },
                                  child: Text("Update",style: TextStyle(fontSize: 25,
                                    fontFamily: "Outfit",fontWeight: FontWeight.w100
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
                          payProvider.pay.removeAt(index);
                        });
                        save(); // Save the updated data
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