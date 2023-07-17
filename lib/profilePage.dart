import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/functions/authService.dart';
import 'package:qr_code/models/userModel.dart';
import 'package:qr_code/qrGenerate.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user;
  UserModel getUserInfo = UserModel();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    getData();
  }

  void getData() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(milliseconds: 75));

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

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToGenerate(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => QRGenerator()));
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                width: double.infinity,
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
                        height: 160,
                        margin: const EdgeInsets.only(top: 25),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                  "images/blank-profile-picture.png")),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Name",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          getUserInfo.fullname ?? '',
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          getUserInfo.email ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Branch Name",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          getUserInfo.branch ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              navigateToGenerate(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.qr_code),
                                SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "QR Generate",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              AuthServices.logoutUser(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.logout_rounded),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
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
