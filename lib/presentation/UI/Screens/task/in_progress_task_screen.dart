import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_list_model.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/UI/Widgets/center_circuler_indicatior.dart';
import 'package:task_manager/presentation/UI/Widgets/profile_summery_card.dart';
import 'package:task_manager/presentation/UI/Widgets/task_item_card.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool inProgressTaskListInProgress =  false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getInProgressTaskList() async {
    inProgressTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.createProgressTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    inProgressTaskListInProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInProgressTaskList();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const ProfileSummeryCard(),
          Expanded(
            child: Visibility(
              visible: inProgressTaskListInProgress == false,
              replacement: const CenterCircularProgressIndicator(),
              child: RefreshIndicator(
                onRefresh: () async{
                  await getInProgressTaskList();
                },
                child: ListView.builder(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskItemCard(
                      taskList: taskListModel.taskList![index],
                      message: "InProgress",
                      buttonColor: Colors.cyan,
                      onChangeStatus: (){
                        getInProgressTaskList();
                      },
                      showProgress: (inProgress){
                        inProgressTaskListInProgress = inProgress;
                        if(mounted){
                          setState(() {
            
                          });
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
