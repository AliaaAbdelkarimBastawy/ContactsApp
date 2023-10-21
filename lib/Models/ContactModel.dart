import 'package:flutter/cupertino.dart';
import 'dart:io' as io;
class Model{
  String Name = "";
  String Email = "";
  String Telephone = "";
  io.File? Image;

  Model({required this.Name, required this.Email, required this.Telephone, required this.Image});
}


class ContactListModel extends ChangeNotifier
{
  List <Model> ContactList = [];
  AddContact(Model model)
  {
    ContactList.add(model);
    notifyListeners();
  }

  RemoveContact (int index)
  {
    ContactList.removeAt(index);
    notifyListeners();

  }

  EditContact (int index, String name, String email, String telephone, io.File image)
  {

    ContactList[index].Name = name;
    ContactList[index].Email = email;
    ContactList[index].Telephone = telephone;
    ContactList[index].Image = image != null ? io.File(image.path) : io.File("Assets/Images/NoPhoto.png");
    notifyListeners();

  }
}

