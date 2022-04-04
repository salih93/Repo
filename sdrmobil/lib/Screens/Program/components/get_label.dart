class GetLabel
{
  String getText(int menuGoruntule){
    String text="";

    switch (menuGoruntule) {
      case 0:  
        text="Ziyaret Planlama";      
        break;
      case 1:
        text="Müşteri Ziyareti";
        break;
      case 2:
        text="Siparişler";
        break;
      case 3:        
        text="Tahsilatlar";
        break;
      case 4:        
        text="Raporlar";
        break;
      case 5:        
        text="Ayarlar";
        break;     
      case 6:        
        text="Aktarımlar";
        break;

      default:
    }

    return text;
  }

}
