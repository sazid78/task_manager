import 'package:task_manager/data/model/task_summery.dart';

class TaskCountSummeryModel {
  String? status;
  List<TaskSummery>? taskCountList;

  TaskCountSummeryModel({this.status, this.taskCountList});

  TaskCountSummeryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskCountList = <TaskSummery>[];
      json['data'].forEach((v) {
        taskCountList!.add(TaskSummery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.taskCountList != null) {
      data['data'] = this.taskCountList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


