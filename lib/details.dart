import 'package:flutter/material.dart';

class details extends StatefulWidget {
  const details({super.key});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  int index=0;
  String dropdown="Admin";

  List <String>datalist=[];

  var size,height,width;
  TextEditingController name=TextEditingController();
  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();

  void additemList() {
    String text = name.text;
    String user = username.text;
    String pass = password.text;
    String usertype=dropdown;
    if (text.isNotEmpty && user.isNotEmpty && pass.isNotEmpty) {
      setState(() {
        var newItem = {
          'Name': text,
          'Username': user,
          'Password': pass,
          "Dropdown":usertype,
        };

        // Pass data back to the show screen
        Navigator.pop(context, newItem);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(

        title: Text("Retro Station",style: TextStyle(color: Colors.black,
          fontFamily: "Outfit",fontWeight: FontWeight.w100,fontSize: 20

        ),),centerTitle: true,
        backgroundColor:Colors.white,

      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*2,
          width: MediaQuery.of(context).size.width*1,
          child: Column(
            children: [SizedBox(height:MediaQuery.of(context).size.height*0,),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text("Usertype:",style: TextStyle(color: Colors.white,
                          fontFamily: "Outfit",fontWeight: FontWeight.w100,
                          fontSize: 18),),
                    ),
                    SizedBox(width: 10,),
                    DropdownButton<String>(
                      borderRadius: BorderRadius.circular(10),

                      dropdownColor: Colors.blue,
                      style: TextStyle(color: Colors.white,fontSize: 15),
                      value: dropdown,

                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: <String>["User", "Admin",].map<DropdownMenuItem<String>>((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item,style: TextStyle(color: Colors.white),),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdown = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.white
                  ),
                  controller: name,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person,color: Colors.white,),
                      hintText: "Enter Name",
                      hintStyle: TextStyle(color: Colors.white,
                          fontFamily: "Outfit",fontWeight: FontWeight.w100,
                          fontSize: 18
                      )
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(

                  style: TextStyle(
                    color: Colors.white
                  ),
                  controller: username,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.contact_mail_sharp,color: Colors.white,),
                      hintText: "Enter UserName",
                      hintStyle: TextStyle(color: Colors.white,
                          fontFamily: "Outfit",fontWeight: FontWeight.w100,
                          fontSize: 18)
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.white
                  ),
                  controller: password,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password_outlined,color: Colors.white,),
                      hintText: "Enter Password",
                      hintStyle: TextStyle(color: Colors.white,
                          fontFamily: "Outfit",fontWeight: FontWeight.w100,
                          fontSize: 18)
                  ),
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: Size(MediaQuery.of(context).size.width*0.6,
                      45)
              ),onPressed: (){
                additemList();
              }, child: Text("Enter",style: TextStyle(color: Colors.black,
                  fontFamily: "Outfit",fontWeight: FontWeight.w100,
                  fontSize: 18))),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}