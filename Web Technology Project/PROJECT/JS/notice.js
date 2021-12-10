var hasError=false;
		function get(id){
			return document.getElementById(id);
		}
		
		function validate(){
			refresh();
			if(get("Notice").value == ""){
				hasError = true;
				get("err_Notice").innerHTML = "*Notice Req";
			}
	
			
			return !hasError;
		}
		function refresh(){
			hasError = false;
			get("err_Notice").innerHTML ="";
			
		}