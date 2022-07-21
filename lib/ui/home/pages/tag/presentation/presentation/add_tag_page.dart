import 'package:flutter/material.dart';

import '../../../../../../utils/style.dart';


class AddTagPage extends StatefulWidget {
  const AddTagPage({Key? key}) : super(key: key);

  @override
  _AddTagPageState createState() => _AddTagPageState();
}

class _AddTagPageState extends State<AddTagPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(
          "Add Tag",
          style: CustomTextStyle.styleSemiBold.copyWith(fontSize: 18),
        ),
        backgroundColor: Colors.white,

      ),
      body: Center(
        child: const Text("AAA"),
      )
    );
  }
}
