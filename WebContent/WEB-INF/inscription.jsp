<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>PlanetEarth - Inscritpion</title>
</head>

<body>
    <!-- Menu -->
    <c:set var="page" value="inscription" scope="session" />
    <c:import url="/inc/menu.jsp" />

    <div class="container">
    
        <!-- Page Heading/Breadcrumbs -->
        
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Inscription
                    <small></small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="<c:url value="/index.jsp" />">Accueil</a>
                    </li>
                    <li class="active">Inscription</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->

        <div class="row">
            
            <!-- inscription Form -->
            <div class="col-md-4 col-md-offset-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <form method="post" action="<c:url value="/inscription"/>" >
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
                                    <strong>Inscription a été effectué avec succès!</strong> Vous pouvez vous <a href="<c:url value="/connexion"/>" class="alert-link">connecter.</a>.
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
                                    <label for="motDePasseInsc">Mot de passe <span class="requis">*</span></label>
                                    <input type="password" class="form-control" id="motDePasseInsc" name="motDePasseInsc" >
                                    <p class="help-block">${form.erreurs['motDePasseInsc']}</p>
                                </div>
                            </div>
                            
                            <div class="control-group form-group">
                                <div class="controls">
                                    <label for="confirmation">Confirmez votre mot de passe <span class="requis">*</span></label>
                                    <input type="password" class="form-control" id="confirmation" name="confirmation" >
                                    <p class="help-block">${form.erreurs['confirmation']}</p>
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
                            
                            
                            <button type="submit" class="btn btn-primary">Inscription</button>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
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
