<div id="menu">
	<ul id="tabs">
		<li <%= request.getRequestURI().contains("home") ? "style=\"background-color: #aaa;\"" : ""%>>
			<a href="<%= request.getContextPath() %>/pages/home.jsp">Home</a>
		</li>
	</ul>
</div>