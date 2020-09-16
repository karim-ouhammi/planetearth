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
                    <li class="active">${ voyage.titre }</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->
        
        <div class="row">
            <div class="col-md-12">
                
                <div class="col-md-12">
                    <ul class="pager">
                        <li class="previous">
                            <a href="
                                <c:url value="/panier"/>">
                                <i class="fa fa-chevron-circle-left" aria-hidden="true"></i> Retour
                            </a>
                        </li>
                    </ul>
                </div>
                
                <!-- Récapitulatif du voyage -->
                <div class="col-md-8">
                
                    <div class="col-md-12">
                        <div class="alert alert-info">
                            <strong>Titre :</strong> ${ voyage.titre }
                        </div>
                        <div class="alert alert-warning">
                            <strong>Description :</strong> ${ voyage.description}
                        </div>
                    </div>
                    
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
                                <td>${ voyage.prix } Dhs</td>
                            </tr>
                            <tr>
                                <th>Départ</th>
                                <td>
                                    <joda:format value="${ voyage.date }" pattern="dd/MM/yyyy" ></joda:format>
                                    <font size="1" color="#808080">Il reste
                                        <fmt:parseNumber value="${(voyage.date.millis - now.millis) / (1000*60*60*24) }" integerOnly="true" />
                                        jour${((voyage.date.millis - now.millis) / (1000*60*60*24)) < 2 ? '' : 's' }
                                    </font>  
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
                        </tbody>
                    </table>

                </div>
                <!-- /.Récapitulatif du voyage -->
                
                <!-- Montant du voyage -->
                <div class="col-md-4">

                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th colspan=2 style="text-align:center">Montant du voyage</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th>Nombre de voyageurs</th>
                                <td>${ voyagePanier.nbPersonne }</td>
                            </tr>
                            <tr>
                                <th>Prix <font size="1" color="#808080">/ voyageur</font></th>
                                <td>
                                    <fmt:formatNumber type="number" maxIntegerDigits="10"  minFractionDigits="0" value="${ voyage.prix } " />
                                    <font size="1" color="#808080">Dhs</font>
                                </td>
                            </tr>
                            <tr>
                                <th>Prix <font size="1" color="#808080">x ${ voyagePanier.nbPersonne } voyageur${ voyagePanier.nbPersonne eq 1 ? '' : 's' }</font></th>
                                <td>
                                    <fmt:formatNumber type="number" maxIntegerDigits="10"  minFractionDigits="0" value="${ voyage.prix * voyagePanier.nbPersonne } " />
                                    <font size="1" color="#808080">Dhs</font>
                                </td>
                            </tr>
                            <tr>
                                <th>${ voyagePanier.nbPersonne } Assurance${ voyagePanier.nbPersonne eq 1 ? '' : 's' } <font size="1" color="#808080">(2%)</font></th>
                                <td>
                                    <fmt:formatNumber type="number" maxIntegerDigits="10"  minFractionDigits="0" value="${ voyage.prix * voyagePanier.nbPersonne * 0.02 }" />
                                    <font size="1" color="#808080">Dhs</font>
                                </td>
                            </tr>
                            <tr>
                                <th>${ voyagePanier.nbPersonne } Taxe${ voyagePanier.nbPersonne eq 1 ? '' : 's' } <font size="1" color="#808080">(1%)</font></th>
                                <td>
                                    <fmt:formatNumber type="number" maxIntegerDigits="10"  minFractionDigits="0" value="${ voyage.prix * voyagePanier.nbPersonne * 0.01 }" />
                                    <font size="1" color="#808080">Dhs</font>
                                </td>
                            </tr>
                            <tr>
                                <th>${ voyagePanier.nbPersonne } Frais d'inscription <font size="1" color="#808080">(0.05%)</font></th>
                                <td>
                                    <fmt:formatNumber type="number" maxIntegerDigits="10"  minFractionDigits="0" value="${ voyage.prix * voyagePanier.nbPersonne * 0.005}" />
                                    <font size="1" color="#808080">Dhs</font>
                                </td>
                            </tr>
                            <tr>
                                <th>Montant total</th>
                                <td>
                                    <fmt:formatNumber type="number" maxIntegerDigits="10"  minFractionDigits="0" value="${ voyage.prix * voyagePanier.nbPersonne * (1 + 0.02 + 0.01 + 0.005) }" />
                                    <font size="1" color="#808080">Dhs</font>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                </div>
                <!-- /.Montant du voyage -->
               
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
