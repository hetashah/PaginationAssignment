<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pagination</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

<style>
	.changebutton{
		color: red;
	}
</style>
</head>
<body>
	
	<h2>Pagination</h2>
		
	<input type="text" id="searchText">
	<input type="button" id="searchButton" class="butt" value="Search">
	<div id="datatable">
	
	</div>
	<div id="paginationMain">
	</div>
	
</body>
<script>
$(document).ready(function(){
	
	$("#searchButton").click(function(event){
		var clickedname = $("#searchText").val();
		//alert("You Clicked on " + clickedname);
		
		if($("#pagination").length !=0){
			$("#pagination").remove();}
		
		
		$.ajax({
			url:'NewsServlet',
			type:'GET',
			dataType: 'json',
		 	data: 'statename=' + clickedname,
		 	success:function(data){
		 		
		 		paginationbuttons(data);
		 }//function(data)
		});
	});
	
	var size =10;
	var buttonno;
	function paginationbuttons(data){
		//alert(data.length);
		
		buttonno = Math.ceil((data.length)/size);
		//alert(buttonno);
		sessionStorage.setItem("News",JSON.stringify(data));
		var dataSession = JSON.parse(sessionStorage.getItem("News"));
		printRows(0,dataSession);
		insertPaginationButtons(buttonno);
		
	}
	
	function insertPaginationButtons(buttonno){
		
		
		if($("#pagination").length ==0){
			var newDiv = $(document.createElement('div'))
			.attr({"id":"pagination"});
			newDiv.appendTo("#paginationMain");
			}
		
		insertPreviousNextButton(buttonno,"Previous");
			
		for(var i=0;i<buttonno;i++){
			var newButton = $(document.createElement('input'))
			.attr({"type":"button","value":(i+1),"class":'buttonSet',"id":(i)});
			newButton.appendTo("#pagination");
			//newButtonSpan.after().html('<input type="button" name="b" class="WeatherButt" value = " '+  obj[i].cityname + '" id="'+ obj[i].cityzmw +'">');
		}
		
		insertPreviousNextButton(buttonno,"Next");
		
	}
	
	
	function insertPreviousNextButton(buttonno,txt){
		
		if(buttonno>0){
			var newButton = $(document.createElement('input'))
			.attr({"type":"button","value":txt,"class":'buttonSet',"id":txt});
			newButton.appendTo("#pagination");
		}
		
	}
	
	var Page;
	var oldPage=0;
	var changecolorPage=0;
	$(document.body).on('click','.buttonSet',function(event){
		
		
		Page=event.currentTarget.id;
		$('#' + Page).addClass("changebutton");
		$('#' + changecolorPage).removeClass("changebutton");
		
		changecolorPage=Page;
		if(Page=='Next'){
			Page = oldPage + 1;
		}
		else if(Page == 'Previous'){
			Page = oldPage -1;
		}
	
		if(Page == 'Previous')
			oldPage=0;	
		else if(Page == 'Next' )
			oldPage=buttonon -1;	
		else	
			oldPage=Page;
		
		
		
		if(Page==0){
			$('#Previous').hide();
		}
		else{
			$("#Previous").show();
		}
		
		if(Page==(buttonno-1)){
			$('#Next').hide();
		}
		else
			{
			$('#Next').show();
			}
			
		//alert(Page);
		var dataSession = JSON.parse(sessionStorage.getItem("News"));
		
		//alert(dataSession);
		if(Page>0){Page=Page*10;}
		//if(Page>0){Page=Page*10;}
		printRows(Page,dataSession);
		
		});
	
	function printRows(startvalue,dataSession){
		
		var init=parseInt(startvalue);
		var finish=parseInt(init)+9;
		
		/*if($("#tablesub").length ==0){
			var newDiv = $(document.createElement('div'))
			.attr({"id":"tablesub"});
			newDiv.appendTo("#tableMain");
			}*/
		
		$('#datatable').empty();
 		$('#datatable').append('<table></table>');
 		
 		var table = $('#datatable').children();
 		$(table).attr("border","1");
 		
 		table.append('<tr id="firstrow"><td> State </td> <td>  News Description </td> <td>  News URL </td></tr>');
		
		//delete table if it exist.
		for(var p=init;p<finish;p++){	 			
	 		table.append('<tr><td> '+dataSession[p].statename+' </td> <td> '+dataSession[p].newsdescription+' </td> <td> '+dataSession[p].newssourcelink+' </td></tr>');
			console.log(dataSession[p].newsdescription);
		}
		
	}

});


</script>
</html>