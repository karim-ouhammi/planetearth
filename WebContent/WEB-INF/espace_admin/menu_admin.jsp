<%@ page pageEncoding="UTF-8" %>

<div class="col-md-3">
    <div class="list-group">
        <a href="<c:url value="/liste_voyages" />" class="list-group-item
        ${ requestScope.pageAdmin == 'voyage' ? 'active' : '' }
        "><i class="fa fa-plane" aria-hidden="true"></i> Voyages </a>
        
        <a href="<c:url value="/liste_themes" />" class="list-group-item
        ${ requestScope.pageAdmin == 'theme' ? 'active' : '' }
        "><span class="glyphicon glyphicon-tent"></span> Thèmes </a>
        
        <a href="<c:url value="/liste_types" />" class="list-group-item
        ${ requestScope.pageAdmin == 'type' ? 'active' : '' }
        "><i class="fa fa-th-large" aria-hidden="true"></i> Types</a>
        
        <a href="<c:url value="/liste_destinations" />" class="list-group-item
        ${ requestScope.pageAdmin == 'destination' ? 'active' : '' }
        "><i class="fa fa-map-marker" aria-hidden="true"></i> Destinations</a>
        
        <a href="<c:url value="/liste_utilisateurs" />" class="list-group-item
        ${ requestScope.pageAdmin == 'utilisateur' ? 'active' : '' }
        "><i class="fa fa-users" aria-hidden="true"></i> Utilisateurs</a>
        
        <a href="<c:url value="/liste_messages" />" class="list-group-item
            ${ requestScope.pageAdmin == 'message' ? 'active' : '' }
            "><i class="fa fa-envelope" aria-hidden="true"></i> Messages
		<c:if test="${ sessionScope.notification != 0 }">
            <span class="badge">
                ${ sessionScope.notification }
            </span>
		</c:if>   
        </a>
        
        <a href="<c:url value="/liste_titres" />" class="list-group-item
        ${ requestScope.pageAdmin == 'titre' ? 'active' : '' }
        "><i class="fa fa-picture-o" aria-hidden="true"></i> Slider captions</a>
    </div>
    
        <div class="list-group">
            <span class="pull-right">
                <p style="color: #3E78D0">
                <c:choose>
                    <c:when test="${ requestScope.pageAdmin == 'voyage' }">
                        <i class="fa fa-eye" aria-hidden="true"></i> Plus d'info</br>
                        <i class="fa fa-pencil" aria-hidden="true"></i> Modifier</br>
                        <i class="fa fa-trash-o" aria-hidden="true"></i> Supprimer</br>
                    </c:when>
                    <c:when test="${ requestScope.pageAdmin == 'theme' }">
                        <i class="fa fa-trash-o" aria-hidden="true"></i> Supprimer</br>
                        <i class="fa fa-pencil" aria-hidden="true"></i> Modifier</br>
                    </c:when>
                    <c:when test="${ requestScope.pageAdmin == 'type' }">
                        <i class="fa fa-trash-o" aria-hidden="true"></i> Supprimer</br>
                        <i class="fa fa-pencil" aria-hidden="true"></i> Modifier</br>
                    </c:when>
                    <c:when test="${ requestScope.pageAdmin == 'destination' }">
                         <i class="fa fa-trash-o" aria-hidden="true"></i> Supprimer</br>
                    </c:when>
                    <c:when test="${ requestScope.pageAdmin == 'utilisateur' }">
                        <i class="fa fa-trash-o" aria-hidden="true"></i> Supprimer</br>
                        <i class="fa fa-shopping-cart" aria-hidden="true"></i> Visiter le panier</br>
                        <p class="info"><i class="fa fa-user" aria-hidden="true"></i> Administrateur</p>
                    </c:when>
                    <c:when test="${ requestScope.pageAdmin == 'message' }">
                        <i class="fa fa-reply" aria-hidden="true"></i> Répondre</br>
                        <i class="fa fa-envelope-open-o" aria-hidden="true"></i> Marquer comme lu</br>
                        <i class="fa fa-envelope" aria-hidden="true"></i>  Marquer comme non lu</br>
                        <i class="fa fa-trash-o" aria-hidden="true"></i> Supprimer</br>
                    </c:when>
                    <c:when test="${ requestScope.pageAdmin == 'titre' }">
                        <i class="fa fa-trash-o" aria-hidden="true"></i> Supprimer</br>
                    </c:when>
                </c:choose>
                </p>
            </span>
        </div>
    
</div>