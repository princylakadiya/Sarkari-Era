class PdfJsonParse{
  List<pdf> pdfJsonParse=[];
  PdfJsonParse({required Map map})
  {
    for(int i=0;i<map['data'].length;i++)
      {
        pdf p1=pdf(map: map['data'][i]);
        pdfJsonParse.add(p1);
      }
  }
}
class pdf {
  String? name;
  String? category;
  String? pdfurl;

  pdf({required Map map})
  {
    name=map['name'];
    category=map['category'];
    pdfurl=map['pdfurl'];
  }
}