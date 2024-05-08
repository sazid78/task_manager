import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/UI/Screens/main_bottom_nav_screen.dart';
import 'package:task_manager/presentation/UI/Screens/task/new_task_screen.dart';
import 'package:task_manager/presentation/UI/Widgets/body_background.dart';
import 'package:task_manager/presentation/UI/Widgets/center_circuler_indicatior.dart';
import 'package:task_manager/presentation/UI/Widgets/profile_summery_card.dart';
import 'package:task_manager/presentation/UI/Widgets/snack_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEcontroller = TextEditingController();
  final TextEditingController _descriptionTEcontroller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool createTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       body: SafeArea(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
            const ProfileSummeryCard(),
             Expanded(
               child: BodyBackground(
                 child: Form(
                   key: _formKey,
                   child: Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: SingleChildScrollView(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const SizedBox(
                             height: 50,
                           ),
                           Text("Add New Task",style: Theme.of(context).textTheme.titleLarge),
                           const SizedBox(
                             height: 8,
                           ),
                           TextFormField(
                             controller: _subjectTEcontroller,
                             validator: (String? value){
                               if(value?.trim().isEmpty ?? true){
                                 return "Enter your subject";
                               }
                               return null;
                             },
                             decoration: const  InputDecoration(
                               hintText: "Subject"
                             ),
                           ),
                           const SizedBox(
                             height: 8,
                           ),
                           TextFormField(
                             controller: _descriptionTEcontroller,
                             validator: (String? value){
                               if(value?.trim().isEmpty ?? true){
                                 return "Enter your description";
                               }
                               return null;
                             },
                             decoration: const InputDecoration(
                                 hintText: "Description"
                             ),
                             maxLines: 7,
                           ),
                           const SizedBox(height: 8,),
                           SizedBox(
                             width: double.infinity,
                             child: Visibility(
                               visible: createTaskInProgress == false,
                               replacement: const CenterCircularProgressIndicator(),
                               child: ElevatedButton(onPressed: createTask, child: const Text("Add",style: TextStyle(
                                 color: Colors.white
                               ),)),
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

  Future<void> createTask() async{
    if(_formKey.currentState!.validate()){
      createTaskInProgress = true;
      setState(() {

      });
      NetworkResponse response = await NetworkCaller().postRequest(Urls.createTask,body: {
        "title":_subjectTEcontroller.text.trim(),
        "description":_descriptionTEcontroller.text.trim(),
        "status":"New"
      });

      createTaskInProgress = false;
      setState(() {

      });

      if(response.isSuccess){
        _subjectTEcontroller.clear();
        _descriptionTEcontroller.clear();
        if(mounted){
          appSnackMessage(context, "New task added successfully");
        }
        if(mounted){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MainBottomNavScreen()));
        }
      }else{
        if(mounted){
          appSnackMessage(context, "Create task failed . try again",true);
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subjectTEcontroller.dispose();
    _descriptionTEcontroller.dispose();
  }
}
