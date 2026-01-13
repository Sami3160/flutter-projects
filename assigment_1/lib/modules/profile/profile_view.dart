import 'package:assigment_1/core/base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileView extends BaseView{
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile page"),
      ),
      body: Center(
        child: Text("Welcome traveller.."),
      ),
    );
  }
}