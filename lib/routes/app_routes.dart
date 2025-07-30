import 'package:flutter/material.dart';

import '../screens/authentication/login_screen.dart';
import '../screens/home/home_screen.dart';


final Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => const LoginScreen(),
  '/home': (context) => const HomeScreen(),
};



// Widget buildDynamicRoute(RouteSettings settings) {
//   final args = settings.arguments as Map<String, dynamic>? ?? {};
//   switch (settings.name) {
//     case '/blForm':
//       return P2hBlScreen(id: args['id'], title: args['title']);
//     case '/dtForm':
//       return P2hDtScreen(id: args['id'], title: args['title']);
//     case '/lvForm':
//       return P2hLvScreen(id: args['id'], title: args['title']);
//     case '/bsForm':
//       return P2hBsScreen(id: args['id'], title: args['title']);
//     case '/exForm':
//       return P2hExScreen(id: args['id'], title: args['title']);
//     default:
//       return const LoginScreen();
//   }
// }
