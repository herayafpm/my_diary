import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_diary/components/my_button.dart';
import 'package:my_diary/components/my_flat_button.dart';
import 'package:my_diary/components/my_input.dart';
import 'package:my_diary/controller/login_controller.dart';
import 'package:my_diary/template/auth_template.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> key = GlobalKey<FormState>();
    return AuthTemplate(
        title: "Login My Diary",
        body: Form(
          key: key,
          child: Column(
            children: [
              MyInput(
                controller: controller.emailController,
                title: "Email",
                validator: (String value) {
                  if (value.isEmpty) {
                    return "email tidak boleh kosong";
                  }
                  if (!value.isEmail) {
                    return "email tidak valid";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Obx(() => MyInput(
                    obsecure: !controller.showPass.value,
                    controller: controller.passwordController,
                    title: "Password",
                    validator: (value) {
                      if (value.isEmpty) {
                        return "password tidak boleh kosong";
                      }
                      return null;
                    },
                    icon: Parent(
                        gesture: Gestures()
                          ..onTap(() {
                            controller.showPass.value =
                                !controller.showPass.value;
                          }),
                        child: (!controller.showPass.value)
                            ? Icon(
                                Icons.visibility,
                              )
                            : Icon(
                                Icons.visibility_off,
                              )),
                  )),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Obx(() => MyButton(
                  isLoading: controller.isLoading.value,
                  title: "Login",
                  onTap: (controller.isLoading.value)
                      ? () {}
                      : () {
                          if (key.currentState.validate()) {
                            controller.login();
                          }
                        })),
              SizedBox(
                height: Get.height * 0.02,
              ),
              MyFlatButton(
                  title: "Register",
                  onTap: () {
                    Get.offAllNamed("/auth/register");
                  }),
            ],
          ),
        ));
  }
}
