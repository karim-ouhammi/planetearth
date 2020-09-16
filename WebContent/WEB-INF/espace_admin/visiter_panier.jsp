<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("now", new org.joda.time.DateTime()); %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>Panier de ${ requestScope.user.nom } ${ requestScope.user.prenom }</title>
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
                    <li><a href="<c:url value="/liste_utilisateurs" />">Utilisateurs</a>
                    </li>
                    <li class="active">
                        Panier de ${ requestScope.user.nom } ${ requestScope.user.prenom }
                    </li>
                </ol>
            </div>
        </div>
        <!-- /.row -->
        
        <div class="row">
            <div class="col-md-12">
                <ul class="pager">
                    <li class="previous"><a href="<c:url value="/liste_utilisateurs" />"><i class="fa fa-chevron-circle-left" aria-hidden="true"></i> Retour</a></li>
                </ul>
        
                <c:if test="${ empty requestScope.voyagePaniers }">
                    <div class="alert alert-info fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <strong>${ requestScope.user.nom } ${ requestScope.user.prenom } n'est pas inscrit dans aucun voyage!</strong>
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
                        </tr>
                    </thead>
                    <tbody id="myTable">
                        <c:forEach items="${ requestScope.voyagePaniers }" var="mapVoyagePaniers">
                            <tr>
                                <td>
                                    ${ mapVoyagePaniers.value.voyage.titre }
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
