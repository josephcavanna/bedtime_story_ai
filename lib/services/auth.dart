import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bedtime_story_ai/services/delete_user.dart';

final supabase = Supabase.instance.client;

class Auth {
  signUp(String email, String password) async {
    await supabase.auth.signUp(email: email, password: password);
  }

  signIn(String email, String password) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  signOut() async {
    await supabase.auth.signOut();
  }

  currentUser() {
    supabase.auth.currentUser;
  }

  signedIn() {
    bool signedIn = false;
   if (supabase.auth.currentUser != null) {
    signedIn = true;
   }
   return signedIn;
  }

  deleteAllStories() async {
    await supabase.from('stories').delete().eq('id',supabase.auth.currentUser!.id);
  }

  deleteUser() {
    DeleteUser(supabase.functions).deleteAccount();
  }

  userEmail() {
    final email = supabase.auth.currentUser?.email;
    return email;
  }

  resetPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  Future<void>updatePassword(String password) async {
    await supabase.auth.updateUser(
      UserAttributes(password: password), // UserAttributes(
      );
  }
}