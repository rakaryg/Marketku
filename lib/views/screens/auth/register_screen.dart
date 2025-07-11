import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketku/providers/auth/auth_provider.dart';
import 'package:marketku/providers/loading/loading_provider.dart';
import 'package:marketku/utils/custom_colors.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    late String email;
    late String fullname;
    late String password;
    bool isLoading = ref.watch(isLoadingProvider);
    void submitSignUp() async {
      if (formKey.currentState!.validate()) {
        try {
          ref.read(isLoadingProvider.notifier).state = true;
          await ref
              .read(userNotifierProvider.notifier)
              .register(fullname, email, password);
        } catch (_) {
        } finally {
          ref.read(isLoadingProvider.notifier).state = false;
        }
      }
    }

    var firstPassword = "";
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Marketku",
                    style: GoogleFonts.lato(
                        color: CustomColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        letterSpacing: 0.2),
                  ),
                  Text(
                    "Come and join us!",
                    style: GoogleFonts.lato(color: Colors.grey, fontSize: 16),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Email",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (value) => email = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email cannot be empty";
                      }
                      if (!value.contains("@")) {
                        return "Email not valid";
                      }
                      return null;
                    },
                    style: GoogleFonts.nunitoSans(
                        color: Colors.black, fontSize: 16),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: CustomColors.secondary),
                      ),
                      enabledBorder: InputBorder.none,
                      labelText: "Enter your email",
                      labelStyle: GoogleFonts.nunitoSans(fontSize: 14),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          "assets/icons/ic_email.svg",
                          width: 5,
                          height: 5,
                        ),
                      ),
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Name",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (value) => fullname = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name cannot be empty";
                      }
                      return null;
                    },
                    style: GoogleFonts.nunitoSans(
                        color: Colors.black, fontSize: 16),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: CustomColors.secondary),
                      ),
                      enabledBorder: InputBorder.none,
                      labelText: "Enter your name",
                      labelStyle: GoogleFonts.nunitoSans(fontSize: 14),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          "assets/icons/ic_name.svg",
                          width: 5,
                          height: 5,
                        ),
                      ),
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Password",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) => password = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      if (value.length < 6) {
                        return "Minimum length is 6";
                      }
                      firstPassword = value;
                      return null;
                    },
                    style: GoogleFonts.nunitoSans(
                        color: Colors.black, fontSize: 16),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: CustomColors.secondary),
                      ),
                      enabledBorder: InputBorder.none,
                      labelText: "Enter your password",
                      labelStyle: GoogleFonts.nunitoSans(fontSize: 14),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          "assets/icons/ic_password.svg",
                          width: 5,
                          height: 5,
                        ),
                      ),
                      suffixIcon: const Icon(Icons.visibility),
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Confirm Password",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value != firstPassword) {
                        return "Password is not same";
                      }
                      return null;
                    },
                    style: GoogleFonts.nunitoSans(
                        color: Colors.black, fontSize: 16),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: CustomColors.secondary),
                      ),
                      enabledBorder: InputBorder.none,
                      labelText: "Re-enter your password",
                      labelStyle: GoogleFonts.nunitoSans(fontSize: 14),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          "assets/icons/ic_password.svg",
                          width: 5,
                          height: 5,
                        ),
                      ),
                      suffixIcon: const Icon(Icons.visibility),
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              submitSignUp();
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: CustomColors.primary,
                            ),
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have account?",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black, fontSize: 12),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Click here",
                          style: GoogleFonts.nunitoSans(
                              color: CustomColors.primary, fontSize: 12),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
