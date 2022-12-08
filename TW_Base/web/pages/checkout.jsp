<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<!-- import di classi Java -->
<%@ page import="it.unibo.tw.web.beans.Catalogue"%>
<%@ page import="it.unibo.tw.web.beans.Item"%>

<!-- metodi richiamati nel seguito -->
<%!

void decrementa(Catalogue catalogue, String description,int quantity) {
	
	for ( int i = 0 ; i < catalogue.getItems().size() ; i++ ) {
		if ( catalogue.getItems().get(i).getDescription().equals(description) ) {
			catalogue.getItems().get(i).setQuantity(catalogue.getItems().get(i).getQuantity()-quantity);
			break;
		}
	}

}
%>


<html>
	<head>
		<meta name="Author" content="manny18">
		<title>Checkout JSP</title>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/default.css" type="text/css"/>
	</head>

	<body>	

		<%@ include file="../fragments/header.jsp" %>
		<%@ include file="../fragments/menu.jsp" %>
	
		<div id="main" class="clear">
			
			<jsp:useBean id="cart" class="it.unibo.tw.web.beans.Cart" scope="session" />
			<jsp:useBean id="catalogue" class="it.unibo.tw.web.beans.Catalogue" scope="application" />
			
			<% 
				if(request.getParameter("checkout")!=null && request.getParameter("checkout").equals("checkout")){
					Item[] itemsCheck = cart.getItems().toArray(new Item[0]);
					for(Item i:itemsCheck){
						String descr=i.getDescription();
						int quantity=Integer.parseInt(request.getParameter("quantity"));
						String output=descr+" "+quantity;
						decrementa(catalogue,descr,quantity);
					}
					cart.empty();
				}
			%>
			
			<p>Checkout:</p>
				<form>
					<table class="formdata">
						<tr>
							<th style="width: 30%">Description</th>
							<th style="width: 30%">Price</th>
							<th style="width: 30%">Available quantity</th>
							<th style="width: 10%">Select quantity</th>
						</tr>
						<% 
						Item[] items = cart.getItems().toArray(new Item[0]);
						for( Item anItem : items ){  
						%> 
							<tr>
								<td><%= anItem.getDescription() %></td>
								<td><%= anItem.getPrice() %> &#8364;</td>
								<td><%= anItem.getQuantity() %></td>
								<td><input type="number" name="quantity" min="1" max=<%= anItem.getQuantity() %>></td>
							</tr>
						<% } %>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
					</table>
					<input type="submit" name="checkout" value="checkout" style="width:100%" />
				</form>
			
		</div>
	
		<%@ include file="../fragments/footer.jsp" %>

	</body>
</html>
