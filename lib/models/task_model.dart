class TaskModel
{
  String title;
  String description;
  String date;
  String time;
  String uId;

  TaskModel({
    this.title,
    this.description,
    this.date,
    this.time,
    this.uId,
  });

  TaskModel.fromJson(Map<String , dynamic>json)
  {
    title = json['title'] ;
    description = json['description'] ;
    date = json['date'] ;
    time = json['time'] ;
    uId = json['uId'] ;
  }

  Map<String , dynamic> tomap()
  {
    return 
    {
      'title':title,
      'description':description,
      'date':date,
      'time':time,
      'uId':uId,
      
    };
  }
}