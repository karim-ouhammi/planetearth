<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("now", new org.joda.time.DateTime()); %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>Résultats des voyages trouvés</title>
    
    <style>
    th, td {
      padding-right: 10px;
      padding-bottom: 2px;
    }
    select:invalid {
        color: gray;
    }
    option[value=""][disabled] {
        display: none;
    }
    </style>
    
</head>

<body>
    <!-- Menu -->
    <c:set var="page" value="voyages" scope="session" />
    <c:import url="/inc/menu.jsp" />

    <div class="container">
    
        <!-- Page Heading/Breadcrumbs -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Voyages
                    <small></small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="<c:url value="/index.jsp" />">Accueil</a>
                    </li>
                    <li><a href="<c:url value="/voyages.jsp" />">Voyages</a>
                    </li>
                    <li class="active">Recherche</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->
        
        <!-- row recherche -->
        <div class="row">
            <div class="col-md-12">
                
                <form method="post" action="<c:url value="/recherche"/>" >
                    
                    <div class="col-md-12">
                        <div class="col-md-2">
                            <div class="control-group form-group">
                                <div class="controls">
                                    <div>
                                        <select class="form-control" name="destination" id="destination">
                                            <option value="" disabled selected>Destination</option>
                                            <c:forEach items="${ sessionScope.destinations }" var="mapDestinations">
                                                <optgroup label="${ mapDestinations.key }">
                                                    <c:forEach items="${ mapDestinations.value }" var="destination">
                                                        <option value="${ destination.nom }">${ destination.nom }</option>
                                                    </c:forEach>
                                                </optgroup>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
    
                        <div class="col-md-2">
                            <div class="control-group form-group">
                                <div class="controls">
                                    <div>
                                        <select class="form-control" name="theme" id="theme">
                                            <option value="" disabled selected>Thème</option>
                                            <c:forEach items="${ sessionScope.types }" var="mapTypes">
                                                <optgroup label="${ mapTypes.value.nom }">
                                                    <c:forEach items="${ sessionScope.themes }" var="mapThemes">
                                                        <c:if test="${ mapThemes.value.type.id eq mapTypes.key }">
                                                            <option value="${ mapThemes.value.id }">${ mapThemes.value.nom }</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </optgroup>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-2">
                            <div class="control-group form-group">
                                <div class="controls">
                                    <input type="text" placeholder="Date de départ" onfocus="(this.type='date')" class="form-control"  id="date" name="date" min="<joda:format value="${now}" pattern="yyyy-MM-dd" />">
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-2">
                            <div class="control-group form-group">
                                <div class="controls">
                                    <div>
                                        <select class="form-control" name="duree" id="duree">
                                            <option value="" disabled selected>Durée</option>
                                            <option value="1" >Week-end/court séjour</option>
                                            <option value="2" >1 semaine</option>
                                            <option value="3" >2 semaines</option>
                                            <option value="4" >Long séjour</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-2">
                            <div class="control-group form-group">
                                <div class="controls">
                                    <div>
                                        <select class="form-control" name="difficulte" id="difficulte">
                                            <option value="" disabled selected>Difficultés</option>
                                            <option value="1" >Facile</option>
                                            <option value="2" >Modéré</option>
                                            <option value="3" >Sportif</option>
                                            <option value="4" >Difficile</option>
                                            <option value="5" >Extrême</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-2">
                            <div class="control-group form-group">
                                <div class="controls">
                                    <div>
                                        <select class="form-control" name="budget" id="budget">
                                            <option value="" disabled selected>Budget (Dhs)</option>
                                            <option value="1" >moins de 5000</option>
                                            <option value="2" >de 5000 à 10000</option>
                                            <option value="3" >de 10000 à 20000</option>
                                            <option value="4" >de 20000 à 30000</option>
                                            <option value="5" >plus de 30000</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-2">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Mots-clés" name="motsCles" id="motsCles">
                                <div class="input-group-btn">
                                    <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <hr>
        
        <!-- Messages -->
        <div class="row">
	        <div class="col-md-12">
	            <c:if test="${ !empty form.erreurs }">
		            <div class="alert alert-danger fade in">
		                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		                <strong><c:out value="${ form.erreurs['recherche'] }"/></strong> </br> Cliquez <a href="<c:url value="/voyages.jsp"/>" class="alert-link">ici</a> pour retourner aux voyages, ou effectuez une nouvelle recherche.
		            </div>
		        </c:if>
		        
		        <c:if test="${ empty form.erreurs and !empty form.resultat}">
		            <div class="alert alert-success fade in">
		                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		                <strong>${ form.resultat }</strong>
		            </div>
		        </c:if>
	        </div>
        </div>
        
        <!--Liste des voyages -->
        <c:forEach items="${ requestScope.recherche }" var="mapVoyages">
                 
            <div class="row">
            
                <div class="col-md-7">
                    <a href="
                    <c:url value="/afficherVoyage">
                        <c:param name="idVoyage" value="${ mapVoyages.key }" />
                    </c:url>
                    ">
                        <img class="img-responsive img-hover" src="<c:url value="/inc/images/${ mapVoyages.value.id }_imageListe" />" alt="${ mapVoyages.value.titre }">
                    </a>
                </div>
                
                <div class="col-md-5">
                    <h4>
                        <a title="${ mapVoyages.value.titre }" href="
                        <c:url value="/afficherVoyage">
                            <c:param name="idVoyage" value="${ mapVoyages.key }" />
                        </c:url>
                        ">
                            <c:choose>
                                <c:when test="${ mapVoyages.value.titre.length() gt 50 }">
                                    ${ mapVoyages.value.titre.substring(0,50) } ...
                                </c:when>
                                <c:otherwise>
                                   ${ mapVoyages.value.titre }
                                </c:otherwise>
                            </c:choose>
                        </a>
                              
                              <br/><small>${ mapVoyages.value.destination.nom }</small>
                    </h4>
                    
                    <div>
                        <span class="label label-primary">${ mapVoyages.value.theme.nom }</span>
                        <span class="label label-primary">${ mapVoyages.value.theme.type.nom }</span>
                    </div>
                             
                    <h4><fmt:formatNumber type="number" maxIntegerDigits="10"  maxFractionDigits="0" value="${ mapVoyages.value.prix }" /> <small>Dhs</small></h4>
                             
                    <div>       
                        <p>
                            <c:choose>
                                <c:when test="${ mapVoyages.value.description.length() gt 200 }">
                                    ${ mapVoyages.value.description.substring(0,200) } ...
                                </c:when>
                                <c:otherwise>
                                    ${ mapVoyages.value.description }
                                </c:otherwise>
                            </c:choose>
                            <span class="pull-right">
                                <a class="btn btn-default btn-xs" href="
                                    <c:url value="/afficherVoyage">
                                        <c:param name="idVoyage" value="${ mapVoyages.key }" />
                                    </c:url>">
                                    plus d'informations
                                </a>
                            </span>
                        </p>
                    </div>
                             
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <strong>Prochain départ </strong>
                                </td>
                                <td>
                                    <span class="label label-default">
                                        <joda:format value="${ mapVoyages.value.date }" pattern="dd/MM/yyyy" ></joda:format>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Durée </strong>
                                </td>
                                <td>
                                    <span class="label label-default">${ mapVoyages.value.duree } jours</span></br>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Difficulté </strong>
                                </td>
                                <td>
                                    <span title="
                                            <c:choose>
                                                <c:when test="${ mapVoyages.value.difficulte == 1 }">Facile</c:when>
                                                <c:when test="${ mapVoyages.value.difficulte == 2 }">Modéré</c:when>
                                                <c:when test="${ mapVoyages.value.difficulte == 3 }">Sportif</c:when>
                                                <c:when test="${ mapVoyages.value.difficulte == 4 }">Difficile</c:when>
                                                <c:when test="${ mapVoyages.value.difficulte == 5 }">Extrême</c:when>
                                            </c:choose>
                                        " class="label label-warning">
                                            <c:forEach var="i" begin="1" end="${ mapVoyages.value.difficulte }" step="1">
                                                <i class="fa fa-circle" aria-hidden="true"></i>
                                            </c:forEach>
                                            <c:forEach var="i" begin="1" end="${ 5 - mapVoyages.value.difficulte }" step="1">
                                                <i class="fa fa-circle-thin" aria-hidden="true"></i>
                                            </c:forEach>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </div>
                                        
                </div>
                
            </div>
            
            <hr>
            
        </c:forEach>
        
        <hr>

        <!-- Footer -->
        <c:import url="/inc/footer.jsp" />

    </div>
    <!-- /.container -->

    <!-- jQuery & Bootstrap Core JavaScript & Script to Activate the Carousel -->
    <c:import url="/inc/scripts.jsp" />
    
</body>

</html>
