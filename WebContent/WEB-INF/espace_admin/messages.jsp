<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>PlanetEarth - Espace Administrateur - Liste des messages</title>
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
                    <li class="active">Messages</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->

        <hr>
        
        <div class="row">
            <!-- Sidebar Column -->
            <c:set var="pageAdmin" value="message" scope="request" />
            <c:import url="/WEB-INF/espace_admin/menu_admin.jsp" />
            
            <!-- Content Column -->
            <div class="col-md-9">
            
                <input class="form-control" id="myInput" type="text" placeholder="Recherche rapide...">
                        
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">Message</th>
                            <th scope="col">Nom et Prenom</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody id="myTable">
                        <c:forEach items="${ sessionScope.messages }" var="mapMessages">
                            <tr>
                                <td>
                                    ${ !mapMessages.value.vu ? '<strong>' : '' }
                                    <joda:format value="${  mapMessages.value.date }" pattern="dd/MM/yyyy 'à' HH'h'mm" ></joda:format>
                                    ${ !mapMessages.value.vu ? '</strong>' : '' }
                                </td>
                                <td>
                                    <a title="${ mapMessages.value.titre }" href="
                                        <c:url value="/afficherMessage">
                                            <c:param name="idMessage" value="${ mapMessages.key }" />
                                        </c:url>">
                                        
                                        ${ !mapMessages.value.vu ? '<strong>' : '' }
                                        <c:choose>
                                            <c:when test="${ mapMessages.value.titre.length() gt 50 }">
                                                ${ mapMessages.value.titre.substring(0,50) } ...
                                            </c:when>
                                            <c:otherwise>
                                               ${ mapMessages.value.titre }
                                            </c:otherwise>
                                        </c:choose>
                                        ${ !mapMessages.value.vu ? '</strong>' : '' }
                                    </a>
                                </td>
                                <td><c:out value="${ mapMessages.value.nomPrenom }"/></td>
                                <td>
                                    <a target="_top" href="mailto:${ mapMessages.value.email }">
                                        <i class="fa fa-reply" aria-hidden="true"></i>
                                    </a>
                                    
                                    <a href="
                                        <c:url value="/modificationMessage">
                                            <c:param name="id" value="${ mapMessages.key }" />
                                            <c:param name="vu" value="${ !mapMessages.value.vu ? true : false }" />
                                        </c:url>">
                                        ${ !mapMessages.value.vu ? '<i class="fa fa-envelope-open-o" aria-hidden="true"></i>' : '<i class="fa fa-envelope" aria-hidden="true"></i>' }
                                    </a>
                                    <a href="
                                        <c:url value="/suppressionMessage">
                                            <c:param name="idMessage" value="${ mapMessages.key }" />
                                        </c:url>">
                                        <i class="fa fa-trash-o" aria-hidden="true"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
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
    
    <!-- Script pour la recherche rapide dans la table -->
    <script>
        $(document).ready(function(){
          $("#myInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#myTable tr").filter(function() {
              $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
          });
        });
    </script>
    
</body>
</html>
