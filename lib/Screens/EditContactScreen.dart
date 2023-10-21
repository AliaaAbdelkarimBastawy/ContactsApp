import 'dart:io' as io;
import 'package:contact_app/Screens/ContactsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../Models/ContactModel.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('Assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

class EditContactScreen extends StatefulWidget {
  int index;
   EditContactScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  late Model model;
  late ContactListModel ContactsList;
  final ImagePicker picker = ImagePicker();
  final _globalkey = GlobalKey<FormState>();
  TextEditingController NameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  File imagee = new File('Assets/Images/NoPhoto.png');// Output: 17kb, 30mb, 7gb
  File? image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NameController.text = context.read<ContactListModel>().ContactList[widget.index].Name;
    EmailController.text = context.read<ContactListModel>().ContactList[widget.index].Email;
    PhoneController.text = context.read<ContactListModel>().ContactList[widget.index].Telephone;
    image = context.read<ContactListModel>().ContactList[widget.index].Image;
  }

  @override
  Widget build(BuildContext context) {
    return  Consumer<ContactListModel>(builder: (BuildContext context, ContactListModel value, Widget? child)
      {
        return   Scaffold(
          resizeToAvoidBottomInset:false,
          appBar: AppBar(leading: IconButton(onPressed: () {
            GoRouter.of(context).go("/Screen1");
          },
            icon: Icon(Icons.arrow_back_ios_new),),
            title: Center(child: Text("Edit Contact")),
            actions: [Icon(Icons.add, color: Colors.blue,)],),

          body: GestureDetector(
            onTap: ()
            {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Form(
              key: _globalkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Stack(children: [
                    Container(
                      height: 200, width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: image == null
                            ? AssetImage("Assets/Images/NoPhoto.png")
                          : Image.file(value.ContactList[widget.index].Image??io.File("Assets/Images/NoPhoto.png") ).image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipOval(
                          child: image == null ? Image.asset("Assets/Images/NoPhoto.png",)
                              : Image.file(image!, fit: BoxFit.cover,),
                        ),
                      ),

                    Positioned(child:IconButton(icon:  Icon(Icons.camera_alt, color: Colors.white, size: 20,),
                      onPressed: () {
                        showModalBottomSheet(context: context, builder: ((builder) => bottomSheet()));
                      },),
                      bottom: 5, right: 35,),
                  ],),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,0,0,16),
                    child: Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 15),
                          Column(
                            children: [
                              Container(
                                width: 300,
                                child: TextFormField(
                                  controller: NameController,
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),

                                  validator: (String? value) {

                                    if(value == "")
                                    {
                                      return "Name cannot be empty";
                                    }

                                    else if(value!.contains("@"))
                                    {
                                      return "Name cannot contain @";

                                    }
                                    return null;

                                  },

                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,0,0,16),
                    child: Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.email),
                          SizedBox(width: 15),
                          Column(
                            children: [
                              Container(
                                width: 300,
                                child: TextFormField(
                                  controller: EmailController,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),

                                  validator: (String? value) {

                                    if(value == "")
                                    {
                                      return "Email cannot be empty";
                                    }

                                    else if(!value!.contains("@"))
                                    {
                                      return "Email must contain @";

                                    }
                                    return null;

                                  },

                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,0,0,16),
                    child: Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.phone),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(width: 300,
                                child: TextFormField(
                                  controller: PhoneController,
                                  decoration: InputDecoration(
                                    labelText: "Telephone",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  validator: (String? value) {

                                    if(value == "")
                                    {
                                      return "Telephone cannot be empty";
                                    }

                                    else if(value!= null && value.length <11)
                                    {
                                      return "Telephone must be 11 numbers";

                                    }
                                    return null;

                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Consumer<ContactListModel>(builder: (BuildContext context, ContactListModel value, Widget? child)
                  {
                    return   Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:

                      Container(width:100,
                          child: ElevatedButton(onPressed: (){
                            print("EDITED11");
                            if(_globalkey.currentState!.validate())
                            {
                              value.EditContact(widget.index, NameController.text,
                                  EmailController.text, PhoneController.text, image ?? io.File("Assets/Images/NoPhoto.png"),
                              );
                            }
                            else
                              {
                                print("Not Validated");
                              }
                            // GoRouter.of(context).go("/Screen1");
                          }, child: Text("Save"),)),
                    );
                  },
                  ),
                ],
              ),
            ),
          ),

        );
      }

    );
  }

  Widget bottomSheet()
  {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(children: [
        Text("Choose Profile photo", style: TextStyle(fontSize: 20),),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(onPressed: (){
              _pickImage(ImageSource.camera);
            },
                icon: Icon(Icons.camera), label: Text("Camera")),
            SizedBox(width: 20,),
            ElevatedButton.icon(onPressed: (){
              _pickImage(ImageSource.gallery);
            }, icon: Icon(Icons.image),
              label: Text("Gallery"),)
          ],)

      ],),
    );
  }


}

