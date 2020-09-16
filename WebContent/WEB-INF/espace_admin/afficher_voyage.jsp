<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("now", new org.joda.time.DateTime()); %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>Espace Administrateur - Voyage: ${ voyage.titre }</title>
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
                    <li><a href="<c:url value="/liste_voyages"/>">Voyages</a>
                    </li>
                    <li class="active">${ voyage.titre }</li>
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
            
                <ul class="pager">
                    <li class="previous"><a href="<c:url value="/liste_voyages" />"><i class="fa fa-chevron-circle-left" aria-hidden="true"></i> Retour</a></li>
                </ul>
	            
	            <div id="success">
		            <c:if test="${ empty form.erreurs and !empty form.resultat}">
	                    <div class="alert alert-success fade in">
	                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
	                        <strong>Les modifications ont été effectuées avec succès!</strong>
	                    </div>
	                </c:if>
                </div>
	            
                <!-- Affichage du voyage -->
                <div class="alert alert-info">
                    <strong>Titre :</strong> ${ voyage.titre }.
                </div>
                <div class="alert alert-warning">
                    <strong>Description :</strong> ${ voyage.description}.
                </div>

                <div class="col-md-6 col-md-offset-3">
	                <table class="table table-striped">
	                <thead>
	                    <tr>
	                        <th colspan=2 style="text-align:center">Récapitulatif du voyage</th>
	                    </tr>
	                </thead>
	                <tbody>
					    <tr>
							<th>Destination</th>
							<td>${ voyage.destination.nom } (${ voyage.destination.continent })</td>
					    </tr>
					    <tr>
	                        <th>Hébergement</th>
	                        <td>${ voyage.hebergement }</td>
	                    </tr>
					    <tr>
							<th>Prix</th>
							<td><fmt:formatNumber type="number" maxIntegerDigits="10"  maxFractionDigits="0" value="${ voyage.prix }" /> <font size="1" color="#808080">Dhs</font></td>
					    </tr>
					    <tr>
							<th>Départ</th>
							<td><joda:format value="${ voyage.date }" pattern="dd/MM/yyyy" ></joda:format></td>
					    </tr>
					    <tr>
                            <th>Il reste</th>
                            <td>
                                <fmt:parseNumber value="${(voyage.date.millis - now.millis) / (1000*60*60*24) }" integerOnly="true" />
                                jour${((voyage.date.millis - now.millis) / (1000*60*60*24)) < 2 ? '' : 's' }
                            </td>
                        </tr>
					    <tr>
	                        <th>Durée</th>
	                        <td>${ voyage.duree } Jours</td>
	                    </tr>
	                    <tr>
	                        <th>Difficulté</th>
	                        <td>
	                        <span title="
								<c:choose>
	                                <c:when test="${ voyage.difficulte == 1 }">Facile</c:when>
	                                <c:when test="${ voyage.difficulte == 2 }">Modéré</c:when>
									<c:when test="${ voyage.difficulte == 3 }">Sportif</c:when>
									<c:when test="${ voyage.difficulte == 4 }">Difficile</c:when>
									<c:when test="${ voyage.difficulte == 5 }">Extrême</c:when>
								</c:choose>" class="label label-primary">
								<c:forEach var="i" begin="1" end="${ voyage.difficulte }" step="1">
	                                <i class="fa fa-circle" aria-hidden="true"></i>
								</c:forEach>
								<c:forEach var="i" begin="1" end="${ 5 - voyage.difficulte }" step="1">
	                                <i class="fa fa-circle-thin" aria-hidden="true"></i>
								</c:forEach>
	                        </span>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>Alttitude</th>
	                        <td>
	                            <span title="
			                        <c:choose>
			                            <c:when test="${ voyage.altitude == 1 }">moins de 1500 mètres</c:when>
			                            <c:when test="${ voyage.altitude == 2 }">de 1500 à 2500 mètres</c:when>
			                            <c:when test="${ voyage.altitude == 3 }">de 2500 à 4000 mètres</c:when>
			                            <c:when test="${ voyage.altitude == 4 }">de 4000 à 5000 mètres</c:when>
			                            <c:when test="${ voyage.altitude == 5 }">plus de 5000 mètres</c:when>
			                        </c:choose>" class="label label-primary">
			                        <c:forEach var="i" begin="1" end="${ voyage.altitude }" step="1">
			                            <i class="fa fa-circle" aria-hidden="true"></i>
			                        </c:forEach>
			                        <c:forEach var="i" begin="1" end="${ 5 - voyage.altitude }" step="1">
			                            <i class="fa fa-circle-thin" aria-hidden="true"></i>
			                        </c:forEach>
	                            </span>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>Thème</th>
	                        <td>${ voyage.theme.nom }</td>
	                    </tr>
	                    <tr>
	                        <th>Type</th>
	                        <td>${ voyage.theme.type.nom }</td>
	                    </tr>
	                    <tr>
	                        <th>Action</th>
	                        <td>
	                        <a href="
	                            <c:url value="/modificationVoyage">
	                                <c:param name="idVoyage" value="${ voyage.id }" />
	                            </c:url>">
	                            <i class="fa fa-pencil" aria-hidden="true"></i>
                            </a>
	                        
	                        <a href="
	                        <c:url value="/suppressionVoyage">
	                            <c:param name="idVoyage" value="${ voyage.id }" />
	                        </c:url>">
	                            <i class="fa fa-trash-o" aria-hidden="true"></i>
	                        </a>
	                        </td>
	                    </tr>
					  </tbody>
					</table>
				</div>
                <!-- Affichage du voyage -->
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
    
</body>

</html>
