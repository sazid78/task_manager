import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_list_model.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/UI/Widgets/center_circuler_indicatior.dart';
import 'package:task_manager/presentation/UI/Widgets/profile_summery_card.dart';
import 'package:task_manager/presentation/UI/Widgets/task_item_card.dart';

class TodoTaskScreen extends StatefulWidget {
  const TodoTaskScreen({super.key});

  @override
  State<TodoTaskScreen> createState() => _TodoTaskScreenState();
}

class _TodoTaskScreenState extends State<TodoTaskScreen> {
  bool todoTaskListInProgress =  false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getTodoTaskList() async {
    todoTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.createTodoTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    todoTaskListInProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodoTaskList();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const ProfileSummeryCard(),
          Expanded(
            child: Visibility(
              visible: todoTaskListInProgress == false,
              replacement: const CenterCircularProgressIndicator(),
              child: RefreshIndicator(
                onRefresh: () async{
                  await getTodoTaskList();
                },
                child: ListView.builder(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskItemCard(
                      taskList: taskListModel.taskList![index],
                      message: "Todo",
                      buttonColor: Colors.orange,
                      onChangeStatus: (){
                        getTodoTaskList();
                      },
                      showProgress: (inProgress){
                        todoTaskListInProgress = inProgress;
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
