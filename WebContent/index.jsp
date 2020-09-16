<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>planetearth - découvrez votre planète</title>
    
    <style>
		#myBtn {
		  display: none;
		  position: fixed;
		  bottom: 20px;
		  right: 30px;
		  z-index: 99;
		  border: none;
		  outline: none;
		  cursor: pointer;
	    }
    </style>    
</head>

<body>
    <!-- Menu -->
    <c:set var="page" value="accueil" scope="session" />
    <c:import url="/inc/menu.jsp" />
    
    <!-- Scroll button -->
    <c:import url="/inc/scroll_button.jsp" />

    <!-- Header Carousel -->
    <header id="myCarousel" class="carousel slide">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <c:forEach items="${ sessionScope.titres }" var="mapTitres" varStatus="status">
                <li data-target="#myCarousel" data-slide-to="${ status.index }" ${ status.count eq 1 ? 'class="active"' : '' }></li>
            </c:forEach>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner">
            <c:forEach items="${ sessionScope.titres }" var="mapTitres" varStatus="status">
                <div class="${ status.count eq 1 ? 'item active' : 'item' }">
                    <div class="fill" style="background-image:url('<c:url value='/inc/images/titres/${ mapTitres.value.id }_image'/>');"></div>
                    <div class="carousel-caption">
                        <h2>${ mapTitres.value.titre }</h2>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="icon-prev"></span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="icon-next"></span>
        </a>
    </header>

    <!-- Page Content -->
    <div class="container">

<!-- Marketing Icons Section -->
        
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">
                    <CENTER>
                        <i class="fa fa-quote-left fa-lg fa-pull-left" aria-hidden="true"></i>
                         Après votre visite, vous n'aurez 
                        <i class="fa fa-quote-right fa-lg fa-pull-right" aria-hidden="true"></i>
                        </br> qu'une seule envie c’est d’y</br> retourner !
                        
                    </CENTER>
                </h1>
            </div>
            <div class="col-lg-12">
                    <div class="panel-body">
                        <p>Sortir des sentiers battus est le meilleur moyen de vivre un moment magique et unique.
​Destinations confidentielles, certaines connues, d’autres “parfaitement” secrètes sélectionnées et approuvées par nos soins, qui méritent d’être découvertes, nous vous confions tous nos secrets… Parmi elles, des lieux cachés, des excursions exotiques, des paysages inoubliables.</br>Quelle destination vous tente le plus?</p>
                        <span class="pull-right"><a href="<c:url value="/voyages.jsp"/>" class="btn btn-default">Découvrez nos destinations</a></span>
                    </div>
            </div>
        </div>

        <!-- Marketing Icons Section -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">
                    Ce qui va vous plaire chez nous
                </h1>
            </div>
            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4><i class="fa fa-fw fa-compass"></i>Plusieurs destinations</h4>
                    </div>
                    <div class="panel-body">
                        <p>Un choix de destinations variées à prix promo pour découvrir votre planète.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4><i class="fa fa-fw fa-gift"></i>Meilleur prix garanti</h4>
                    </div>
                    <div class="panel-body">
                        <p>Des promotions durant toute l'année. Jusqu'à 30% de réduction (1% pour chaque voyage).</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4><i class="fa fa-fw fa-check"></i> Facile à utiliser</h4>
                    </div>
                    <div class="panel-body">
                        <p>Avec notre ergonomique platforme et l'équipe de support (24/7) vous n'aurez aucun problème.</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.row -->


        <div class="row products">

            <div class="col-lg-12">
                <h2 class="page-header">Nouveaux voyages récemment ajoutés</h2>
            </div>

            <c:forEach items="${ sessionScope.voyages }" var="mapVoyages" varStatus="boucle">
                <c:if test="${ boucle.count le 6 }" >
                <div class="col-sm-4 col-lg-4 col-md-4">
                    <div class="thumbnail">
                    
                        <a href="
                        <c:url value="/afficherVoyage">
                            <c:param name="idVoyage" value="${ mapVoyages.key }" />
                        </c:url>
                        ">
                           <img class="img-responsive img-hover" src="<c:url value="/inc/images/${ mapVoyages.value.id }_imageListe" />" alt="${ mapVoyages.value.titre }" width="320" height="150">
                        </a>
                        
                        <div class="caption">
                            <strong class="pull-right">
                                <fmt:formatNumber type="number" maxIntegerDigits="10"  minFractionDigits="0" value="${ mapVoyages.value.prix }" />
                                <font size="1" color="#808080"> Dhs</font>
                            </strong></br>
                            <h4>
                                <a href="
                                <c:url value="/afficherVoyage">
                                    <c:param name="idVoyage" value="${ mapVoyages.key }" />
                                </c:url>
                                ">
                                    <c:choose>
                                        <c:when test="${ mapVoyages.value.titre.length() gt 40 }">
                                            ${ mapVoyages.value.titre.substring(0,40) } ...
                                        </c:when>
                                        <c:otherwise>
                                           ${ mapVoyages.value.titre }
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            </h4>
                            
                            <p>
                                <c:choose>
                                    <c:when test="${ mapVoyages.value.description.length() gt 100 }">
                                        ${ mapVoyages.value.description.substring(0,100) } ...
                                    </c:when>
                                    <c:otherwise>
                                        ${ mapVoyages.value.description }
                                    </c:otherwise>
                                </c:choose>
                                
                                <span class="pull-right">
                                    <span class="label label-danger">Nouveauté</span>
                                    <a class="btn btn-default btn-xs" href="
                                        <c:url value="/afficherVoyage">
                                            <c:param name="idVoyage" value="${ mapVoyages.key }" />
                                        </c:url>">
                                        plus d'informations
                                    </a>
                                </span>
                            </p>
                        </div>
                    </div>
                </div>
                </c:if>
            </c:forEach>

        </div>  
        
        <!-- Plus de voyages -->
        <div class="well">
            <div class="row">
                <div class="col-md-8">
                    <p>Vous avez aimé nos voyages? Vous pouvez consulter la liste complète.</p>
                </div>
                <div class="col-md-4">
                    <a class="btn btn-lg btn-primary btn-block" href="<c:url value ="/voyages.jsp"/>">Liste des voyages</a>
                </div>
            </div>
        </div>
        
        <hr>
        
        <!-- Contact -->
        <div class="well">
            <div class="row">
                <div class="col-md-8">
                    <p>Pour plus d'informations et détails, n'hésitez pas à nous contacter.</p>
                </div>
                <div class="col-md-4">
                    <a class="btn btn-lg btn-primary btn-block" href="<c:url value ="/contact"/>">Contact</a>
                </div>
            </div>
        </div>

        <hr>

        <!-- Footer -->
        <c:import url="/inc/footer.jsp" />

    </div>
    <!-- /.container -->

    <!-- jQuery & Bootstrap Core JavaScript & Script to Activate the Carousel -->
    <c:import url="/inc/scripts.jsp" />
    
</body>

</html>
