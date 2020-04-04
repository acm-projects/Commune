import 'package:commune_spring_2020/Pages/bill_expansion.dart';
import 'package:commune_spring_2020/screens/auth/AccountAccess.dart';
import 'package:flutter/material.dart';
import 'package:commune_spring_2020/Pages/app_card.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Backend Code
    String email="",password="",error="";
    final _formKey = GlobalKey<FormState>();
    final AuthService _auth = AuthService();

    
    return Scaffold(
    backgroundColor: Color.fromARGB(255, 126, 134, 233),

    body: Form(
        key: _formKey,
        child: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children:[
          Image(image: AssetImage('assets/CommuneLogo.png'),),
          Text(
          'Commune',
          style: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 242, 242, 242),
            fontFamily: 'Raleway'
          ),

        ),
         AppCard(
            child: Container(
            color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator:(e)=> e.isEmpty ? "Enter an Email" :null,
                    onChanged: (val){
                      email=val.toString();
                    },
                    style: TextStyle(
                      color: Colors.white
                    ),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                    
                      ),
                  ),
                  TextFormField(
                    obscureText: true,
                    validator:(e)=> e.isEmpty ? "Enter an Password" :null,
                    onChanged: (val){
                      password=val.toString();
                    },
                    style: TextStyle(
                      color: Colors.white
                    ),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                          ),
                          ),
                      ),
                    ]
                  ),
                )
              ),
              Text(
              error,
              style: TextStyle(color:Colors.red),
              ),
              FlatButton(
                onPressed: ()async{
                  if(_formKey.currentState.validate()){
                    dynamic result = await _auth.signIn(email, password);
                      if(result==null){
                        setState(()=>error="Yout username or password dont match our records");
                      }else{
                        
                      }
                    print("user is: "+result.toString());
                 }
                },
                child: Text("Sign in",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontSize: 18.0,
                ),
                ),
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white),
                   ),
              ),
              FlatButton(
                onPressed: (){
                  final formState = _formKey.currentState;
                  if(formState.validate()){
                    formState.save();
                    _showDialogForPasswordReset(context,email);
                 }
                },
                child: Text("Reset Password",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontSize: 18.0,
                ),
                ),
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white),
                   ),
              )
         ],
       ),
        ),
    )
    );
  }

   void _showDialogForPasswordReset(BuildContext context, String email)
  {
    print("\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"+email);
    showDialog(
      context: context,
      builder:(BuildContext context){
        return AlertDialog(
          title: new Text("Password Reset"),
          content: new Text('A password reset link was sent to '+email),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed:() {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}