<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>Profil - ${ sessionUtilisateur.nom } ${ sessionUtilisateur.prenom }</title>
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
                    <small>Mon profil</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="<c:url value="/index.jsp" />">Accueil</a>
                    </li>
                    <li><a href="<c:url value="/profilInformation" />">Mon profil</a></li>
                    <li class="active">Mes informations</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->
        
        <div class="row">
        
            <!-- Sidebar Column -->
            <c:set var="pageProfil" value="information" scope="request" />
            <c:import url="/WEB-INF/menu_profil.jsp" />
            
            <div class="col-md-9">
                <c:if test="${ empty form.erreurs and !empty form.resultat}">
                    <div class="alert alert-success fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <strong>Les modifications ont été effectuées avec succès!</strong>
                    </div>
                </c:if>
                        
                <div class="col-md-6 col-md-offset-3">
                    <table class="table table-striped">
                    <thead>
                        <tr>
                            <th colspan=2 style="text-align:center">Informations personnelle</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>Adresse email</th>
                            <td>${ sessionUtilisateur.email }</td>
                        </tr>
                        <tr>
                            <th>Nom</th>
                            <td>${ sessionUtilisateur.nom }</td>
                        </tr>
                        <tr>
                            <th>Prénom</th>
                            <td>${ sessionUtilisateur.prenom }</td>
                        </tr>
                        <tr>
                            <th>Age</th>
                            <td>${ sessionUtilisateur.age } ans</td>
                        </tr>
                        <tr>
                            <th>Numéro de téléphone</th>
                            <td>${ sessionUtilisateur.telephone }</td>
                        </tr>
                        <tr>
                            <th>Inscrit depuis</th>
                            <td><joda:format value="${ sessionUtilisateur.dateInscription }" pattern="dd/MM/yyyy 'à' HH'h'mm" ></joda:format></td>
                        </tr>
                        <tr>
                            <th>Action</th>
                            <td>
                            <a href="<c:url value="/panier"/>">
                                <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                            </a>
                            <a href="<c:url value="/modificationProfil" />">
                                <i class="fa fa-pencil" aria-hidden="true"></i>
                            </a>
                            </td>
                        </tr>
                      </tbody>
                    </table>
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
