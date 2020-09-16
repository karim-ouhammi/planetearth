<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>planetearth - Erreur 404 (Page non trouvée)</title>
</head>

<body>
    <!-- Menu -->
    <c:import url="/inc/menu.jsp" />

    <div class="container">
    
        <!-- Page Heading/Breadcrumbs -->
        
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">404
                    <small>Page non trouvée</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="<c:url value="/index.jsp" />">Accueil</a>
                    </li>
                    <li class="active">404</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->
        
        <div class="row">
            <div class="col-lg-12">
                <div class="jumbotron">
                    <h1><span class="error-404">404</span>
                    </h1>
                    <p>La page que vous recherchez est introuvable. Voici quelques liens utiles pour vous remettre sur la bonne voie:</p>
                    <ul>
                        <li>
                            <a href="<c:url value="/index.jsp" />"><i class="fa fa-home" aria-hidden="true"></i> Accueil</a>
                        </li>
                        <li>
                            <a href="<c:url value="/voyages.jsp" />"><i class="fa fa-plane" aria-hidden="true"></i> Nos Voyages</a>
                        </li>
                        <li>
                            <a href="<c:url value="/contact.jsp" />"><i class="fa fa-envelope" aria-hidden="true"></i> Contact</a>
                        </li>
                        
		                <c:if test="${ empty sessionUtilisateur }">
		                    <li>
		                        <a href="<c:url value="/connexion"/>"><i class="fa fa-sign-in" aria-hidden="true"></i> Connexion</a>
		                    </li>
		                    <li>
		                        <a href="<c:url value="/inscription"/>"><i class="fa fa-user-plus" aria-hidden="true"></i> Inscription</a>
		                    </li>
		                </c:if>
		                
                        <c:if test="${ !empty sessionScope.sessionUtilisateur }">
                            <li>
	                            <a href="<c:url value="/profilInformation"/>">
	                                <i class="fa fa-bars" aria-hidden="true"></i>
	                                ${ sessionScope.sessionUtilisateur.nom } ${ sessionScope.sessionUtilisateur.prenom }
	                            </a>
	                            <ul>
	                                <li>
	                                    <a href="<c:url value="/profilInformation"/>"><i class="fa fa-user" aria-hidden="true"></i> Mon profil</a>
	                                </li>
	                                <li>
	                                    <a href="<c:url value="/panier"/>"><i class="fa fa-shopping-cart" aria-hidden="true"></i> Mon panier</a>
	                                </li>
	                                
	                                <c:if test="${ sessionUtilisateur.isAdmin() }">
                                        <li>
	                                        <a href="<c:url value="/liste_voyages" />">
	                                            <i class="fa fa-cog" aria-hidden="true"></i>
	                                            Espace Administrateur
	                                        </a>
	                                        <ul>
	                                            <li>
	                                                <a href="<c:url value="/liste_voyages" />" ><i class="fa fa-plane" aria-hidden="true"></i> Voyages </a>
	                                            </li>
	                                            <li>
	                                                <a href="<c:url value="/liste_themes" />"><span class="glyphicon glyphicon-tent"></span> Thèmes </a>
	                                            </li>
	                                            <li>
	                                                <a href="<c:url value="/liste_types" />"><i class="fa fa-th-large" aria-hidden="true"></i> Types</a>
	                                            </li>
	                                            <li>
	                                                <a href="<c:url value="/liste_destinations" />"><i class="fa fa-map-marker" aria-hidden="true"></i> Destinations</a>
	                                            </li>
	                                            <li>
	                                                <a href="<c:url value="/liste_utilisateurs" />"><i class="fa fa-users" aria-hidden="true"></i> Utilisateurs</a>
	                                            </li>
	                                            <li>
											        <a href="<c:url value="/liste_messages" />"><i class="fa fa-envelope" aria-hidden="true"></i> Messages
											        <c:if test="${ sessionScope.notification != 0 }">
											            <span class="badge">
											                ${ sessionScope.notification }
											            </span>
											        </c:if>   
											        </a>
	                                            </li>
	                                            <li>
	                                                <a href="<c:url value="/liste_titres" />" ><i class="fa fa-picture-o" aria-hidden="true"></i> Slider captions</a>
	                                            </li>
	                                        </ul>
                                        </li>
                                    </c:if>
                                    
	                                <li>
                                        <a href="<c:url value="/deconnexion"/>"><i class="fa fa-sign-out" aria-hidden="true"></i> Déconnexion</a>
                                    </li>
	                            </ul>
                            </li>
                        </c:if>
                    </ul>
                </div>
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
