<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("now", new org.joda.time.DateTime()); %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>${ requestScope.voyage.titre }</title>
    
    <!-- Style pour range slider -->
    <style>
    .slidecontainer {
      width: 100%;
    }
    
    .slider {
      -webkit-appearance: none;
      width: 100%;
      height: 8px;
      border-radius: 5px;
      background: #d3d3d3;
      outline: none;
      opacity: 0.7;
      -webkit-transition: .2s;
      transition: opacity .2s;
    }
    
    .slider:hover {
      opacity: 1;
    }
    
    .slider::-webkit-slider-thumb {
      -webkit-appearance: none;
      appearance: none;
      width: 20px;
      height: 20px;
      border-radius: 50%;
      background: #3E78D0;
      cursor: pointer;
    }
    
    .slider::-moz-range-thumb {
      width: 25px;
      height: 25px;
      border-radius: 50%;
      background: #4CAF50;
      cursor: pointer;
    }
    </style>
    
</head>

<body>
    <!-- Menu -->
    <c:set var="page" value="voyages" scope="session" />
    <c:import url="/inc/menu.jsp" />

    <div class="container">
    
        <!-- Page Heading/Breadcrumbs -->
        
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">${ requestScope.voyage.titre }
                    <small></small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="<c:url value="/index.jsp" />">Accueil</a>
                    </li>
                    <li><a href="<c:url value="/voyages.jsp"/>">Voyages</a>
                    </li>
                    <li class="active">
                        ${ requestScope.voyage.titre }
                    </li>
                </ol>
            </div>
        </div>
        <!-- /.row -->
        
        <!-- Affichage du voyages -->
        <div class="row">
        
            <div class="col-md-8">
                <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                    <!-- Indicators -->
                    <ol class="carousel-indicators">
                        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                        <li data-target="#carousel-example-generic" data-slide-to="1" class=""></li>
                        <li data-target="#carousel-example-generic" data-slide-to="2" class=""></li>
                    </ol>
        
                    <!-- Wrapper for slides -->
                    <div class="carousel-inner">
                        <div class="item active">
                            <img class="img-responsive" src="<c:url value="/inc/images/${ voyage.id }_image1" />" alt="${ voyage.titre }">
                        </div>
                        <div class="item">
                            <img class="img-responsive" src="<c:url value="/inc/images/${ voyage.id }_image2" />" alt="${ voyage.titre }">
                        </div>
                        <div class="item">
                            <img class="img-responsive" src="<c:url value="/inc/images/${ voyage.id }_image3" />" alt="${ voyage.titre }">
                        </div>
                    </div>
        
                    <!-- Controls -->
                    <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left"></span>
                    </a>
                    <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right"></span>
                    </a>
                </div>
                
                <div>
                    </br>
                    <p>&emsp;&emsp;${ voyage.description }</p>
                </div>
            </div>
        
            <div class="col-md-4">
                <div class="caption">
                    
                    <ul class="list-group">
						<li class="list-group-item list-group-item-info">Information</li>
					</ul>
                    
					<ul class="list-group">
					    <li class="list-group-item">À partir de<span class="pull-right"><strong><fmt:formatNumber type="number" maxIntegerDigits="10"  maxFractionDigits="0" value="${ voyage.prix }" /> <font size="1" color="#808080">Dhs</font></strong></span></li>
					    <li class="list-group-item">Prochain départ<span class="badge"><joda:format value="${ voyage.date }" pattern="dd/MM/yyyy" ></joda:format></span></li>
                        <li class="list-group-item">Il reste
                            <span class="pull-right">
                                <fmt:parseNumber value="${(voyage.date.millis - now.millis) / (1000*60*60*24) }" integerOnly="true" />
                                jour${((voyage.date.millis - now.millis) / (1000*60*60*24)) < 2 ? '' : 's' }
                            </span>
                        </li>
					</ul>
					
					<ul class="list-group">
	                    <li class="list-group-item">Durée<span class="pull-right">${ voyage.duree } Jours</span></li>
	                    <li class="list-group-item">Difficulté
	                       <span class="pull-right">
	                           <span title="
                                    <c:choose>
                                        <c:when test="${ voyage.difficulte == 1 }">Facile</c:when>
                                        <c:when test="${ voyage.difficulte == 2 }">Modéré</c:when>
                                        <c:when test="${ voyage.difficulte == 3 }">Sportif</c:when>
                                        <c:when test="${ voyage.difficulte == 4 }">Difficile</c:when>
                                        <c:when test="${ voyage.difficulte == 5 }">Extrême</c:when>
                                    </c:choose>
                                " class="label label-warning">
				                    <c:forEach var="i" begin="1" end="${ voyage.difficulte }" step="1">
			                            <i class="fa fa-circle" aria-hidden="true"></i>
				                    </c:forEach>
				                    <c:forEach var="i" begin="1" end="${ 5 - voyage.difficulte }" step="1">
			                            <i class="fa fa-circle-thin" aria-hidden="true"></i>
			                        </c:forEach>
                                </span>
                            </span>
	                    </li>
	                    <li class="list-group-item">Altitude
                            <span class="pull-right">
                                <span title="
                                    <c:choose>
                                        <c:when test="${ voyage.altitude == 1 }">moins de 1500 mètres</c:when>
                                        <c:when test="${ voyage.altitude == 2 }">de 1500 à 2500 mètres</c:when>
                                        <c:when test="${ voyage.altitude == 3 }">de 2500 à 4000 mètres</c:when>
                                        <c:when test="${ voyage.altitude == 4 }">de 4000 à 5000 mètres</c:when>
                                        <c:when test="${ voyage.altitude == 5 }">plus de 5000 mètres</c:when>
                                    </c:choose>
                                " class="label label-warning">
                                    <c:forEach var="i" begin="1" end="${ voyage.altitude }" step="1">
		                                <i class="fa fa-circle" aria-hidden="true"></i>
		                            </c:forEach>
		                            <c:forEach var="i" begin="1" end="${ 5 - voyage.altitude }" step="1">
		                                <i class="fa fa-circle-thin" aria-hidden="true"></i>
		                            </c:forEach>
                                </span>
                            </span>
	                    </li>
	                </ul>
	                
	                <ul class="list-group">
                        <li class="list-group-item">
                            <p>Hébergement : </p>
                            <p>${ voyage.hebergement }</p>
                        </li>
                    </ul>
	                
	                <ul class="list-group">
	                    <li class="list-group-item">
                            <span class="label label-primary" title="${ voyage.theme.description }">${ voyage.theme.nom }</span>
                            <span class="label label-primary" title="${ voyage.theme.type.description }">${ voyage.theme.type.nom }</span>
                        </li>
	                </ul>

                    <c:choose>
                        <c:when test="${ empty sessionScope.sessionUtilisateur }">
                            <div class="alert alert-warning fade in">
                                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                Vous devez vous <a href="<c:url value="/connexion"><c:param name="idVoyage" value="${ voyage.id }" /></c:url>" class="alert-link">connecter</a> ou vous <a href="<c:url value="/inscription"/>" class="alert-link">inscrire</a>! Pour participer à ce voyage.
                            </div>
                        </c:when>
                        
                        <c:when test="${ !empty sessionScope.sessionUtilisateur }">
                            <c:forEach items="${ sessionScope.voyagePaniers }" var="mapVoyagePaniers">
                                <c:if test="${ mapVoyagePaniers.key eq voyage.id }">
                                    <c:set var="existe" value="true" scope="page"/>
                                </c:if>
                            </c:forEach>
                            
                            <c:if test="${ empty pageScope.existe }">
                                <ul class="list-group">
                                    <li class="list-group-item">
		                               <form method="post" action="<c:url value="/panierAjouterVoyage"/>">
											<!-- hidden id field -->
											<input type="hidden" class="form-control" id="idVoyage" name="idVoyage" value="<c:out value="${ voyage.id }"/>">
											<!-- /.hidden id field -->
											
											<div class="slidecontainer">
											    <div class="control-group form-group">
											        <div class="controls">
											            <label for="nbPersonne">Nombre de voyageurs</label>
											            <input type="range" class="slider" min="1" max="10" step="1" id="nbPersonne" name ="nbPersonne"
											            value="${ empty panier.nbPersonne ? '1' : panier.nbPersonne }" oninput="nbPersonneOutPut.value = nbPersonne.value">
											            <p style="text-align:center"><output name="nbPersonneOutPut" id="nbPersonneOutPut">
											                ${ empty panier.nbPersonne ? '1' : panier.nbPersonne }
											            </output></p>
											            <p class="help-block">${ form.erreurs['nbPersonne'] }</p>
											        </div>
											    </div>
											</div>
											
											<p style="text-align:center"><button type="submit" class="btn btn-danger">S'INSCRIRE</button></p>
		                                </form>
                                    </li>
                                </ul>
                            </c:if>
                      
                            <c:if test="${ !empty pageScope.existe }">
                                <div class="alert alert-success fade in">
                                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                    <strong>Vous êtes inscrit dans ce voyage!</strong> Visitez votre panier pour <a href="<c:url value="/panierAfficherVoyage"><c:param name="idVoyage" value="${ voyage.id }" /></c:url>" class="alert-link">plus d'informations</a>.
                                </div>
                                <c:remove var="existe"/>
                            </c:if>
                            
                        </c:when>
                    </c:choose>

                </div>
            </div>
            
            <hr>
        
        </div>
        <!-- /.Affichage du voyages -->
        
        <hr>

        <!-- Footer -->
        <c:import url="/inc/footer.jsp" />

    </div>
    <!-- /.container -->

    <!-- jQuery & Bootstrap Core JavaScript & Script to Activate the Carousel -->
    <c:import url="/inc/scripts.jsp" />
    
</body>

</html>
