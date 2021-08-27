

//After rewatching course


//1) Auth log out after session expires
//Main ma ? halne with consumer.
//clear shared preferences add await in logout
//prefs.remove, prefs.clear()(remove all the datas).


//2) Auto Login
//shared pref


// return future ,final prefs= awitSharedPreferences.getInstance();
//prefs.setString(key,value); if complex data use json and json is always string
//String value=json.encode({
// 'userId,token, expiryDateto iso format':})


//Future<bool> tryAutoLogin() async {
// if prefs.containsKey('userData') {
// prefs.getString('userData);
//json.decode to get expiry data , DateTime.parse(iso format)
//expiryDate.isBefore DateTime.now() return false
//reinitialize all the global variables
//notigy listener and auto log out plus return true
// }else reture false}
//main ma future builter tesma auto login.


//)Add splash screen

//)Store image of user while signup
//))Chart Page

//)Animations in order
//)Solve bugs


// Rough
