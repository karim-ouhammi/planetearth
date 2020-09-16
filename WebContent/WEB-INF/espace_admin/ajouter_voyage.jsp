<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<% pageContext.setAttribute("now", new org.joda.time.DateTime()); %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    
    <c:import url="/inc/header.jsp" />
    <title>Espace Administrateur - Ajouter un nouveau voyages</title>
    
    <!-- Style pour range slider -->
    <style>
	    .slidecontainer {
	      width: 100%;
	    }
	    
	    .slider {
	      -webkit-appearance: none;
	      width: 100%;
	      height: 8px;
	      border-radius: 5px;
	      background: #d3d3d3;
	      outline: none;
	      opacity: 0.7;
	      -webkit-transition: .2s;
	      transition: opacity .2s;
	    }
	    
	    .slider:hover {
	      opacity: 1;
	    }
	    
	    .slider::-webkit-slider-thumb {
	      -webkit-appearance: none;
	      appearance: none;
	      width: 20px;
	      height: 20px;
	      border-radius: 50%;
	      background: #3E78D0;
	      cursor: pointer;
	    }
	    
	    .slider::-moz-range-thumb {
	      width: 25px;
	      height: 25px;
	      border-radius: 50%;
	      background: #4CAF50;
	      cursor: pointer;
	    }
	    
	    
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
                    <li><a href="<c:url value="/liste_voyages"/>">Voyages</a>
                    </li>
                    <li class="active">Ajouter un nouveau voyage</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->
        
        <hr>
        
        <div class="row">
            <!-- Sidebar Column -->
            <c:set var="pageAdmin" value="voyage" scope="request" />
            <c:import url="/WEB-INF/espace_admin/menu_admin.jsp" />
            
            <div class="col-md-9">
                
                <div class="col-md-9">
                    <ul class="pager">
                        <li class="previous">
                            <a href="<c:url value="/liste_voyages" />">
                                <i class="fa fa-chevron-circle-left" aria-hidden="true"></i> Annuler
                            </a>
                        </li>
                    </ul>
                </div>
                
                <!-- Form addition voyages -->
                <div class="col-md-6 col-md-offset-3">
                    <form method="post" action="<c:url value="/ajouterVoyage"/>" enctype="multipart/form-data">
                    
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
                                <input type="text" class="form-control" id="titre" name="titre" value="<c:out value="${ voyage.titre }"/>" maxlength="200">
                                <p class="help-block">${ form.erreurs['titre'] }</p>
                            </div>
                        </div>
                        
                        <div class="control-group form-group">
                            <div class="controls">
                                <label for="hebergement">Hébergement</label>
                                <input type="text" class="form-control" id="hebergement" name="hebergement" value="<c:out value="${ voyage.hebergement }"/>" maxlength="200">
                                <p class="help-block">${ form.erreurs['hebergement'] }</p>
                            </div>
                        </div>
                        
                        <div class="control-group form-group">
                            <div class="controls">
                                <label for="destination">Destination</label>
                                <div>
                                    <select class="form-control" name="destination" id="destination">
                                        <c:forEach items="${ sessionScope.destinations }" var="mapDestinations">
                                            <optgroup label="${ mapDestinations.key }">
                                                <c:forEach items="${ mapDestinations.value }" var="destination">
                                                    <option value="${ destination.nom }" ${ destination.nom eq voyage.destination.nom ? 'selected' : '' }>${ destination.nom }</option>
                                                </c:forEach>
                                            </optgroup>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="control-group form-group">
                            <div class="controls">
                                <label for="theme">Thème</label>
                                <div>
                                    <select class="form-control" name="theme" id="theme">
                                        <c:forEach items="${ sessionScope.types }" var="mapTypes">
                                            <optgroup label="${ mapTypes.value.nom }">
                                                <c:forEach items="${ sessionScope.themes }" var="mapThemes">
                                                    <c:if test="${ mapThemes.value.type.id eq mapTypes.key }">
                                                        <option value="${ mapThemes.value.id }" ${ mapThemes.value.id eq voyage.theme.id ? 'selected' : '' }>${ mapThemes.value.nom }</option>
                                                    </c:if>
                                                </c:forEach>
                                            </optgroup>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="control-group form-group">
                            <div class="controls">
                                <label for="date">Date de départ</label>
                                <input type="date" class="form-control" id="date" name="date" value="<joda:format value="${  voyage.date }" pattern="yyyy-MM-dd" ></joda:format>" min="<joda:format value="${now}" pattern="yyyy-MM-dd" />">
                                <p class="help-block">${ form.erreurs['date'] }</p>
                            </div>
                        </div>
                        
                        <div class="control-group form-group">
                            <div class="controls">
                                <label for="duree">Durée</label>
                                <input type="text" class="form-control" placeholder ="en jour" id="duree" name ="duree" value="${ voyage.duree }" maxlength="2">
                                <p class="help-block">${ form.erreurs['duree'] }</p>
                            </div>
                        </div>
                        
                        <div class="control-group form-group">
                            <div class="controls">
                                <label for="prix">Prix</label>
                                <input type="text" class="form-control" placeholder="en Dhs" id="prix" name ="prix" value="${ voyage.prix }">
                                <p class="help-block">${ form.erreurs['prix'] }</p>
                            </div>
                        </div>
                        
                        <div class="slidecontainer">
                            <div class="control-group form-group">
                                <div class="controls">
                                    <label for="difficulte">Difficulté</label>
                                    <input type="range" class="slider" min="1" max="5" step="1" id="difficulte" name ="difficulte"
                                    value="${ empty voyage.difficulte ? '3' : voyage.difficulte }" oninput="difficulteOutPut.value = difficulte.value">
                                    <p style="text-align:center"><output name="difficulteOutPut" id="difficulteOutPut">${ empty voyage.difficulte ? '3' : voyage.difficulte }</output></p>
                                    <p class="help-block">${ form.erreurs['difficulte'] }</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="slidecontainer">
                            <div class="control-group form-group">
                                <div class="controls">
                                    <label for="altitude">Altitude</label>
                                    <input type="range" class="slider" min="1" max="5" step="1" id="altitude" name ="altitude"
                                    value="${ empty voyage.altitude ? '3' : voyage.altitude }" oninput="altitudeOutPut.value = altitude.value">
                                    <p style="text-align:center"><output name="altitudeOutPut" id="altitudeOutPut">${ empty voyage.altitude ? '3' : voyage.altitude }</output></p>
                                    <p class="help-block">${ form.erreurs['altitude'] }</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="control-group form-group">
                            <div class="controls">
                                <label for="imageListe" class="custom-file-upload">
                                    <i class="fa fa-cloud-upload"></i> <span id="fileLabelImageListe">Image d'aperçu 700x300</span>
                                </label>
                                <input id="imageListe" name="imageListe" type="file" onchange="pressed()"/>
                                <p class="help-block">${ form.erreurs['imageListe'] }</p>
                            </div>
                        </div>
                        
                        <div class="control-group form-group">
                            <div class="controls">
                                <label for="image1" class="custom-file-upload">
                                    <i class="fa fa-cloud-upload"></i> <span id="fileLabelImage1">Image 700x500</span>
                                </label>
                                <input id="image1" name="image1" type="file" onchange="pressed()"/>
                                <p class="help-block">${ form.erreurs['image1'] }</p>
                            </div>
                        </div>
                        
                        <div class="control-group form-group">
                            <div class="controls">
                                <label for="image2" class="custom-file-upload">
                                    <i class="fa fa-cloud-upload"></i> <span id="fileLabelImage2">Image 700x500</span>
                                </label>
                                <input id="image2" name="image2" type="file" onchange="pressed()"/>
                                <p class="help-block">${ form.erreurs['image2'] }</p>
                            </div>
                        </div>
                        
                        <div class="control-group form-group">
                            <div class="controls">
                                <label for="image3" class="custom-file-upload">
                                    <i class="fa fa-cloud-upload"></i> <span id="fileLabelImage3">Image 700x500</span>
                                </label>
                                <input id="image3" name="image3" type="file" onchange="pressed()"/>
                                <p class="help-block">${ form.erreurs['image3'] }</p>
                            </div>
                        </div>
                        
                        <div class="control-group form-group">
                            <div class="controls">
                                <label for="description">Description</label>
                                <textarea rows="10" cols="100" class="form-control" id="description" name="description" style="resize: vertical;">${ voyage.description }</textarea>
                                <p class="help-block">${ form.erreurs['description'] }</p>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Ajouter</button>
                    </form>
                </div>
                <!-- Form addition voyages -->
                
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
    
    <!--Script input type file -->
    <script>
	    window.pressed = function(){
	    var a = document.getElementById('imageListe');
	    var b = document.getElementById('image1');
	    var c = document.getElementById('image2');
	    var d = document.getElementById('image3');
	    if(a.value == "")
	    {
	        fileLabelImageListe.innerHTML = "Image d'aperçu 700x300";
	    }
	    else
	    {
	        var theSplit = a.value.split('\\');
	        fileLabelImageListe.innerHTML = theSplit[theSplit.length-1];
	    }
	    if(b.value == "")
        {
	    	fileLabelImage1.innerHTML = "Image 700x500";
        }
        else
        {
            var theSplit = a.value.split('\\');
            fileLabelImage1.innerHTML = theSplit[theSplit.length-1];
        }
	    if(c.value == "")
        {
	    	fileLabelImage2.innerHTML = "Image 700x500";
        }
        else
        {
            var theSplit = a.value.split('\\');
            fileLabelImage2.innerHTML = theSplit[theSplit.length-1];
        }
	    if(d.value == "")
        {
	    	fileLabelImage3.innerHTML = "Image 700x500";
        }
        else
        {
            var theSplit = a.value.split('\\');
            fileLabelImage3.innerHTML = theSplit[theSplit.length-1];
        }
	    };
    </script>
    
</body>

</html>
