<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>Espace Administrateur - Liste des utilisateurs</title>
    
    <style>
        input[type="file"] {
            display: none;
        }
        .custom-file-upload {
            border: 1px solid #ccc;
            display: inline-block;
            padding: 6px 12px;
            cursor: pointer;
            width: 100%;
            border-radius: 5px;
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
        }
    </style>
    
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
                    <li class="active">Slider captions</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->

        <hr>
        
        <div class="row">
            <!-- Sidebar Column -->
            <c:set var="pageAdmin" value="titre" scope="request" />
            <c:import url="/WEB-INF/espace_admin/menu_admin.jsp" />
            
            <!-- Content Column -->
            <div class="col-md-9">
            
            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <form method="post" action="<c:url value="/liste_titres"/>" enctype="multipart/form-data">
                        
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
                                    <label for="titre">Titre</label>
                                    <input type="text" class="form-control" id="titre" name="titre" value="<c:out value="${ titre.titre }"/>" maxlength="200">
                                    <p class="help-block">${ form.erreurs['titre'] }</p>
                                </div>
                            </div>                            
                            
                            <div class="control-group form-group">
                                <div class="controls">
                                    <label for="image" class="custom-file-upload">
                                        <i class="fa fa-cloud-upload"></i> <span id="fileLabel">Image <font size="1" color="#808080">(de préférable de haute résolution)</font></span>
                                    </label>
                                    <input id="image" name="image" type="file" onchange="pressed()"/>
                                    <p class="help-block">${ form.erreurs['image'] }</p>
                                </div>
                            </div>
                            
                            <button type="submit" class="btn btn-primary">Ajouter</button>
                        </form>
                   </div>
                </div>
            </div>
            
            <c:forEach items="${ sessionScope.titres }" var="mapTitres">
                <div class="col-md-4">
                    <div class="thumbnail">
                        <img src="<c:url value="/inc/images/titres/${ mapTitres.value.id }_image"/>" alt="Lights" style="width:100%">
                        <div class="caption">
                            <p> 
                                <a href="
                                    <c:url value="/suppressionTitre">
                                        <c:param name="idTitre" value="${ mapTitres.key }" />
                                    </c:url>">
                                    <i class="fa fa-trash-o" aria-hidden="true"></i>
                                </a>
                                ${ mapTitres.value.titre }
                            </p>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
                
            </div> 
            <!-- /.Content Column -->  
            
        </div>
        <!-- /.row -->

        <hr>

        <!-- Footer -->
        <c:import url="/inc/footer.jsp" />

    </div>
    <!-- /.container -->

    <!-- jQuery & Bootstrap Core JavaScript & Script to Activate the Carousel -->
    <c:import url="/inc/scripts.jsp" />
    
        <!--Script input type file -->
    <script>
        window.pressed = function(){
        var a = document.getElementById('image');
        if(a.value == "")
        {
            fileLabel.innerHTML = "Image";
        }
        else
        {
            var theSplit = a.value.split('\\');
            fileLabel.innerHTML = theSplit[theSplit.length-1];
        }
        };
    </script>
    
</body>
</html>
