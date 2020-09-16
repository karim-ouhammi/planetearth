<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>Espace Administrateur - Liste des utilisateurs</title>
</head>

<body>
    <!-- Menu -->
    <c:remove var="page"/>
    <c:import url="/inc/menu.jsp" />

    <div class="container">
    
        <!-- Page Heading/Breadcrumbs -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">${ sessionUtilisateur.nom } ${ sessionUtilisateur.prenom }
                    <small>Espace Administrateur</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="<c:url value="/index.jsp" />">Accueil</a>
                    </li>
                    <li><a href="<c:url value="/espace_administrateur"/>">Espace administrateur</a>
                    </li>
                    <li class="active">Utilisateurs</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->

        <hr>
        
        <div class="row">
            <!-- Sidebar Column -->
            <c:set var="pageAdmin" value="utilisateur" scope="request" />
            <c:import url="/WEB-INF/espace_admin/menu_admin.jsp" />
            
            <!-- Content Column -->
            <div class="col-md-9">
            
                <!-- Recherche rapide -->
                <input class="form-control" id="myInput" type="text" placeholder="Recherche rapide...">
             
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Email</th>
                            <th scope="col">Nom</th>
                            <th scope="col">Prénom</th>
                            <th scope="col">Age</th>
                            <th scope="col">Téléphone</th>
                            <th scope="col">Date d'inscription</th>
                            <th scope="col">Panier</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody id="myTable">
                        <c:forEach items="${ sessionScope.utilisateurs }" var="mapUsers" varStatus="status">
                            <tr ${ mapUsers.value.isAdmin() ? 'class="warning"' : '' } >
                                <th scope="row"><span class="${ mapUsers.value.isAdmin() ? 'info' : '' }">${ status.index + 1 }</span></th>
                                <td><span class="${ mapUsers.value.isAdmin() ? 'info' : '' }"><c:out value="${ mapUsers.value.email }"/></span></td>
                                <td><c:out value="${ mapUsers.value.nom }"/></td>
                                <td><c:out value="${ mapUsers.value.prenom }"/></td>
                                <td><c:out value="${ mapUsers.value.age }"/></td>
                                <td><c:out value="${ mapUsers.value.telephone }"/></td>
                                <td><joda:format value="${  mapUsers.value.dateInscription }" pattern="dd/MM/yyyy 'à' HH'h'mm" ></joda:format></td>
                                <td>
                                    <a href="
                                            <c:url value="/visiterPanier">
                                                <c:param name="idPanier" value="${ mapUsers.value.idPanier }" />
                                                <c:param name="email" value="${ mapUsers.value.email }" />
                                            </c:url>">
                                            <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                    </a>
                                </td>
                                <td>
                                    <c:if test="${ !mapUsers.value.isAdmin() }">
                                        <a href="
                                            <c:url value="/suppressionUtilisateur">
                                                <c:param name="email" value="${ mapUsers.key }" />
                                            </c:url>">
                                            <i class="fa fa-trash-o" aria-hidden="true"></i>
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
            </div> 
            <!-- /.Content Column -->  
            
        </div>
        <!-- /.row -->

        <hr>

        <!-- Footer -->
        <c:import url="/inc/footer.jsp" />

    </div>
    <!-- /.container -->

    <!-- jQuery & Bootstrap Core JavaScript & Script to Activate the Carousel -->
    <c:import url="/inc/scripts.jsp" />
    
    <!-- Script pour la recherche rapide dans la table -->
    <script>
		$(document).ready(function(){
		  $("#myInput").on("keyup", function() {
		    var value = $(this).val().toLowerCase();
		    $("#myTable tr").filter(function() {
		      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
		    });
		  });
		});
	</script>
    
</body>

</html>
