<?php

$num = 100;

header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

?>
<html>
<head>
<title>trollspray</title>
<link href='//fonts.googleapis.com/css?family=Rambla' rel='stylesheet' type='text/css'>
<style>
body,td {
  font-family: 'Rambla', serif;
  font-size: 0.9em;
}
p,ol,li {
  border-width:1px;
}
</style>
</head>
<body>

<table cellspacing="10">
<tr>
<td valign="top"><img src="fuckingtrolls.jpg" /></td>
<td valign="top" rowspan="2">
<h3>top <?=$num?> assholes:</h3>
<ol>

<?php

$db = @mysqli_connect("localhost", "trollspray", "fucktrolls");
if($db) {
  $rc = @mysqli_select_db($db, "trollspray");
  if($rc) { // die("error: olmasaydi iyiydi");
    $res = @mysqli_query($db, "select t.nick nick, t.cnt cnt from trollcnt t join users u on u.userid=t.troll where u.status=1 order by t.cnt desc limit $num");
    if($res) { // die("error: query edemedik");
      while($row = mysqli_fetch_row($res)) {
        echo "<li><a href='https://eksisozluk.com/biri/" . str_replace(" ", "-", $row[0]) . "' target=_blank>" . $row[0] . "</a> (" . $row[1] . ") </li>\n";
      }
      mysqli_free_result($res);
   }
 }
 mysqli_close($db);
}
?>
</ol>
</td>
</tr>
<tr>
<td valign="top" height="100%">
<h3>install:</h3>
<p>firefox:</p>

<ol>
<li>once <a href="https://addons.mozilla.org/en-US/firefox/addon/greasemonkey/" target=_blank>grease monkey</a></li>
<li>sonra <a href="https://mindtrick.net/trollspray/script/trollspray.user.js">trollspray.user.js</a></li>
</ol>

<p>safari:</p>

<ol>
<li>once <a href="https://github.com/os0x/NinjaKit" target=_blank>ninjakit</a></li>
<li>sonra <a href="https://mindtrick.net/trollspray/script/trollspray.user.js">trollspray.user.js</a></li>
</ol>

<p>chrome:</p>

<ol>
<li>sadece <a href="https://chrome.google.com/webstore/detail/eki-sozluk-troll-spray/kpinolcgjckidocjlojbchhnlhdibnbh" target=_blank>trollspray</a>
</ol>

<p>source:</p>

<ol>
<li>sadece <a href="https://github.com/arslanm/trollspray" target=_blank>@github</a>
</ol>

<p>yardim:</p>

<ol>
<li>(bkz: <a href="https://eksisozluk.com/trollspray" target=_blank>trollspray</a>)
</ol>
</td></tr></table>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-85744-1', 'auto');
  ga('send', 'pageview');

</script>

</body>
</html>
