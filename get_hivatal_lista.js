
  function search() {
	 var query = $("#query").val();
	 var veletlen    = Math.random;
     if (query.length<3) {
	   $("#warn").html("legalább 3 karakter kell...");
	   return;
	 } else {
		$("#warn").html("");
	 }
	 $.get("get_hivatal_lista.php",
           { query: query, sid: veletlen },
           function(valasz) { $("#capt").html(valasz); }
      );
  }
	
   $(document).ready( function() {
      $("#query").keyup(search);
   });

   
