import 'package:task_manager/presentation/UI/Widgets/task_item_card.dart';

class Urls{
  static const  String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static const  String signup = "$_baseUrl/registration";
  static const  String signIn = "$_baseUrl/login";
  static const  String updateProfile = "$_baseUrl/profileUpdate";
  static const  String createTask = "$_baseUrl/createTask";
  static  String createNewTask = "$_baseUrl/listTaskByStatus/${TaskStatus.New.name}";
  static  String createProgressTask = "$_baseUrl/listTaskByStatus/${TaskStatus.InProgress.name}";
  static  String createCompletedTask = "$_baseUrl/listTaskByStatus/${TaskStatus.Completed.name}";
  static  String createTodoTask = "$_baseUrl/listTaskByStatus/${TaskStatus.Todo.name}";
  static  String createCancelledTask = "$_baseUrl/listTaskByStatus/${TaskStatus.Cancelled.name}";
  static const String getTaskStatusSummery = "$_baseUrl/taskStatusCount";
  static String updateTaskStatus(String taskId, String status) => "$_baseUrl/updateTaskStatus/$taskId/$status";
  static String deleteTask(String taskId) => "$_baseUrl/updateTaskStatus/$taskId";
}
