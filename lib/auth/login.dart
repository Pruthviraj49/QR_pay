import 'package:flutter/material.dart';
import 'package:qr_code/forgotPassword.dart';
import 'package:qr_code/functions/authService.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  // UserModel user = UserModel();
  String email = '';
  String password = '';
  String fullname = '';
  String branchName = '';
  bool login = false;

  // Initial Selected Value
  String? dropdownvalue;

  // List of items in our dropdown menu
  var branches = [
    'Computer Science',
    'Information Technology',
    'Electrical ',
    'Electronics and Telecommunication',
    'Mechanical',
    'Civil',
    'Textile'
  ];
  void refreshDropdown() {
    setState(() {
      dropdownvalue = null;
    });
  }

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();

    emailController.dispose();
    super.dispose();
  }

  // void saveUserDataModel() {
  //   if (!login) {
  //     final CollectionReference usersCollection =
  //         FirebaseFirestore.instance.collection('Users');

  //     usersCollection
  //         .add(user.toMap())
  //         .then((value) => print('User data saved'))
  //         .catchError((error) => print('Failed to save user data: $error'));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            title: const Text("VJTI",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textDirection: TextDirection.ltr),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF3366FF),
                    Color(0xFF00CCFF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ======== Full Name ========
                login
                    ? Container()
                    : TextFormField(
                        key: const ValueKey('fullname'),
                        decoration: const InputDecoration(
                          hintText: 'Enter Name',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                        ),
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Name';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            fullname = value!;
                          });
                        },
                      ),
                const SizedBox(
                  height: 10,
                ),
                //========= Branch ======
                login
                    ? Container()
                    : DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                        ),
                        value: dropdownvalue,
                        hint: const Text('Select an option'),
                        // The hint text
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue;
                          });
                        },

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an option';
                          }
                          return null;
                        },

                        items: branches.map((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                child: Text(value),
                              ));
                        }).toList(),

                        onSaved: (newValue) {
                          setState(() {
                            branchName = newValue!;
                          });
                        },
                      ),
                const SizedBox(
                  height: 10,
                ),
                // ======== Email ========
                TextFormField(
                  key: const ValueKey('email'),
                  decoration: const InputDecoration(
                    hintText: 'Enter Email',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.')) {
                      return 'Please Enter valid Email';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      email = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                // ======== Password ========
                TextFormField(
                  key: const ValueKey('password'),
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Enter Password',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Please Enter Password of min length 6';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      password = value!;
                    });
                  },
                ),

                const SizedBox(
                  height: 30,
                ),
                login
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ForgotPassWord(),
                              ));
                            },
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Builder(builder: (context) {
                    return TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 5.0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          if (login) {
                            AuthServices.signinUser(email, password, context);
                          } else {
                            try {
                              AuthServices.signupUser(email, password, fullname,
                                  branchName, context);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                            // Only saves data during signup
                          }
                        }
                      },
                      child: Text(
                        login ? 'Log In' : 'Register',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        login = !login;
                        refreshDropdown();
                      });
                    },
                    child: Text(login
                        ? "Don't have an account? Register"
                        : "Already have an account? Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
