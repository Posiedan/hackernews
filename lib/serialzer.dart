import 'dart:convert' as json;


List<int> getintegers(String jsonstr){
 final parsed=json.jsonDecode(jsonstr);
 final listOfIds=List<int>.from(parsed);
 return listOfIds;

}

