function getParameterByName(name) {
	name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),results = regex.exec(location.search);
	return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}
function expandCollapse(id){
	if(document.getElementById(id).className == 'hide'){
		document.getElementById(id).className='show';
	}
	else{
		document.getElementById(id).className='hide';
	}
}

function valsGencode(){
	var version = $("#selectGencode").val();
	$("a.cambiar").each(function() {
		var origin = $(this).attr('href');
		var originArr = origin.split("/");
		originArr[originArr.length-3] = version;
		var dest = originArr.join("/");
		$(this).attr('href',dest);
	});
	$("area.cambiar").each(function() {
		var origin = $(this).attr('href');
		var originArr = origin.split("/");
		originArr[originArr.length-3] = version;
		var dest = originArr.join("/");
		$(this).attr('href',dest);
	});
}
$(function() {
	$( "#tabs" ).tabs();
});
$(window).load(function(){
	$(".loading").fadeOut("slow",function(){
		$(".contenido").fadeIn("slow",function(){
			var miDiv = getParameterByName("div");
			if(miDiv!=null && miDiv!=""){
				if (document.getElementById(miDiv)!=null){
					document.getElementById(miDiv).className='show';
					document.getElementById(miDiv).scrollIntoView();
				}
				var miSmpDiv = getParameterByName("smpdiv");
				if(miSmpDiv!=null && miSmpDiv!=""){
					if(document.getElementById(miSmpDiv)!=null){
						document.getElementById(miSmpDiv).className='show';
					}
				}
				var miOverlay = getParameterByName("over");
				if(miOverlay!=null && miOverlay!=""){
					var overl = "#"+miOverlay;
					$(overl).overlay({
						mask:{color: '#ffffff',opacity: 0},
						closeOnClick: true,
						fixed:false
					});
					$(overl).overlay().load();
					var miMap = $(overl).find("map").first();
					var miChr = getParameterByName("chrom");
					if(miChr!=null && miChr!=""){
						if(miChr=="Unknown" || miChr=="M"){
							var linkResults = $(overl).find("a").map(function(i,el){if(el.href.indexOf("chr"+miChr+".tsv")>=0){return el;}})[0].click();
						}else{
							var linkResults = $(overl).find("area").map(function(i,el){if(el.href.indexOf("chr"+miChr+".tsv")>=0){return el;}})[0].click();
						}
					}
				}
			}
		});
	});
});
$(document).ready(
	function() {
		$(".miIframe").iFrameResize({heightCalculationMethod:'grow'});
		//valsGencode();
		//$('select.gencodeSel').change(valsGencode);
		$("a[rel]").overlay({
			mask:{color: '#ffffff',opacity: 0},
			closeOnClick: true,
			fixed:false
		});
		$("th[rel]").overlay({
			mask:{color: '#ffffff',opacity: 0},
			closeOnClick: true,
			fixed:false
		});
		$("td[rel]").overlay({
			mask:{color: '#ffffff',opacity: 0},
			closeOnClick: true,
			fixed:false
			});
		var cellt = getParameterByName("cellt");
		var index = $('#tabs a[href="#'+cellt+'"]').parent().index();
		$("#tabs").tabs("option","active",index);
});
