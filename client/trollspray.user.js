// ==UserScript==
// @name        ek$i sozluk troll spray
// @namespace   https://mindtrick.net/trollspray
// @version     1.3.4
// @description	keep calm and don't feed the trolls
// @author      teo
// @license     WTFPL v2 (http://sam.zoy.org/wtfpl/COPYING)
// @include     https://eksisozluk.com/ayarlar/*
// @match       https://eksisozluk.com/ayarlar/*
// @downloadURL https://mindtrick.net/trollspray/script/trollspray.user.js
// @require     https://mindtrick.net/trollspray/script/lib/jquery.min.js
// @require     https://mindtrick.net/trollspray/script/lib/jquery.base64.min.js
// @require     https://mindtrick.net/trollspray/script/lib/rawdeflate.js
// @run-at      document-end
// @grant       none
// ==/UserScript==

NAME = "trollspray";
DESC = "aşağıdaki butona bastığınızda badi/troll listeniz trollspray havuzuna gönderilecek " +
       "ve bunun sonucunda en cok troll listesine eklenmis kişiler troll listenize eklenecek. " +
       "bu liste oluşturulurken badi listenizden de faydalanılmaktadır. dolayısıyla size özeldir. " +
       "<br/><p>daha fazla bilgi için <a href='http://mindtrick.net/trollspray/' target=_blank>tıklayın</a></p>";

VERSION = "1.3.4";
CANIURL = "https://mindtrick.net/trollspray/cani.php?" + VERSION;
SPRAYURL = "https://mindtrick.net/trollspray/incoming.php?" + VERSION;
BTURL = "https://eksisozluk.com/badi-engellenmis";

FEEDBUTTON = "benim listeyi gönder ve troll listesini getir"
SAVEBUTTON = "seçilenleri ekle";
SAVEALLBUTTON = "hepsini ekle";
WAITBUTTON = "lütfen bekleyin.."
SELALLBUTTON = "hepsini seç";
SELNONEBUTTON = "hiçbirini seçme";

var tries;
var curtrolls;
var savetrolls;
var pushtrolls;
var addedtrolls;
var allselected;

function togglesavebuttons() {
  var $sb = $("#savebutton");
  var $sab = $("#saveallbutton");
  var $saonb = $("#selallornonebutton");
  if($sb.prop("disabled")) {
    $sb.text(SAVEBUTTON)
       .prop("disabled", false)
       .attr("class", "primary");

    $sab.text(SAVEALLBUTTON)
        .prop("disabled", false)
        .attr("class", "primary");
    $saonb.prop("disabled", false)
  } else {
    $sb.text(WAITBUTTON)
       .prop("disabled", true)
       .removeClass();
 
    $sab.text(WAITBUTTON)
        .prop("disabled", true)
        .removeClass();
    $saonb.prop("disabled", true)
  }
}

function togglefeedbutton() {
  var $tb = $("#feedbutton");
  if($tb.prop("disabled")) {
    $tb.text(FEEDBUTTON)
       .prop("disabled", false)
       .attr("class", "primary");
  } else {
    $tb.text(WAITBUTTON)
        .prop("disabled", true)
        .removeClass();
  }
}

function addtroll(ps, idx) {
  if(idx == pushtrolls.length) return;
  var id = pushtrolls[idx][0];
  var troll = pushtrolls[idx][1];
  var turl = pushtrolls[idx][2];
  if(tries[id] == undefined) tries[id] = 1;
  else tries[id]++;
  $.ajax({
    url : turl,
    type: "POST",
    headers: {
      'X-Requested-With' : 'XMLHttpRequest'
    }
  }).done(function(data) {
     var $t = $("#troll_" + id);
      if(data.Code == "Added") {
        $t.text("✓ " + troll);
        addedtrolls++;
        $("#pshit").text(ps + " " + addedtrolls + " eklendi..");
        addtroll(ps, idx+1);
      } else if(data.Code == "Removed") {
        if(tries[id] < 3) {
          $t.text("✗ " + troll);
          addtroll(ps, idx);
        } else {
          $t.text("✗ " + troll);
        }
      } else if(data.Code == "LimitReached") {
        $t.text("✗ (limit) " + troll);
      } else {
        $t.text("✗ " + troll);
      }
    })
    .fail(function(data) {
      $("#troll_id" + id).text("✗ (bilinmiyor) " + troll);
    })
}

function process(obj) {
  if(obj.status == "error") { alert(obj.data); return false; }
  var cnd = obj.data.candidates;
  if(!cnd) { alert("havuzda problem var, daha sonra tekrar deneyin"); return false; }
  var $div = $("#trollcandidates");
  if(!$div) return false;
  $div.html("<br />");
  var inids = new Array();
  for(i = 0 ; i < cnd.length ; i++) inids.push(cnd[i].id);
  var diff = $(inids).not(curtrolls).get();
  var difflen = diff.length;
  
  if(difflen) {
    $div.append($("<p />", { id: "pshit", text: difflen + " troll önerildi.."}));
  } else {
    $div.append($("<p />", { text: "havuzdan gelen troll'lerin hepsi zaten listenizde.."}));
    return false;
  }
 
  $("#divfeed").hide();
  $("#divsave").show();
  savetrolls = new Array();
  for(i = 0 ; i < cnd.length; i++) {
    var k = cnd[i].id;
    if($.inArray(k, curtrolls) != -1) continue;
    var t = cnd[i].troll;
    savetrolls[k] = t;
    $div.append($("<span />", { id: "troll_" + k, text: "  " + t })
      .click(function() {
        $(this).toggleClass("trhi")
      })
    );
  }
}

function mtencode(s) {
  return $.base64.encode(RawDeflate.deflate(unescape(encodeURIComponent(s)),9));
}

function feedlist() {
  togglefeedbutton();
  $("#trollcandidates").html('');
  $.get(CANIURL, function(htmlc, statusc) {
    var r = JSON.parse(htmlc);
    if(r.status == "error") {
      togglefeedbutton();
      alert(r.data);
      return false;
    }
    $.get(BTURL, function(html, status) {
      if(status != "success") {
        togglefeedbutton();
        alert("başka türlü sorunlar çıktı");
        return;
      }
      if(html.match(/giris\?returnurl/)) {
        togglefeedbutton();
        alert("önce login olmanız lazım");
        return;
      }
      curtrolls = new Array();
      $(html).find(".relation-block").eq(1).find("a[data-userid]").each(function() {
        curtrolls.push($(this).attr("data-userid"));
      }); 
      $.post(SPRAYURL, mtencode(html), function(presponse, pstatus) {
        togglefeedbutton();
        if(pstatus != "success") {
          alert("yanlış giden bir şeyler var");
          return;
        }
        process(JSON.parse(presponse));
      })
      .fail(function(html, status) {
        togglefeedbutton();
        if(status == "error") {
          alert("havuzda problem var, daha sonra tekrar deneyin..");
          return;
        }
      })
    })
    .fail(function(html, status) {
      togglefeedbutton();
      if(status == "error") {
        alert("önce login olmanız gerekiyor olabilir mi?");
        return;
      }
    })
  })
  .fail(function(html, status) {
    togglefeedbutton();
    alert("havuzda problem var gibi sanki");
  })
}

function savelist() {
  var c = 0;
  $("#trollcandidates span.trhi").each(function() { c++; });
  if(!c) return false;
  $("#pshit").text($("#pshit").text() + " " + c + " ekleniyor..");
  togglesavebuttons();
  pushtrolls = new Array();
  addedtrolls = 0;
  $("#trollcandidates span.trhi").each(function() {
    var id = $(this).attr("id").substring(6);
    var nick = savetrolls[id];
    var url = "https://eksisozluk.com/biri/" + nick.replace(" ", "-") + "/togglerelation?id=" + id + "&r=blocked";
    pushtrolls.push([id, nick, url]);
  });
  tries = new Array();
  var ps = $("#pshit").text();
  addtroll(ps, 0);
  togglesavebuttons();
  $("#divfeed").show();
  $("#divsave").hide();
}

function selallornone() {
  allselected = !allselected;
  $("#trollcandidates span").each(function() {
    if(allselected) { 
      $("#selallornonebutton").text(SELNONEBUTTON);
      $(this).addClass("trhi");
    } else {
      $("#selallornonebutton").text(SELALLBUTTON);
      $(this).removeClass();
    }
  });
}

function savelistall() {
  $("#trollcandidates span").each(function() {
    $(this).addClass("trhi");
  });
  savelist();
}

function showpage() {
  $("#settings-tabs li").each(function(){
    $(this).text() == NAME ? $(this).attr("class", "active") : $(this).removeClass();
  });

  $("#content-body").replaceWith($("<section />", { id : "content-body" })
     .append($("<h1 />", { text: "ayarlar" }))
     .append($("#settings-tabs")));
  var $cb = $("#content-body");
  $cb.append($("<h2 />", { text: NAME }));
  $cb.append($("<p />", { html : DESC }));
  $cb.append($("<div />", { id: "divfeed" }).append($("<button />", { text: FEEDBUTTON , id: "feedbutton", class: "primary" }).click(feedlist)));
  $cb.append($("<div />", { id: "divsave" }).hide()
     .append($("<button />", { text: SAVEBUTTON, id: "savebutton", class: "primary" }).click(savelist))
     .append("&nbsp;-&nbsp;")
     .append($("<button />", { text: SAVEALLBUTTON, id: "saveallbutton", class: "primary" }).click(savelistall))
     .append("&nbsp;-&nbsp;")
     .append($("<button />", { text: SELALLBUTTON, id: "selallornonebutton", class: "primary" }).click(selallornone))
  );
  $cb.append($("<div />", { id: "trollcandidates" }));
}

function addstyle(s) {
  $("head").append($("<style />").attr("type", "text\/css").append(s));
}

$(document).ready(function(){
  allselected = false;
  $("#settings-tabs").append($("<li />").append($("<a />", {id: NAME, text: NAME }).click(showpage)));
  addstyle("#trollcandidates span { display: block; padding-left: 3px; margin:2px; width: 330px; border-bottom: 1px solid silver;}");
  addstyle("#trollcandidates span.trhi { background-color: #d7d7d7;}");
  addstyle("#trollcandidates span:hover { cursor: pointer; background-color: silver; color: white; }");
});
