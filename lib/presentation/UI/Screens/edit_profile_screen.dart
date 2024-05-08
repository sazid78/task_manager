import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/controller/auth_controller.dart';
import 'package:task_manager/data/model/user_model.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/UI/Widgets/body_background.dart';
import 'package:task_manager/presentation/UI/Widgets/center_circuler_indicatior.dart';
import 'package:task_manager/presentation/UI/Widgets/profile_summery_card.dart';
import 'package:task_manager/presentation/UI/Widgets/snack_message.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _firstNameTEcontroller = TextEditingController();
  final TextEditingController _lastNameTEcontroller = TextEditingController();
  final TextEditingController _mobileTEcontroller = TextEditingController();
  final TextEditingController _photoTEcontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _updateProfileInProgress = false;

  XFile? photo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTEcontroller.text = AuthController.user!.email ?? '';
    _firstNameTEcontroller.text = AuthController.user!.firstName ?? '';
    _lastNameTEcontroller.text = AuthController.user!.lastName ?? '';
    _mobileTEcontroller.text = AuthController.user!.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(
              enableOnTap: false,
            ),
            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Update Profile",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          photoPickerField(),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Update your email";
                              }
                            },
                            controller: _emailTEcontroller,
                            decoration: const InputDecoration(
                              hintText: "Email",
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Update your First  name";
                              }
                            },
                            controller: _firstNameTEcontroller,
                            decoration: const InputDecoration(
                              hintText: "First Name",
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Update your last name";
                              }
                            },
                            controller: _lastNameTEcontroller,
                            decoration: const InputDecoration(
                              hintText: "Last Name",
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Update your mobile";
                              }
                            },
                            controller: _mobileTEcontroller,
                            decoration: const InputDecoration(
                              hintText: "Mobile",
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Visibility(
                              visible: _updateProfileInProgress == false,
                              replacement:
                                  const CenterCircularProgressIndicator(),
                              child: ElevatedButton(
                                onPressed: _updateProfile,
                                child: const Icon(
                                  Icons.arrow_circle_right_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container photoPickerField(){
    return Container(
      height: 45,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Photo",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () async{
                final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 50);
                if(image != null){
                  photo = image;
                  if(mounted){
                    setState(() {

                    });
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                child: Visibility(
                  visible: photo == null,
                    replacement: Text(photo?.name ?? ''),
                    child: const Text("Select a photo")),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProfile() async {
    if (_formkey.currentState!.validate()) {
      _updateProfileInProgress = true;
      setState(() {});
      String? photoInBase64;
      Map<String, dynamic> inputData = {
        "email": _emailTEcontroller.text.trim(),
        "firstName": _firstNameTEcontroller.text.trim(),
        "lastName": _lastNameTEcontroller.text.trim(),
        "mobile": _mobileTEcontroller.text.trim(),
      };

      if(photo != null){
        List<int> imageBytes = await photo!.readAsBytes();
        photoInBase64 = base64Encode(imageBytes);
        inputData["photo"] = photoInBase64;
      }

      final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.updateProfile,
        body: inputData
      );
      _updateProfileInProgress = false;
      setState(() {});
      if (response.isSuccess) {
        AuthController.updateUserInformation(
          UserModel(
            email: _emailTEcontroller.text.trim(),
            firstName: _firstNameTEcontroller.text.trim(),
            lastName: _lastNameTEcontroller.text.trim(),
            mobile: _mobileTEcontroller.text.trim(),
            photo: photoInBase64 ?? AuthController.user?.photo
          ),
        );
        if (mounted) {
          appSnackMessage(context, "Your Profile has been updated");
        }
        if (mounted) {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => const MainBottomNavScreen()));
        }
      } else {
        if (mounted) {
          appSnackMessage(
              context, "Profile Updated failed. try again later", true);
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameTEcontroller.dispose();
    _lastNameTEcontroller.dispose();
    _mobileTEcontroller.dispose();
    _emailTEcontroller.dispose();
  }
}
