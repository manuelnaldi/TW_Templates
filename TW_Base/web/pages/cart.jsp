<!-- Do this on your own! -->
<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<!-- import di classi Java -->
<%@ page import="it.unibo.tw.web.beans.Catalogue"%>
<%@ page import="it.unibo.tw.web.beans.Item"%>
<%@ page import="it.unibo.tw.web.beans.Cart"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Set"%>



<!-- codice html restituito al client -->
<html>
	<head>
		<meta name="Author" content="manny18">
		<title>Cart JSP</title>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/default.css" type="text/css"/>
	</head>
	
	<body>
		
		<%@ include file="../fragments/header.jsp" %>
		<%@ include file="../fragments/menu.jsp" %>
		
		<div id="main" class="clear">
		
			<jsp:useBean id="cart" class="it.unibo.tw.web.beans.Cart" scope="session" />
			<jsp:useBean id="catalogue" class="it.unibo.tw.web.beans.Catalogue" scope="application" />
			
			<%
				String description = request.getParameter("description");
	
				if ( description != null && ! description.equals("") ) {

					if ( description.contains(" ") ) {
						throw new Exception("Blanks are not allowed in the description field!"); 					
					}
					
					if ( request.getParameter("add") != null && request.getParameter("add").equals("submit item") ) {
						Item item = new Item();
						item.setDescription( description );
						item.setPrice( Double.parseDouble( request.getParameter("price") ) );
						item.setQuantity( Integer.parseInt(request.getParameter("quantity") ) );
						cart.put(item,cart.getItemsMap().size());
					}
				}else if(request.getParameter("remove") != null && request.getParameter("remove").equals("ok")){
					cart.empty();
				}
				
			
			%>
			
			<!-- parte di SINISTRA: iterate sugli articoli nel catalogo-->
			<div id="left" style="float: left; width: 48%; border-right: 1px solid grey">
			
				<p>Catalogue:</p>
				<table class="formdata">
					<tr>
						<th style="width: 31%">Description</th>
						<th style="width: 31%">Price</th>
						<th style="width: 31%">Available quantity</th>
						<th style="width: 7%"></th>
					</tr>
					<% 
					Item[] items = catalogue.getItems().toArray(new Item[0]);
					for( Item anItem : items ){  
					%> 
						<tr>
							<td><%= anItem.getDescription() %></td>
							<td><%= anItem.getPrice() %> &#8364;</td>
							<td><%= anItem.getQuantity() %></td>
							<td>
								<a href="?add=submit item&description=<%= anItem.getDescription() %>&price=<%= anItem.getPrice() %>&quantity=<%= anItem.getQuantity()%>">
								<img src="https://www.paypalobjects.com/en_US/i/btn/btn_cart_LG.gif" alt="add"/></a>
							</td>
						</tr>
					<% } %>
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
				</table>
				
			</div> <!-- SINISTRA -->
			
			<!-- parte di DESTRA -->
			<div id="right" style="float: right; width: 48%">
			
				<p>Cart:</p>
				<table class="formdata">
					<tr>
						<th style="width: 50%">Description</th>
						<th style="width: 50%">Price</th>
						<th style="width: 7%">
							<a href="?remove=ok">
							<img src="../images/remove.gif" alt="remove"/></a>
						</th>
					</tr>
					<% 
					Item[] itemsCart = cart.getItems().toArray(new Item[0]);
					for( Item anItem : itemsCart ){  
					%> 
						<tr>
							<td><%= anItem.getDescription() %></td>
							<td><%= anItem.getPrice() %> &#8364;</td>
							<td>&nbsp;</td>
						</tr>
					<% } %>
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
				</table>
			
			</div> <!-- DESTRA -->
			
			<div class="clear">
				<p>&nbsp;</p>
			</div>
			
		</div> <!-- MAIN -->
		
		<%@ include file="../fragments/footer.jsp" %>

	</body>
</html>
