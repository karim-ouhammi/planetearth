<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<!DOCTYPE html>
<html lang="fr" class="no-js">
<head>
    <c:import url="/inc/header.jsp" />
    <title>Espace Administrateur - Message de ${ requestScope.message.nomPrenom }</title>
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
                    <li><a href="<c:url value="/liste_messages"/>">Messages</a>
                    </li>
                    <li class="active">${ requestScope.message.nomPrenom }: ${ requestScope.message.titre }</li>
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
                <ul class="pager">
                    <li class="previous"><a href="<c:url value="/liste_messages" />"><i class="fa fa-chevron-circle-left" aria-hidden="true"></i> Retour</a></li>
                </ul>
                <div class="panel panel-default">
				    <div class="panel-heading">
				        <strong>
				            ${ requestScope.message.titre }
				            <span class="pull-right">
					            <a target="_top" href="mailto:${ requestScope.message.email }">
	                                <i class="fa fa-reply" aria-hidden="true"></i>
	                            </a>
                            </span>
				        </strong>
				    </div>
				    <div class="panel-body">
                        <p>${ requestScope.message.message }</p>
                        <p align="right">${ requestScope.message.nomPrenom }, envoyé le: <joda:format value="${  requestScope.message.date }" pattern="dd/MM/yyyy 'à' HH'h'mm" ></joda:format></p>
				    </div>
				</div>

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
    
</body>

</html>
