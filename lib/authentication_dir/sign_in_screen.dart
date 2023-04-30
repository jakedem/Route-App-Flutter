import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:routeapp/routes_dir/map.dart';
import 'package:routeapp/authentication_dir/sign_up_screen.dart';
import 'package:routeapp/routes_dir/map_google.dart';

bool _obscureText = true;

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formfield = GlobalKey<FormState>();
  // bool isEmailValid(String email) {
  //   RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  //   return emailRegex.hasMatch(email);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 0, 86, 79),
          title: const Text('Sign In'),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 20.0),
              child: Form(
                key: _formfield,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // the sign in and welcome message container
                    Container(
                      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            'Hello there, happy to see you once again',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //the form fields
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 20.0),
                            ),
                            validator: (value) {
                              bool emailValid =
                                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value!);

                              if (value.isEmpty) {
                                return "enter Email";
                              } else if (!emailValid) {
                                return "Enter Valid Email";
                              }
                              return value;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 20.0),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              obscureText: _obscureText,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter PaSsword";
                                } else if (_passwordController.text.length <
                                    6) {
                                  return "password length should not be more than 6";
                                }
                              }),
                        ],
                      ),
                    ),
                    // forgot password container
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'forgot password?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 10, 200, 80),
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // the buttons widget
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text)
                                  .then(
                                    (value) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MapGoogle()),
                                    ),
                                  )
                                  .onError((error, stackTrace) => null);
                              if (_formfield.currentState!.validate()) {
                                print('successful');
                                _emailController.clear();
                                _passwordController.clear();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 1,
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 86, 79),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              minimumSize: const Size(20, 40.0),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                            ),
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Or',
                            style: TextStyle(
                              fontSize: 15.0,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                                  const Color.fromARGB(255, 240, 240, 240),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              minimumSize: const Size(20, 40.0),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                            ),
                            icon: Image.asset(
                              'images/google_icon.png',
                            ),
                            label: const Text(
                              'Continue with Google',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                                  const Color.fromARGB(255, 240, 240, 240),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              minimumSize: const Size(20, 40.0),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                            ),
                            icon: Image.asset(
                              'images/facebook_icon.png',
                            ),
                            label: const Text(
                              'Continue with Facebook',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    // Don't have an account message container
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()),
                              );
                            },
                            child: const Text(
                              ' ' 'Sign Up',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 10, 200, 80),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
