import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_create_summery_model.dart';
import 'package:task_manager/data/model/task_list_model.dart';
import 'package:task_manager/data/model/task_summery.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/UI/Screens/add_new_task_screen.dart';
import 'package:task_manager/presentation/UI/Widgets/center_circuler_indicatior.dart';
import 'package:task_manager/presentation/UI/Widgets/profile_summery_card.dart';
import 'package:task_manager/presentation/UI/Widgets/summery_card.dart';
import 'package:task_manager/presentation/UI/Widgets/task_item_card.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  bool getNewTaskInProgress = false;
  bool getTaskCountSummeryInProgress = false;

  TaskListModel taskListModel = TaskListModel();
  TaskCountSummeryModel taskCountSummeryModel = TaskCountSummeryModel();

  Future<void> getNewTaskList() async {
    getNewTaskInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.createNewTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getNewTaskInProgress = false;
    setState(() {});
  }

  Future<void> getTaskCountSummeryList() async {
    getTaskCountSummeryInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskStatusSummery);
    if (response.isSuccess) {
      taskCountSummeryModel =
          TaskCountSummeryModel.fromJson(response.jsonResponse);
    }
    getTaskCountSummeryInProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewTaskList();
    getTaskCountSummeryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
          if (response != null && response == true) {
            getNewTaskList();
            getTaskCountSummeryList();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            Visibility(
              visible: getTaskCountSummeryInProgress == false &&
                  (taskCountSummeryModel.taskCountList?.isNotEmpty ?? false),
              replacement: const LinearProgressIndicator(),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: taskCountSummeryModel.taskCountList?.length ?? 0,
                    itemBuilder: (context, index) {
                      TaskSummery taskSummery =
                          taskCountSummeryModel.taskCountList![index];
                      return FittedBox(
                        child: SummeryCard(
                            count: taskSummery.sum.toString(),
                            label: taskSummery.sId ?? ''),
                      );
                    }),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: getNewTaskInProgress == false,
                replacement: const CenterCircularProgressIndicator(),
                child: RefreshIndicator(
                  onRefresh: () async{
                    await getNewTaskList();
                    await getTaskCountSummeryList();
                  },
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        taskList: taskListModel.taskList![index],
                        message: "New",
                        buttonColor: Colors.blue,
                        onChangeStatus: (){
                          getNewTaskList();
                          getTaskCountSummeryList();
                        },
                        showProgress: (inProgress){
                          getNewTaskInProgress = inProgress;
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
      ),
    );
  }
}
