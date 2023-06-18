import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Login'),
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
                        hintText: 'Enter Full Name',
                      ),
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Full Name';
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
              //========= Branch ======
              login
                  ? Container()
                  : DropdownButtonFormField<String>(
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
                          child: Text(value),
                        );
                      }).toList(),

                      onSaved: (newValue) {
                        setState(() {
                          branchName = newValue!;
                        });
                      },
                    ),

              // ======== Email ========
              TextFormField(
                key: const ValueKey('email'),
                decoration: const InputDecoration(
                  hintText: 'Enter Email',
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
              // ======== Password ========
              TextFormField(
                key: const ValueKey('password'),
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter Password',
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
              SizedBox(
                height: 55,
                width: double.infinity,
                child: Builder(builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // user.fullname = nameController.text;
                        // user.email = emailController.text;
                        // user.branch = branchName;
                        if (login) {
                          AuthServices.signinUser(email, password, context);
                        } else {
                          try {
                            AuthServices.signupUser(
                                email, password, fullname, branchName, context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                          // Only saves data during signup
                        }
                      }
                    },
                    child: Text(login ? 'Login' : 'Signup'),
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
                      ? "Don't have an account? Signup"
                      : "Already have an account? Login"))
            ],
          ),
        ),
      ),
    );
  }
}
