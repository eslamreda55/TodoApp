class UserModel
{
  String name;
  String email;
  String uId;
  String phone;
  

  UserModel({
    this.name,
    this.email,
    this.uId,
    this.phone,
    
  });

  UserModel.fromJson(Map<String , dynamic>json)
  {
    name = json['name'] ;
    email = json['email'] ;
    uId = json['uId'] ;
    phone = json['phone'] ;
   
  }

  Map<String , dynamic> tomap()
  {
    return 
    {
      'name':name,
      'email':email,
      'uId':uId,
      'phone':phone,
      
    };
  }
}