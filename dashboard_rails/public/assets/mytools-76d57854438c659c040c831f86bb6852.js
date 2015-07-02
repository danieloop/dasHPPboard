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
$(document).ready(
	function() {
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
		var miDiv = getParameterByName("div");
		if(miDiv!=null){
			document.getElementById(miDiv).className='show';
			document.getElementById(miDiv).scrollIntoView();
			var miSmpDiv = getParameterByName("smpdiv");
			if(miSmpDiv!=null){
				if(document.getElementById(miSmpDiv)!=null){
					document.getElementById(miSmpDiv).className='show';
				}
			}
			var miOverlay = getParameterByName("over");
			if(miOverlay!=null){
				var overl = "#"+miOverlay;
				$(overl).overlay({
					mask:{color: '#ffffff',opacity: 0},
					closeOnClick: true,
					fixed:false
				});
				$(overl).overlay().load();
			}
		}
});
