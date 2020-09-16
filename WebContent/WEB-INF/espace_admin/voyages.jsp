<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>Espace Administrateur - Liste des voyages</title>
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
                    <li class="active">Voyages</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->
        
        <hr>
        
        <div class="row">
        
            <!-- Sidebar Column -->
            <c:set var="pageAdmin" value="voyage" scope="request" />
            <c:import url="/WEB-INF/espace_admin/menu_admin.jsp" />
            
            <div class="col-md-9">
                <input class="form-control" id="myInput" type="text" placeholder="Entrer le titre pour une recherche rapide...">
            </div>
            
            <div class="col-md-9">
	            <ul class="pager">
	                <li class="previous">
	                    <a href="<c:url value="/ajouterVoyage" />">
	                        <i class="fa fa-plus-circle" aria-hidden="true"></i> Ajouter un nouveau voyage
	                    </a>
	                </li>
	            </ul>
            </div>
            
            <div class="col-md-9"  id="myDIV">

                <!-- Liste des voyages -->
                <c:forEach items="${ sessionScope.voyages }" var="mapVoyages">
                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail">
                            <div class="caption">
                                <h4>
                                    <a title="${ mapVoyages.value.titre }" href="
                                    <c:url value="/adminAfficherVoyage">
                                        <c:param name="idVoyage" value="${ mapVoyages.key }" />
                                    </c:url>
                                    ">
                                        <c:choose>
                                            <c:when test="${ mapVoyages.value.titre.length() gt 30 }">
                                                ${ mapVoyages.value.titre.substring(0,30) } ...
                                            </c:when>
                                            <c:otherwise>
                                               ${ mapVoyages.value.titre }
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </h4>
                                <c:choose>
									<c:when test="${ mapVoyages.value.description.length() gt 100 }">
										  ${ mapVoyages.value.description.substring(0,100) } ...
									</c:when>
									<c:otherwise>
								        ${ mapVoyages.value.description }
									</c:otherwise>
                                </c:choose>
                                    
                                <p>
	                                <a href="
	                                <c:url value="/adminAfficherVoyage">
	                                    <c:param name="idVoyage" value="${ mapVoyages.key }" />
	                                </c:url>
	                                ">
	                                    <i class="fa fa-eye" aria-hidden="true"></i>
	                                </a>
	                                
	                                <a href="
	                                    <c:url value="/modificationVoyage">
	                                        <c:param name="idVoyage" value="${ mapVoyages.key }" />
	                                    </c:url>">
	                                    <i class="fa fa-pencil" aria-hidden="true"></i>
                                    </a>
                                    
                                    <a href="
                                    <c:url value="/suppressionVoyage">
                                        <c:param name="idVoyage" value="${ mapVoyages.key }" />
                                    </c:url>
                                    ">
                                        <i class="fa fa-trash-o" aria-hidden="true"></i>
                                    </a>
                                </p>
                            </div>
                        </div>
                    </div>
                </c:forEach> 
                <!-- Liste des voyages -->
                
            </div>
            
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
		    $("#myDIV *").filter(function() {
		      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
		    });
		  });
		});
	</script>
    
</body>

</html>
