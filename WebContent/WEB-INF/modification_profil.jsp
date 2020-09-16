<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>Modification Profil - ${ sessionUtilisateur.nom } ${ sessionUtilisateur.prenom }</title>
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
                    <li class="active">Modification</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->
        
        <div class="row">
        
            <!-- Sidebar Column -->
            <c:set var="pageProfil" value="modification" scope="request" />
            <c:import url="/WEB-INF/menu_profil.jsp" />
            
            <div class="col-md-9">
                
                <div class="col-md-9">
                    <ul class="pager">
                        <li class="previous">
                            <a href="
                                <c:url value="/profilInformation"/>">
                                <i class="fa fa-chevron-circle-left" aria-hidden="true"></i> Annuler
                            </a>
                        </li>
                    </ul>
                </div>
                
                <div class="col-md-6 col-md-offset-3">
                    <form method="post" action="<c:url value="/modificationProfil"/>" >
                    
	                    <div id="success">
	                        <c:if test="${ !empty form.erreurs }">
	                            <div class="alert alert-danger fade in">
	                                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
	                                <strong><c:out value="${ form.resultat }"/>.</strong>
	                            </div>
	                        </c:if>
	                    </div>
	                    
	                    <c:if test="${ empty form.erreurs and !empty form.resultat}">
	                        <div class="alert alert-success fade in">
	                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
	                            <strong>Modification a été effectué avec succès!</strong>
	                        </div>
	                    </c:if>
	                    
                        <div class="control-group form-group">
	                        <div class="controls">
	                            <label for="email">Email <span class="requis">*</span></label>
	                            <input type="text" class="form-control" id="email" name="email" value="<c:out value="${ utilisateur.email }" />" maxlength="60">
	                            <p class="help-block">${form.erreurs['email']}</p>
	                        </div>
                        </div>
	                    
	                    <div class="control-group form-group">
	                        <div class="controls">
	                            <label for="nom">Nom <span class="requis">*</span></label>
	                            <input type="text" class="form-control" id="nom" name="nom" value="<c:out value="${ utilisateur.nom }" />" maxlength="20">
	                            <p class="help-block">${form.erreurs['nom']}</p>
	                        </div>
	                    </div>
	                    
	                    <div class="control-group form-group">
	                        <div class="controls">
	                            <label for="prenom">Prénom <span class="requis">*</span></label>
	                            <input type="text" class="form-control" id="prenom" name="prenom" value="<c:out value="${ utilisateur.prenom }" />" maxlength="20">
	                            <p class="help-block">${form.erreurs['prenom']}</p>
	                        </div>
	                    </div>
	                    
	                    <div class="control-group form-group">
	                        <div class="controls">
	                            <label for="age">Age <span class="requis">*</span></label>
	                            <input type="text" class="form-control" id="age" name="age" value="<c:out value="${ utilisateur.age }" />" maxlength="2">
	                            <p class="help-block">${form.erreurs['age']}</p>
	                        </div>
	                    </div>
	                    
	                    <div class="control-group form-group">
	                        <div class="controls">
	                            <label for="telephone">Téléphone <span class="requis">*</span></label>
	                            <input type="text" class="form-control" id="telephone" name="telephone" value="<c:out value="${ utilisateur.telephone }" />" maxlength="10">
	                            <p class="help-block">${form.erreurs['telephone']}</p>
	                        </div>
	                    </div>
	                    <p><span class="requis">*</span> Champs obligatoires</p>
	                    
	                    
	                    <button type="submit" class="btn btn-primary">Appliquer</button>
	                </form>
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
