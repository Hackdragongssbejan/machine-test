import 'package:flutter/material.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Developer still working on current page',style: TextStyle(
          color: Colors.green.shade900
      )),
    );
  }
}
