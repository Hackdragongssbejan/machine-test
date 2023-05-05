import 'package:flutter/material.dart';
class VoucherPage extends StatefulWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Developer still working on current page',style: TextStyle(
        color: Colors.green.shade900
      )),
    );
  }
}
