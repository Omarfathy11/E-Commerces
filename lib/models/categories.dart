class CategoriesModel {
  
  String? name;

  // refatoring 
CategoriesModel.fromJson({required Map<String, dynamic> data}){
  name = data['name'];

}


}