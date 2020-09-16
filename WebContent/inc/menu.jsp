<%@ page pageEncoding="UTF-8" %>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <!-- <a class="navbar-brand" href="<c:url value="/index.jsp" />">PlanetEarth</a>  -->
            <a class="navbar-brand" href="<c:url value="/index.jsp" />">
                <img src="<c:url value="/inc/images/logo.jpg"/>" />
            </a>
            
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
            
                <li class="${ sessionScope.page == 'accueil' ? 'active' : '' }">
                    <a href="<c:url value="/index.jsp" />"><i class="fa fa-home" aria-hidden="true"></i> Accueil</a>
                </li>
                
                <li class="${ sessionScope.page == 'voyages' ? 'active' : '' }">
                    <a href="<c:url value="/voyages.jsp" />"><i class="fa fa-plane" aria-hidden="true"></i>Nos Voyages</a>
                </li>
                
                <li class="${ sessionScope.page == 'contact' ? 'active' : '' }">
                    <a href="<c:url value="/contact.jsp" />"><i class="fa fa-envelope" aria-hidden="true"></i> Contact</a>
                </li>
                
                
                <c:if test="${ empty sessionUtilisateur }">
                    <li class="${ sessionScope.page == 'connexion' ? 'active' : '' }">
                        <a href="<c:url value="/connexion"/>"><i class="fa fa-sign-in" aria-hidden="true"></i> Connexion</a>
                    </li>
                    <li class="${ sessionScope.page == 'inscription' ? 'active' : '' }">
                        <a href="<c:url value="/inscription"/>"><i class="fa fa-user-plus" aria-hidden="true"></i> Inscription</a>
                    </li>
                </c:if>
                
                <c:if test="${ !empty sessionScope.sessionUtilisateur }">
                     <li class="dropdown">
                         <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bars" aria-hidden="true"></i> ${ sessionUtilisateur.nom } ${ sessionUtilisateur.prenom } <b class="caret"></b></a>
                         <ul class="dropdown-menu">
                             <li>
                                 <a href="<c:url value="/profilInformation"/>"><i class="fa fa-user" aria-hidden="true"></i> Mon profil</a>
                            </li>
                            <li>
                                <a href="<c:url value="/panier"/>"><i class="fa fa-shopping-cart" aria-hidden="true"></i> Mon panier</a>
                            </li>
                            <c:if test="${ sessionUtilisateur.isAdmin() }">
                                <li>
                                    <a href="<c:url value="/espace_administrateur"/>"><i class="fa fa-cog" aria-hidden="true"></i> Espace Administrateur</a>
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
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container -->
</nav>