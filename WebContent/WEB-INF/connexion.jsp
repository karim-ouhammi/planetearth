<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>Connectez-vous</title>
</head>

<body>
    <!-- Menu -->
    <c:set var="page" value="connexion" scope="session" />
    <c:import url="/inc/menu.jsp" />

    <div class="container">
    
        <!-- Page Heading/Breadcrumbs -->
        
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Connexion
                    <small></small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="<c:url value="/index.jsp" />">Accueil</a>
                    </li>
                    <li class="active">Connexion</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->

        <div class="row">
            
            <!-- connexion Form -->
            <div class="col-md-4 col-md-offset-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                    
                        <div id="success">
                            <c:if test="${ !empty form.erreurs }">
                                <div class="alert alert-danger fade in">
                                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                    <strong><c:out value="${ form.resultat }"/></strong>
                                </div>
                            </c:if>
                            
                            <c:if test="${ empty form.erreurs and !empty form.resultat}">
                                <div class="alert alert-success fade in">
                                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                    <strong>Inscription a été effectué avec succès!</strong> Vous pouvez vous connecter.
                                </div>
                            </c:if>
                        </div>
                    
                        <form method="post" action="<c:url value="/connexion"/>">
		                
		                    <div class="control-group form-group">
		                        <div class="input-group margin-bottom-sm">
		                            <span class="input-group-addon"><i class="fa fa-envelope-o fa-fw"></i></span>
		                            <input type="text" class="form-control" placeholder="Adresse email" id="email" name="email" value="<c:out value="${ utilisateur.email }" />" maxlength="60">
		                        </div>
		                        <p class="help-block">${ form.erreurs['email'] }</p>
		                    </div>
		                    
		                    <div class="control-group form-group">
		                        <div class="input-group margin-bottom-sm">
                                    <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
		                            <input type="password" class="form-control" placeholder="Mot de passe" id="motDePasse" name="motDePasse" >
		                        </div>
		                        <p class="help-block">${ form.erreurs['motDePasse'] }</p>
		                    </div>
		                        
		                    <button type="submit" class="btn btn-primary">Connexion</button>
		                     <div class="control-group form-group">
                                <p class="help-block">Vous n'avez pas de compte ? <a href="<c:url value="/inscription.jsp"/>">S'inscrire</a>.</p>
                            </div>
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
