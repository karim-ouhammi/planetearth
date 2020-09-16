<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>Contact</title>
</head>

<body>
    <!-- Menu -->
    <c:set var="page" value="contact" scope="session" />
    <c:import url="/inc/menu.jsp" />

    <div class="container">
    
        <!-- Page Heading/Breadcrumbs -->
        
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Contact
                </h1>
                <ol class="breadcrumb">
                    <li><a href="<c:url value="/index.jsp" />">Accueil</a>
                    </li>
                    <li class="active">Contact</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->
        
        <!-- row de la map et des informations -->
        <div class="row">
            <!-- Map Column -->
            <div class="col-md-8">
                <!-- Embedded Google Map -->
                    <iframe width="100%" height="400" id="gmap_canvas" src="https://maps.google.com/maps?q=faculte%20des%20science%20meknes&t=&z=17&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>            </div>
            <!-- Contact Details Column -->
            <div class="col-md-4">
                <h3>Détails</h3>
                <p>
                    Faculté des sciences<br>Département informatique<br>Meknès, Maroc<br>
                </p>
                <p><i class="fa fa-phone"></i> 
                    <abbr title="Telephone">T</abbr>: (+212) 06 42 17 65 68</p>
                <p><i class="fa fa-envelope-o"></i> 
                    <abbr title="Email">E</abbr>: <a href="mailto:contact@planetearth.com">contact@planetearth.com</a>
                </p>
                <p><i class="fa fa-clock-o"></i> 
                    <abbr title="Heures">H</abbr>: Lundi - Vendredi: 9h:00 à 17h:00</p>
                <ul class="list-unstyled list-inline list-social-icons">
                    <li>
                        <a href="#"><i class="fa fa-facebook-square fa-2x"></i></a>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-linkedin-square fa-2x"></i></a>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-twitter-square fa-2x"></i></a>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-google-plus-square fa-2x"></i></a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- /.row -->
        
        <!-- row de formulaite -->
        <div class="row">

            <div class="col-md-8">
                <h3>Envoyez nous un message</h3>
                <form method="post" action="<c:url value="/contact"/>">
                    
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
                    
                    <c:if test="${ empty sessionUtilisateur }">
                    
	                    <div class="control-group form-group">
	                        <div class="controls">
	                            <label for="nom">Nom et prénom</label>
	                            <input type="text" class="form-control" id="nom" name="nom" value="${ message.nomPrenom }" maxlength="30">
	                            <p class="help-block">${ form.erreurs['nom'] }</p>
	                        </div>
	                    </div>
	                    
	                    <div class="control-group form-group">
	                        <div class="controls">
	                            <label for="email">Adresse email</label>
	                            <input type="text" class="form-control" id="email" name ="email" value="${ message.email }" maxlength="60">
	                            <p class="help-block">${ form.erreurs['email'] }</p>
	                        </div>
                        </div>
                    
                    </c:if>
                    
                    <div class="control-group form-group">
                        <div class="controls">
                            <label for="titre">Titre</label>
                            <input type="text" class="form-control" id="titre" name ="titre" value="${ message.titre }" maxlength="200">
                            <p class="help-block">${ form.erreurs['titre'] }</p>
                        </div>
                    </div>
                    
                    <div class="control-group form-group">
                        <div class="controls">
                            <label for="message">Message</label>
                            <textarea rows="10" cols="100" class="form-control" id="message" name="message" style="resize: vertical;">${ message.message }</textarea>
                            <p class="help-block">${ form.erreurs['message'] }</p>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Envoyer</button>
                </form>
            </div>

            <div class="col-md-3">
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
