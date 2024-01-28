import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_app/Auth/login.dart';
import 'package:notes_app/Widgets/show_snackbar.dart';

import '../Screens/home_page.dart';

class AuthService {
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const HomePage();
          // Navigate to the home page.
        } else {
          // User is not signed in.
          return const LoginScreen(); // Navigate to the login page.
        }
      },
    );
  }



  signInWithGoogle(BuildContext context) async{
      try{
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        return await FirebaseAuth.instance.signInWithCredential(credential);

      }catch(e){
        debugPrint(e.toString());
        return null;
      }
   }
   signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        showSnackBar("Logged Out Successfully", context, Icons.done, Colors.green);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar("Something gone wrong!", context, Icons.error, Colors.red);
      }
    }
  }
}