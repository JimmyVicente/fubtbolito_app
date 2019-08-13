

class User{
  static String url;
  static int id;
  static String first_name;
  static String last_name;
  static String username;
  static String email;
  static String password;
  static bool is_staff;


   void insertUser(Map obj){
     url=obj['url'];
     id = obj['id'];
     first_name=obj['first_name'];
     last_name=obj['last_name'];
     username=obj['username'];
     email=obj['email'];
     password=obj['password'];
     is_staff=obj['is_staff'];
   }

}

