class MusteriToplamlari{
  String carikodu;
  String unvan;
  int index;
  double toplamSMiktar;
  double toplamSTutar;
  double toplamIMiktar;
  double toplamITutar;
  double toplamNMiktar;
  double toplamKdvsiz;
  
  MusteriToplamlari({
    this.carikodu, 
    this.unvan, 
    this.index, 
    this.toplamSMiktar, 
    this.toplamSTutar, 
    this.toplamIMiktar, 
    this.toplamITutar,
    this.toplamNMiktar,
    this.toplamKdvsiz
  });

  MusteriToplamlari.fromJson(Map<String, dynamic> json) {
    carikodu = json['cari_kodu'];
    unvan = json['unvan'];
    toplamSMiktar = json['toplamSMiktar'];
    toplamSTutar = json['toplamSTutar'];    
    toplamIMiktar = json['toplamIMiktar'];
    toplamITutar = json['toplamITutar'];
    toplamNMiktar = json['toplamNMiktar'];
    toplamKdvsiz = json['toplamKdvsiz'];
  }

}