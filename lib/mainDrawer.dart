import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/functions/authService.dart';
import 'package:qr_code/models/userModel.dart';

class MainDrawer extends StatefulWidget {
  MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  User? user;
  UserModel getUserInfo = UserModel();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    getData();
  }

  void getData() async {
    String _uid = user!.uid;
    final DocumentSnapshot userInfo =
        await FirebaseFirestore.instance.collection("users").doc(_uid).get();

    String _name = userInfo.get("name");
    String _email = userInfo.get("email");
    String _branch = userInfo.get("branch");

    setState(() {
      getUserInfo = UserModel(
        fullname: _name,
        email: _email,
        branch: _branch,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            // height: MediaQuery.of(context).size.height * 0.2,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF3366FF),
                  Color(0xFF00CCFF),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.5],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    margin: const EdgeInsets.only(top: 25),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image:
                              AssetImage("images/blank-profile-picture.png")),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          getUserInfo.fullname ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          getUserInfo.email ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          getUserInfo.branch ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (getUserInfo.fullname == null ||
                      getUserInfo.email ==
                          null) // Show CircularProgressIndicator while fetching data
                    const SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              const ListTile(
                leading: Icon(Icons.person_2_sharp),
                title: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: null,
              ),
              const ListTile(
                leading: Icon(Icons.menu),
                title: Text(
                  "Orders",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: null,
              ),
              GestureDetector(
                onTap: () {
                  AuthServices.logoutUser(context);
                },
                child: const ListTile(
                  leading: Icon(Icons.logout_rounded),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //   return Container(
  //     height: 500,
  //     child: ListView.builder(
  //         itemCount: snapshot.data!.docs.length,
  //         itemBuilder: (context, index) {
  //           return Card(
  //             child: ListTile(
  //               title: Text(snapshot.data!.docs[index]["name"]),
  //             ),
  //           );
  //         }),
  //   );
  // }
  // return (Container());
}
