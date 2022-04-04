import 'dart:typed_data';

class MalzemePicture {
 final String path;
 final String malzemekodu;
 final Uint8List picture;

 MalzemePicture({this.path, this.malzemekodu, this.picture});

 factory MalzemePicture.fromMap(Map<String, dynamic> data) {
   return MalzemePicture(
      path: data["path"],
      malzemekodu: data["malzeme_kodu"],
      picture:data["picture"],
   );
 }
 
  Map<String, dynamic> toMap() => {
   "path": path,
   "malzeme_kodu": malzemekodu,
   "picture" : picture,
 };

}