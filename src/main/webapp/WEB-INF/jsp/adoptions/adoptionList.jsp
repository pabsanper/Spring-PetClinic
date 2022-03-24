<%@ page session="false" trimDirectiveWhitespaces="true" %> <%@ page
pageEncoding="UTF-8"%> <%@ taglib prefix="spring"
uri="http://www.springframework.org/tags" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="petclinic"
tagdir="/WEB-INF/tags" %> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions" %>

<petclinic:layout pageName="adoptions">
    <div class="warpper">
        <input class="radio" id="one" name="group" type="radio" checked>
        <input class="radio" id="two" name="group" type="radio">
        <div class="tabs">
            <label class="tab" id="one-tab" for="one">Adopciones disponibles</label>
            <label class="tab" id="two-tab" for="two">Solicitudes de adopción</label>
        </div>
        <div class="panels">
            <div class="panel" id="one-panel">
                <div class="panel-title">Adopciones disponibles </div><a class="btn btn-default" style="float:right;" href='<spring:url value="/adoptions/new" htmlEscape="true"/>'>Poner en adopción</a> <br> <br> 
                <div class="cards">
                    <c:forEach items="${adoptions}" var="adoption">
                        <div class="card card-1">
                            <div class="card__icon">
                                <c:out value="${adoption.pet.name} (${adoption.pet.type})" />
                            </div>
                            <p class="card__exit"><i class="fas fa-times"></i></p>
                            <h2 class="card__title">
                                <c:out value="${adoption.description}" />
                            </h2>
                            <p class="card__apply">
                                <span><spring:url
                                    value="/adoptions/{adoptionId}/request"
                                    var="adoptionRequestUrl"
                                    >
                                    <spring:param name="adoptionId" value="${adoption.id}" />
                                    </spring:url>
                                    <a class="card__link" href="${fn:escapeXml(adoptionRequestUrl)}"
                                    >¡Adóptame!</a
                                ></span>
                                <span style="padding-left:30rem;">
                                    <spring:url
                                        value="/adoptions/{adoptionId}/requestList"
                                        var="adoptionRequestListUrl"
                                    >
                                    <spring:param name="adoptionId" value="${adoption.id}" />
                                    </spring:url><a class="card__link" href="${fn:escapeXml(adoptionRequestListUrl)}"
                                    >Solicitudes</a
                                ></span>
                            </p>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="panel" id="two-panel">
            <div class="panel-title">Todas las solicitudes</div>
                    <div class="cards">
                        <c:forEach items="${requestAdoptions}" var="requestAdoption">
                        <div class="card card-1">
                            <div class="card__icon">
                            <c:out value="${requestAdoption.status}" />
                            </div>
                            <p class="card__exit"><i class="fas fa-times"></i></p>
                            <h2 class="card__title">
                            <c:out value="${requestAdoption.description}" />
                            </h2>
                        </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>

  <!-- <p><c:out value="${user}"/></p> -->

  
</petclinic:layout>
