import 'package:flutter/material.dart';
import 'package:login_screen/screens/loanType.dart';
import 'package:login_screen/screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: prefer_const_constructors
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

   final List<Map<String, dynamic>> banks = [
    {
      'name': 'Canara Bank',
      'icon': 'assets/images/canara.jpeg',
    },
    {
      'name': 'IDBI Bank',
      'icon': 'assets/images/idbi.jpeg',
    },
    {
      'name': 'LIC',
      'icon': 'assets/images/lic.jpeg',
    },
    {
      'name': 'Federal Bank',
      'icon': 'assets/images/federal.jpeg',
    },

    {
      'name': 'South Indian Bank',
      'icon': 'assets/images/south indian.jpeg',
    },
  ];

  Map<String, dynamic>? selectedData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              onPressed: () {
                signout(context);
              },
              icon: Icon(Icons.exit_to_app),
            )
          ],
        ),
        body: SafeArea(
          child: Center(
              child: ListView.separated(
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Select Bank',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(border: OutlineInputBorder()),
                            autofocus: true,
                              hint: Text('Select a Bank'),
                              items: banks.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(e['name']),
                                      Image.asset(
                                        e['icon'],
                                      height: 50,
                                      width: 50,)
                                    ],
                                  ),
                                );
                              }).toList(),
                              // onTap: ()  {
                              //   print(selectedData);
                              // },
                              onChanged: (value) {
                                selectedData=value;
                                //print(selectedData);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => LoanType(selectedBank: selectedData,)));
                              }),
                        ],
                      ),
                    );
                  }),
                  separatorBuilder: ((context, index) {
                    return Divider();
                  }),
                  itemCount: 1)),
        ));
  }

  signout(BuildContext ctx) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.clear();

    Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx1) {
      return SplashScreen();
    }), (route) => false);
  }
}
