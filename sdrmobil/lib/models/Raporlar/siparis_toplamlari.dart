class SiparisToplamlari{
  String siparisno;  
  double toplamSTutar;
  int index;
  
  SiparisToplamlari({
    this.siparisno,     
    this.toplamSTutar,
    this.index
  });

  SiparisToplamlari.fromJson(Map<String, dynamic> json) {
    siparisno = json['siparis_no'];    
    toplamSTutar = json['toplamSTutar'];
    index=json['index'];
  }

}