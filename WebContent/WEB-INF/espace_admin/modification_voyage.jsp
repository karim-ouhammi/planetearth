<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<% pageContext.setAttribute("now", new org.joda.time.DateTime()); %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>Espace Administrateur - Modification du voyage</title>
    
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
                    <li class="active">Modifier un voyage</li>
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
                            <a href="
                                <c:url value="/adminAfficherVoyage">
                                    <c:param name="idVoyage" value="${ voyage.id }" />
                                </c:url>">
                                <i class="fa fa-chevron-circle-left" aria-hidden="true"></i> Annuler
                            </a>
                        </li>
                    </ul>
                </div>
                
                <!-- Form modification voyages -->    
                <div class="col-md-6 col-md-offset-3">
                    
                    <div id="success">
                        <c:if test="${ !empty form.erreurs }">
                            <div class="alert alert-danger fade in">
                                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                <strong><c:out value="${ form.resultat }"/></strong>
                            </div>
                        </c:if>
                    </div>
                
                    <form method="post" action="<c:url value="/modificationVoyage"/>">
                        <!-- hidden id field -->
                        <input type="hidden" class="form-control" id="idVoyage" name="idVoyage" value="<c:out value="${ voyage.id }"/>">
                        <!-- /.hidden id field -->
                    
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
                                <label for="description">Description</label>
                                <textarea rows="10" cols="100" class="form-control" id="description" name="description" maxlength="999" style="resize: vertical;">${ voyage.description }</textarea>
                                <p class="help-block">${ form.erreurs['description'] }</p>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Appliquer</button>
                    </form>
                </div>
                <!-- Form Modification voyages -->
                
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
