import 'package:contact_app/Screens/AddNewContactScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'Models/ContactModel.dart';
import 'Screens/ContactsScreen.dart';
import 'Screens/EditContactScreen.dart';

GoRouter router = GoRouter(
    initialLocation: "/Screen1",
    routes: [
      GoRoute(path: "/Screen1", builder: (context,state) => ContactsScreen()),
      GoRoute(path: "/Screen2", builder: (context,state) => AddNewContactScreen()),
      GoRoute(name: "/Screen3",path: "/Screen3/:index", builder: (context,state) =>
          EditContactScreen(index: int.parse(state.pathParameters['index']!),)),
    ]);


void main() {
  runApp( ChangeNotifierProvider(create: (context) => ContactListModel(),child:MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routerConfig: router,
  ),));
}