class UsersJsonParse{
  List<users> userJsonParse=[];
  UsersJsonParse({required Map map})
  {
    for(int i=0;i<map['data'].length;i++)
    {
      users u1=users(map: map['data'][i]);
      userJsonParse.add(u1);
    }
  }
}
class users {
  String? name;
  String? email;
  String? mno;
  String? password;

  users({required Map map})
  {
    name=map['name'];
    email=map['email'];
    mno=map['mno'];
    password=map['password'];
  }
}