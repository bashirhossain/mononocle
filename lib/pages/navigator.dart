import 'package:flutter/material.dart';
import '../login/User/get_create_user.dart';
import 'package:provider/provider.dart';
import 'Navigation/junction.dart';
import 'Navigation/navigation-model.dart';

class PageNavigator extends StatelessWidget {
  PageNavigator({Key? key, required this.signOut}) : super(key: key);
  final User currentUser = User();
  final Function signOut;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=>PageViewed(),
        builder: (context,_) => Junction(signOut: signOut,),
      );
  }
}
