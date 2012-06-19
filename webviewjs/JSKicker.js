/**
 * @author nomura_takahisa
 */
var JSKicker = function(){};

var bodyTag = document.getElementsByTagName("body");
var new_area = document.createElement("a");
new_area.setAttribute("id", "JSKicker");
bodyTag[0].appendChild(new_area);
var JSKickerLinkElem = document.getElementById('JSKicker'); 

var clickTrriger = function(elem){
	var clickEvent = document.createEvent('MouseEvent');
	clickEvent.initEvent('click', false, true);
	elem.dispatchEvent(clickEvent);
}

//----以下にネイティブに送りたいメソッドを追加していく-----//

JSKicker.shot = function(x,y){
	JSKickerLinkElem.setAttribute("href", "method://JSKicker/shot?x=" + x + "&y=" + y);	
	clickTrriger(JSKickerLinkElem);
};


