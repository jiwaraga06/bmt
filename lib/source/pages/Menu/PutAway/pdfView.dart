class PDFView {
  static htmlContent(html, gambar) {
    return """
<html>
<body>
    ${html}
    <br>
    <table style="font: 10pt;" width="100%" border="1" cellpadding="0" cellspacing="0">
    <h4>$gambar</h4>
    <img src="http://sivensys.com/upload/d9c3724fbd0e496a7633f591f003304d.jpg"/>
    <tr>
      <td rowspan="2" width="50%" align="center"><img src="$gambar" alt="" width="60px"></td>
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
