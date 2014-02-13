function Searcher(postURL, inputID, outputID){
	this.hasResult = false;
	this.output = document.getElementById(outputID);
	var inputForm = document.getElementById(inputID);
	var obj = this;
	this.xhr = new XMLHttpRequest();

	inputForm.onkeyup = function(event){
		obj.xhr.onreadystatechange = function(){
			obj.xhrHandler();
		}
		obj.xhr.open("GET", postURL+"?search="+encodeURIComponent(document.getElementById(inputID).value));
		obj.xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		obj.xhr.send();
	}
}

Searcher.prototype.xhrHandler = function(){
	if (this.xhr.readyState != 4) {
		return;
	}

	if (this.xhr.status != 200) {    
      	console.log("error searching photos");
  	}
  	var searchText = this.xhr.responseText;
  	if(this.hasResult) this.output.removeChild(this.output.lastChild);
  	var photoElement = document.createElement("div");
  	// photoElement.className = "row";
  	photoElement.innerHTML = searchText;
  	this.output.appendChild(photoElement);
  	this.hasResult = true;
}