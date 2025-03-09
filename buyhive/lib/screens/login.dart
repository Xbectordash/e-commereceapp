import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buyhive/screens/home.dart';
import 'package:buyhive/screens/createaccount.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  bool _rememberMe = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<String?> fetchEmailFromUsername(String username) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first['email'];
    }
    return null;
  }

  Future<void> loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      String email = usernameController.text.trim();
      String password = passwordController.text.trim();

      if (!email.contains('@')) {
        String? fetchedEmail = await fetchEmailFromUsername(email);
        if (fetchedEmail == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No user found with this username.")),
          );
          return;
        }
        email = fetchedEmail;
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Successful!")),
      );

    } on FirebaseAuthException catch (e) {
      String errorMessage = "Something went wrong.";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for this email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format.";
      } else if (e.code == 'network-request-failed') {
        errorMessage = "No internet connection.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );

    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 120,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'KDigitalCurry',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),

                    Text("Username or Email*", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: "Enter your username or email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Username or email is required";
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    Text("Password*", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Password is required";
                        if (value.length < 6) return "Password must be at least 6 characters";
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                            ),
                            Text("Remember Me"),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("Forgot Password?"),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : loginUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "Log In",
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateAccount()),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Don't Have an Account? ",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            children: [
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}