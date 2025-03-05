import 'dart:io';
void addTask(string,List){
  List.add(string);
}
void removeTask(idx,List){
  List.removeAt(idx);
}
void viewTasks(List){
  print("\nTasks:\n");
  for (int i=0; i<List.length;i++){
    print("${i+1}: ${List[i]}");
  }
  print("\n");
}
void main(){
  List<String> tasks = [];
  var choice;
  var task;
  int idx;
  print("\t To-Do List App");
  while (true){
    print("1: Add a task\n2: View Tasks\n3: Remove a Task\n4: Exit\n");
    choice = stdin.readLineSync();
    switch (choice){
      case "1":{
          print("Enter your task: ");
          task = stdin.readLineSync();
          addTask(task, tasks);          
      } break;  
      case "2":{
          viewTasks(tasks);
      } break;  
      case "3":{
        viewTasks(tasks);
          print("Enter the number of the task: ");
          idx = int.parse(stdin.readLineSync()!);
          removeTask(idx-1, tasks);          
      } break;  
      default:{
        return;
      }
    }
      
  }  
    
}
