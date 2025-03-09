import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buyhive/screens/login.dart';


class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  double betweengap = 24;
  
final TextEditingController fullNameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController addressController = TextEditingController();
final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

Future<void> createUser(BuildContext context) async {
  try {
    // Input validation
    if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email aur Password required hai")),
      );
      return;
    }

    // Firebase Authentication ke liye user create karna
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    // Firestore me user data store karna
    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
      'fullName': fullNameController.text.trim(),
      'phoneNumber': phoneController.text.trim(),
      'email': emailController.text.trim(),
      'address': addressController.text.trim(),
      'username': usernameController.text.trim(),
      'createdAt': DateTime.now(),
    });

    print("User Registered and Data Saved!");

    // Navigate to Login Screen
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    }

  } on FirebaseAuthException catch (e) {
    String errorMessage = "Kuchh galat ho gaya!";
    if (e.code == 'email-already-in-use') {
      errorMessage = "Yeh email already registered hai!";
    } else if (e.code == 'weak-password') {
      errorMessage = "Password weak hai, strong password choose karein!";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );

  } on FirebaseException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Firestore Error: ${e.message}")),
    );

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 2),
              Image.asset(
                'assets/images/logo.png',
                height: 200,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Create Account',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              SizedBox(height: 28),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildTextField('Full Name', 'Enter your full name', fullNameController),
                    SizedBox(height: betweengap),
                    buildPhoneNumberField(),
                    SizedBox(height: betweengap),
                    buildTextField('Email', 'Enter your email',emailController),
                    SizedBox(height: betweengap),
                    buildTextField('Address', 'Enter your full Address',addressController),
                    SizedBox(height: betweengap),
                    buildTextField('User Name', 'Enter your User Name',usernameController),
                    SizedBox(height: betweengap),
                    buildPasswordField(),
                    SizedBox(height: betweengap),
                    buildCreateAccountButton(),
                    SizedBox(height: 10),
                    buildLoginText(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hintText,TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPhoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Phone Number',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        IntlPhoneField(
          decoration: InputDecoration(
            hintText: '|  Enter your phone number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          initialCountryCode: 'IN',
          showCountryFlag: false,
          showCursor: true,
          showDropdownIcon: true,
          onChanged: (phone) {
          phoneController.text = phone.completeNumber; // 🔹 Extracting phone number
        },
        ),
      ],
    );
  }

  Widget buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Password',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: passwordController,
          obscureText: _isObscure,
          decoration: InputDecoration(
            hintText: 'Enter your Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility_off : Icons.visibility,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCreateAccountButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
        if (_formKey.currentState!.validate()) {
          createUser(context);
        }
      },
        child: Text(
          'Create Account',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget buildLoginText() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      child: Text(
        'Already have an Account? Login',
        style: TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }
}
