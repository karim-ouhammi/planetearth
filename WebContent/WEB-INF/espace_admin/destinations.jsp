<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>Espace Administrateur - Liste des destination</title>
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
                    <li class="active">Destinations</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->
        
        <hr>
        
        <!-- Tabs -->
        <div class="row">
            <!-- Sidebar Column -->
            <c:set var="pageAdmin" value="destination" scope="request" />
            <c:import url="/WEB-INF/espace_admin/menu_admin.jsp" />

            <!-- Content Column -->
            <div class="col-md-9">
                <div class="col-md-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <strong>Ajouter une destination</strong>
                        </div>
                    <div class="panel-body">
                        <form method="post" action="<c:url value="liste_destinations"/>">
                        
                            <div id="success">
                                <c:if test="${ empty form.erreurs and !empty form.resultat}">
                                    <div class="alert alert-success fade in">
                                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                        <strong>${ form.resultat }</strong>
                                    </div>
                                </c:if>
                                
                                <c:if test="${ !empty form.erreurs }">
                                    <div class="alert alert-danger fade in">
                                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                        <strong><c:out value="${ form.resultat }"/></strong>
                                    </div>
                                </c:if>
                            </div>
                        
                            <div class="control-group form-group">
                                <div class="controls">
                                    <label for="nomDestination">Nom</label>
                                    <input type="text" class="form-control" id="nom" name="nomDestination" value="${ destination.nom }" maxlength="20">
                                    <p class="help-block">${ form.erreurs['nomDestination'] }</p>
                                </div>
                            </div>
                            
                            <div class="control-group form-group">
                                <div class="controls">
                                    <label for="continent">Continent</label>
                                    <div>
                                         <select class="form-control" name="listeContinents" id="listeContinents">
                                                <option value="<c:out value="Afrique" />" >Afrique</option>
                                                <option value="<c:out value="Amérique" />" >Amérique</option>
                                                <option value="<c:out value="Asie" />" >Asie</option>
                                                <option value="<c:out value="Europe" />" >Europe</option>
                                                <option value="<c:out value="Océanie" />" >Océanie</option>
                                         </select>
                                     </div>
                                </div>
                            </div>
                                
                            <button type="submit" class="btn btn-primary">Ajouter</button>
                        </form>
                    </div>
                </div>
            </div>
            <!-- /.Destination Form -->
            <div class="col-md-7">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <strong>Liste des destinations</strong>
                    </div>
                    <c:choose>
                        <c:when test="${ empty sessionScope.destinations }">
                            <p class="erreur">Aucune destination enregistré.</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${ sessionScope.destinations }" var="mapDestinations">
                                <ul>
                                    <li><strong><c:out value="${ mapDestinations.key }" /></strong>
                                        <ul>
                                            <c:forEach items="${ mapDestinations.value }" var="destination">
                                                <li>
                                                    <a href="
                                                        <c:url value="/suppressionDestination">
                                                            <c:param name="nom" value="${ destination.nom }" />
                                                            <c:param name="continent" value="${mapDestinations.key }" />
                                                        </c:url>">
                                                        <i class="fa fa-trash-o" aria-hidden="true"></i>
                                                    </a>
                                                    <c:out value="${ destination.nom }" />
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </ul>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
            
                </div>
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
