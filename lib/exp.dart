import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'class.dart';

class date extends StatefulWidget {
  const date({super.key});

  @override
  State<date> createState() => _dateState();
}

class _dateState extends State<date> {
  TextEditingController date=TextEditingController();
  TextEditingController amount=TextEditingController();

  String? option;

  String ?category;


  void _addItemToList()
  {
    String text= date.text;
    String text1=amount.text;
    String ?options=option;
    String ? drop= category;



    if(text.isNotEmpty&&text1.isNotEmpty){
      setState(() {
        var values={
          "date":text,
          "amount":text1,
          "drop":drop??"",
          "options":options??"",

        };
        Navigator.pop(context,values);
      });

    }

  }
  @override
  Widget build(BuildContext context) {
    var catProvider = Provider.of<CatProvider>(context);
    var payProvider = Provider.of<CatProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Add Expense"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: "Outfit",fontWeight: FontWeight.w100
                  ),
                  controller: date,
                  decoration: InputDecoration(
                    hintText: "Date",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontFamily: "Outfit"
                    ),
                    prefixIcon: Icon(Icons.calendar_month),
                  ),
                  onTap: ()async{
                    DateTime?pickeddate=await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if(pickeddate!=null){
                      setState(() {
                        date.text= DateFormat('dd-MM-yyyy').format(pickeddate);
                      });
                    }
                  },

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.blue,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  isExpanded: true,
                  value: category,
                  items: catProvider.cat
                      .map<DropdownMenuItem<String>>(
                        (Map<String, String> item) => DropdownMenuItem<String>(
                      value: item['ABCD']!,
                      child: Text(item['ABCD']!),
                    ),
                  )
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      category = value!;
                    });
                    // Handle dropdown value change if needed
                  },
                  decoration: InputDecoration(
                    // You can customize the decoration as needed
                    hintText: 'Select Category',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w100
                    )
                  ),
                )

              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: "Outfit",
                    fontWeight: FontWeight.w100
                  ),
                  controller: amount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range_rounded,),
                    labelText: 'Spent Amount',
                    labelStyle: TextStyle(fontWeight: FontWeight.w100,fontSize: 18,
                        fontFamily: "Outfit",color: Colors.white),),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.blue,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  isExpanded: true,
                  value: option,
                  items: payProvider.pay
                      .map<DropdownMenuItem<String>>(
                        (Map<String, String> item) => DropdownMenuItem<String>(
                      value: item['Paymentmode']!,
                      child: Text(item['Paymentmode']!),
                    ),
                  )
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      option = value!;
                    });
                    // Handle dropdown value change if needed
                  },
                  decoration: InputDecoration(
                    // You can customize the decoration as needed
                      hintText: 'Select Payment',
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w100
                      )
                  ),
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Attachment',style: TextStyle(fontWeight: FontWeight.w100,fontSize: 18,
                      fontFamily: "Outfit",color: Colors.white),),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: (){
                          showImagePickerOption(context);
                        },
                        child: Text('Upload',style: TextStyle(color: Colors.black,fontFamily: "Outfit",fontWeight: FontWeight.w100),),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),),
                    ),
                  )


                ],
              ),
              Center(
                child: ElevatedButton(style: ElevatedButton.styleFrom(
                    minimumSize: (Size(150, 50)),
                    primary: Colors.white,
                    onPrimary: Colors.white,
                    side: BorderSide(width:3, color:Colors.black), //border width and color
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),onPressed: (){
                  _addItemToList();
                }, child: Text("save",style: TextStyle(color: Colors.black,fontFamily: "Outfit",
                fontWeight: FontWeight.w100,fontSize: 18),)),
              ),

            ],

          ),
        ),
      ),
    );
  }
  Uint8List? _image;
  File? selectedIMage;


  ///image upload fuc
  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.blue[100],
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {

                        _pickImageFromGallery();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 70,
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 70,
                            ),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  Future _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;

    // setState(() {
    //   selectedIMage = File(returnImage.path);
    //   _image = File(returnImage.path).readAsBytesSync();
    // });

    Navigator.of(context).pop();
  }
  Future _pickImageFromGallery() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;

    // setState(() {
    //   selectedIMage = File(returnImage.path);
    //   _image = File(returnImage.path).readAsBytesSync();
    // });

    Navigator.of(context).pop(); //close the model sheet
  }
}
class ExpenseData {
  DateTime? date;
  String? category;
  String? amount;
  String? option;
  Uint8List? image;

  ExpenseData({this.date, this.category, this.amount,this.option, this.image});

}