import 'package:flutter/material.dart';
class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Developer still working on current page', style: TextStyle(
          color: Colors.green.shade900
      )),
    );
  }
}
