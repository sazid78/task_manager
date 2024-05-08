import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

enum TaskStatus { New,Todo, InProgress, Completed, Cancelled }

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    super.key,
    required this.message,
    required this.taskList, required this.onChangeStatus, required this.showProgress, required this.buttonColor,
  });

  final String message;
  final Color buttonColor;
  final TaskList taskList;
  final VoidCallback onChangeStatus;
  final Function(bool) showProgress;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    final response = await NetworkCaller().getRequest(Urls.updateTaskStatus(widget.taskList.sId ?? '', status));
    if(response.isSuccess){
      widget.onChangeStatus();
    }
    widget.showProgress(false);
  }




  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskList.title ?? '',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              widget.taskList.description ?? '',
              maxLines: 2,
              style: const TextStyle(fontSize: 14),
            ),
            const Text("date: 12-12-12"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: widget.buttonColor,
                ),
                Wrap(
                  children: [
                    IconButton(
                        onPressed: () {
                          showUpdateStatus();
                        },
                        icon: const Icon(Icons.edit)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showUpdateStatus() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
              onTap: () {
                updateTaskStatus(e.name);
                Navigator.pop(context);
              },
              title: Text("${e.name}"),
            ))
        .toList();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Status"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),
            actions: [
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel"
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
