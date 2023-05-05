import 'package:flutter/material.dart';
import 'navitems/HomePage.dart';
import 'navitems/settingspage.dart';
import 'navitems/voucherpage.dart';
import 'navitems/walletpage.dart';

class NavItems extends StatefulWidget {
  @override
  _NavItemsState createState() => _NavItemsState();
}

class _NavItemsState extends State<NavItems> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    const VoucherPage(),
    const WalletPage(),
    const SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: SizedBox(height: 35,child: Image.asset('assets/images/home.png',color: Colors.grey,),),
      activeIcon: SizedBox(height: 35, child: Image.asset('assets/images/home.png',color: Colors.green,)),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: SizedBox(height: 35,child: Image.asset('assets/images/voucher.png',color: Colors.grey,),),
      activeIcon: SizedBox(height: 35, child: Image.asset('assets/images/voucher.png',color: Colors.green,)),
      label: 'Voucher',
    ),
    BottomNavigationBarItem(
      icon: SizedBox(height: 35,child: Image.asset('assets/images/wallet.png',color: Colors.grey,),),
      activeIcon: SizedBox(height: 35,child: Image.asset('assets/images/wallet.png',color: Colors.green,),),
      label: 'Wallet',
    ),
    BottomNavigationBarItem(
      icon: SizedBox(height: 30,child: Image.asset('assets/images/gear.png',color: Colors.grey,),),
      activeIcon: SizedBox(height: 30,child: Image.asset('assets/images/gear.png',color: Colors.green,),),
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 70,
        width: double.infinity,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: _bottomNavBarItems,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
