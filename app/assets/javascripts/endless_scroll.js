var currentPage = 1;
var intervalID = -1000;

function checkScroll() {
  if (nearBottomOfPage()) {
    currentPage++;
  	console.log("Request " + currentPage);
    jQuery.ajax('?page=' + currentPage, {asynchronous:true, evalScripts:true, method:'get', success: function(data, textStatus, jqXHR) {
		if(jQuery(data).find('.ressources').html().trim().length == 0){
			console.log(jQuery(data));
			console.log("Stopping " + intervalID);
			clearInterval(intervalID);
			$(".loading").remove();
		}else{
			$('.ressources').append(jQuery(data).find('.ressources').html());	
		}	
	},});
  }
}

function nearBottomOfPage() {
  return scrollDistanceFromBottom() < 150;
}

function scrollDistanceFromBottom(argument) {
  return pageHeight() - (window.pageYOffset + self.innerHeight);
}

function pageHeight() {
  return Math.max(document.body.scrollHeight, document.body.offsetHeight);
}

$('document').ready(function(){
	if($('.loading').length){
		intervalID = setInterval(checkScroll, 250);
		console.log(intervalID);
	}
})