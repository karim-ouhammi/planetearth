<%@ page pageEncoding="UTF-8" %>

<div class="col-md-3">
    <div class="list-group">
        <a href="<c:url value="/profilInformation" />" class="list-group-item
        ${ requestScope.pageProfil == 'information' ? 'active' : '' }
        "><i class="fa fa-info-circle" aria-hidden="true"></i> Informations </a>
        
        <a href="<c:url value="/modificationProfil" />" class="list-group-item
        ${ requestScope.pageProfil == 'modification' ? 'active' : '' }
        "><i class="fa fa-pencil" aria-hidden="true"></i> Modifier mes informations </a>
    </div>
    
    <div>
        <div class="list-group">
            <span class="pull-right">
                <p style="color: #3E78D0">
                    <c:if test="${ requestScope.pageProfil == 'information' }">
                        <i class="fa fa-pencil" aria-hidden="true"></i> Modifier mes informations</br>
                        <i class="fa fa-shopping-cart" aria-hidden="true"></i> Visiter mon panier</br>
                    </c:if>
                </p>
            </span>
        </div>
    </div>
    
</div>