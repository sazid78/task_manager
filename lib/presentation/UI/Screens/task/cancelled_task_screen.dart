import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_list_model.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/UI/Widgets/center_circuler_indicatior.dart';
import 'package:task_manager/presentation/UI/Widgets/profile_summery_card.dart';
import 'package:task_manager/presentation/UI/Widgets/task_item_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {

  bool cancelledTaskListInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getCancelledTaskList() async {
    cancelledTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.createCancelledTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    cancelledTaskListInProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCancelledTaskList();

  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Column(
        children: [
          const ProfileSummeryCard(),
          Expanded(
            child: Visibility(
              visible: cancelledTaskListInProgress == false,
              replacement: const CenterCircularProgressIndicator(),
              child: RefreshIndicator(
                onRefresh: () async{
                  await getCancelledTaskList();
                },
                child: ListView.builder(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskItemCard(
                      taskList: taskListModel.taskList![index],
                      message: "Cancelled",
                      buttonColor: Colors.red,
                      onChangeStatus: (){
                        getCancelledTaskList();
                      },
                      showProgress: (inProgress){
                        cancelledTaskListInProgress = inProgress;
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
