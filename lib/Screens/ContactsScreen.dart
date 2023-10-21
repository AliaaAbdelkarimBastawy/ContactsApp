import 'package:contact_app/Screens/EditContactScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../Models/ContactModel.dart';

class ContactsScreen extends StatelessWidget {
   ContactsScreen({Key? key}) : super(key: key);

  List<Model> Contacts = [
    Model(Name: "Yaman", Email: 'yaman@yahoo.com', Telephone: '01234567890', Image: null),
    Model(Name: 'Ilhan', Email: 'ilhan@yahoo.com', Telephone: '01234567898', Image: null),
  ];
  @override
  Widget build(BuildContext context) {

    return Consumer<ContactListModel>(builder: (BuildContext context, ContactListModel value, Widget? child)
        {
          return Scaffold(
            appBar: AppBar(title: Text("Contacts"), actions: [Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Icon(Icons.search),
            )],),
            body: ListView.builder(
              itemCount: value.ContactList.length,
              itemBuilder: (BuildContext context, int index) {
                return ContactItem(index: index);
              },
            ),
            floatingActionButton: FloatingActionButton(onPressed: () {
              GoRouter.of(context).go("/Screen2");
            }, child: Icon(Icons.add),),

          );
        }

    );
  }

}


class ContactItem extends StatelessWidget {

  int index;
  ContactItem(
      {Key? key,
        required this.index,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
      Consumer<ContactListModel>(builder: (BuildContext context, ContactListModel value, Widget? child)
          {
            return  ListTile(
            leading: CircleAvatar(child: Center(child: Text(value.ContactList[index].Name[0],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),),
            title: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(value.ContactList[index].Name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
            SizedBox(height: 5,), Text(value.ContactList[index].Telephone)],),
            trailing: Container( width:150, child: Row(children:
            [ElevatedButton(onPressed: () {
              context.goNamed("/Screen3", pathParameters: {'index': index.toString()});
            }, child: Text("Edit"), ),
              SizedBox(width: 10,),
              ElevatedButton(onPressed: () {
               value.RemoveContact(index);
              }, child: Text("Delete"), ),],))
          );
          }
    ),
    );
  }
}