<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("now", new org.joda.time.DateTime()); %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>Panier - ${ sessionUtilisateur.nom } ${ sessionUtilisateur.prenom }</title>
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
                    <small>Mon panier</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="<c:url value="/index.jsp" />">Accueil</a>
                    </li>
                    <li><a href="<c:url value="/panier" />">Mon panier</a>
                    </li>
                    <li class="active">${ sessionUtilisateur.nom } ${ sessionUtilisateur.prenom }</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->
        
        <div class="row">
	        <div class="col-md-12">
	        
                <c:choose>
                    <c:when test="${ empty sessionScope.voyagePaniers }">
                        <div class="alert alert-info fade in">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                            <strong>Votre panier est vide pour le moment!</strong> rendez-vous sur la <a href="<c:url value="/voyages.jsp"/>" class="alert-link">page des voyages</a> pour vous inscrire dans nos prochaines destinations
                        </div>
                    </c:when>
                    <c:otherwise>
                         <div class="alert alert-info fade in">
		                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		                    <strong>Cliquez sur le titre du voyage pour plus d'informations.</strong>
		                </div>
                    </c:otherwise>
                </c:choose>
                
                <c:if test="${ !empty echec }">
	                <div class="alert alert-danger fade in">
	                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
	                    <strong>${ echec }</strong>
	                </div>
                </c:if>
                
                <c:if test="${ !empty succes }">
                    <div class="alert alert-success fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <strong>${ succes }</strong>
                    </div>
                </c:if>
	        
                <input class="form-control" id="myInput" type="text" placeholder="Recherche rapide...">
	           
                <table class="table table-striped">
                    <thead>
						<tr>
						    <th>Voyages</th>
						    <th>N<sup>bre</sup> de voyageurs</th>
						    <th>Prix <font size="1" color="#808080"> / voyageur</font></th>
						    <th>Assurances <font size="1" color="#808080">(2%)</font></th>
						    <th>Taxes <font size="1" color="#808080">(1%)</font></th>
						    <th>Frais d'inscription <font size="1" color="#808080">(0.05%)</font></th>
						    <th>Montant <font size="1" color="#808080"> / voyage (Dhs)</font></th>
						    <th></th>
						</tr>
                    </thead>
                    <tbody id="myTable">
	                    <c:forEach items="${ sessionScope.voyagePaniers }" var="mapVoyagePaniers">
	                        <tr>
	                            <td>
                                    <a href="
			                        <c:url value="/panierAfficherVoyage">
			                            <c:param name="idVoyage" value="${ mapVoyagePaniers.key }" />
			                        </c:url>
			                        ">
                                        ${ mapVoyagePaniers.value.voyage.titre }
                                    </a>
                                    
                                    <font size="1" color="#808080">(Il reste
                                        <fmt:parseNumber value="${(mapVoyagePaniers.value.voyage.date.millis - now.millis) / (1000*60*60*24) }" integerOnly="true" />
                                        jour${((mapVoyagePaniers.value.voyage.date.millis - now.millis) / (1000*60*60*24)) < 2 ? '' : 's' })
                                    </font>  
                                    
                                </td>
                                <td>
                                    ${ mapVoyagePaniers.value.nbPersonne }
                                </td>
	                            <td>
                                    <fmt:formatNumber type="number" maxIntegerDigits="10"  maxFractionDigits="0" value="${ mapVoyagePaniers.value.voyage.prix }" />
                                    <font size="1" color="#808080">Dhs</font>
	                            </td>
	                            <td>
                                    <fmt:formatNumber type="number" maxIntegerDigits="10"  maxFractionDigits="0" value="${ mapVoyagePaniers.value.voyage.prix * mapVoyagePaniers.value.nbPersonne * 0.02 }" />
                                    <font size="1" color="#808080">Dhs</font>
	                            </td>
	                            <td>
                                    <fmt:formatNumber type="number" maxIntegerDigits="10"  maxFractionDigits="0" value="${ mapVoyagePaniers.value.voyage.prix * mapVoyagePaniers.value.nbPersonne * 0.01 }" />
                                    <font size="1" color="#808080">Dhs</font>
	                            </td>
	                            <td>
                                    <fmt:formatNumber type="number" maxIntegerDigits="10"  maxFractionDigits="0" value="${ mapVoyagePaniers.value.voyage.prix * mapVoyagePaniers.value.nbPersonne * 0.005}" />
                                    <font size="1" color="#808080">Dhs</font>
	                            </td>
	                            <td>
                                    <fmt:formatNumber type="number" maxIntegerDigits="10"  maxFractionDigits="0" value="${ mapVoyagePaniers.value.voyage.prix * mapVoyagePaniers.value.nbPersonne * (1 + 0.02 + 0.01 + 0.005) }" />
                                    <font size="1" color="#808080">Dhs</font>
                                </td>
                                <td>
                                    <a href="
										<c:url value="/panierSuppressionVoyage">
										    <c:param name="idVoyage" value="${ mapVoyagePaniers.key }" />
										</c:url>">
										<i class="fa fa-trash-o" aria-hidden="true"></i>
                                    </a>
                                </td>
	                        </tr>
	                    </c:forEach>
	                    <tr>
	                        <th colspan="6">
	                           Montant total avec réduction de ${ nbVoyages }% 
	                           <font size="1" color="#808080"> 
	                               (-<fmt:formatNumber type="number" maxIntegerDigits="10"  maxFractionDigits="0" value="${ total - montantAPayer }" />
	                               Dhs)
	                           </font></th>
	                        <td>
                                <strong>
                                    <fmt:formatNumber type="number" maxIntegerDigits="10"  maxFractionDigits="0" value="${ montantAPayer }" />
                                </strong>
                                <font size="1" color="#808080">Dhs</font>
	                        </td>
	                    </tr>
                    </tbody>
                </table>
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
            $("#myTable tr").filter(function() {
              $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
          });
        });
    </script>
    
</body>

</html>
