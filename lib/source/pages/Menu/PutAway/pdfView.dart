class PDFView {
  static htmlContent(html, gambar) {
    return """
<html>
<body>
    ${html}
    <br>
    <table style="font: 10pt;" width="100%" border="1" cellpadding="0" cellspacing="0">
    
     <tr>
      <td rowspan="2" width="50%" align="center"><img src="http://182.253.45.29:88/api-dev04/assets/images/TDI001-230127-1-003.jpg" alt="" width="60px"></td>
      <td width="30px" align="center">QC</td>
      <td width="30px" align="center">PPIC</td>
    </tr>
    <tr>
    <td width="30px" align="center"><br/><br/><br/></td>
    <td width="30px" align="center"><br/><br/><br/></td>
    </tr>
    </table> 
</body>
</html>
""";
  }
}
