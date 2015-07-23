// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require turbolinks
//= require_tree .
//= require jquery_nested_form

var opacnt=5; //透明度の増減の間隔
var timer=10; //setTimeout関数の実行間隔　ミリ秒
var flag=0;

function ChangeImg(img_name){
	if(flag==0){
		flag=1;
		FadeOutImg();
		setTimeout("Change('"+img_name+"')", timer*100/opacnt);
		setTimeout("FadeInImg()", timer*100/opacnt);
		setTimeout("flag=0", 2*timer*100/opacnt);
	}
}

function Change(img_name){
	document.main_image.src = img_name;
}

// フェードアウト
function FadeOutImg()
{
	opa=100;
    ImgId = "main_image";
    MyIMG = document.getElementById(ImgId);
    FadeOut(ImgId,opa);
}
//透明度を減少していきます。
function FadeOut(ImgId,opa)
{
    if (opa >= 0)
    {
        MyIMG.style.filter = "alpha(opacity:"+opa+")"; // IE のソース
        MyIMG.style.opacity = opa/100; //Mozilla Firefoxのソース
        opa -= opacnt;
        setTimeout("FadeOut('"+ImgId+"',"+opa+")", timer);
    }
}

// フェードイン
function FadeInImg()
{
	opa=0;
    ImgId = "main_image";
    MyIMG = document.getElementById(ImgId);
    FadeIn(ImgId,opa);
}
//透明度を増加していきます。
function FadeIn(ImgId,opa)
{
    if (opa <= 100)
    {
        MyIMG.style.filter = "alpha(opacity:"+opa+")"; // IE のソース
        MyIMG.style.opacity = opa/100; //Mozilla Firefoxのソース
        opa += opacnt;
        setTimeout("FadeIn('"+ImgId+"',"+opa+")", timer);
    }
}

//checkbox一括チェック
$(document).ready(function() {
    $('#check_all').click(function(){
    if(this.checked){
    $('.del_check').prop('checked','checked');
    }else{
    $('.del_check').removeAttr('checked');
    }});
});

//PageTopボタン フェードイン
$(function() {
    var topBtn = $('#page-top');    
    topBtn.hide();
    //スクロールが100に達したらボタン表示
    $(window).scroll(function () {
        if ($(this).scrollTop() > 100) {
            topBtn.fadeIn();
        } else {
            topBtn.fadeOut();
        }
    });
    //スクロールしてトップ
    topBtn.click(function () {
        $('body,html').animate({
            scrollTop: 0
        }, 500);
        return false;
    });
});