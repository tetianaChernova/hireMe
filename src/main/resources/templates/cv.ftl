<#import "parts/common.ftl" as c>
<@c.page "/static/profile.css">
    <div class="profile-page">
        <div class="page-header header-filter" data-parallax="true"
             style="background-image:url('https://t4.ftcdn.net/jpg/03/57/16/57/360_F_357165707_26OZ4FfKDoOWmlghEiUoY9WRe64Ffe9X.jpg'); margin: 0"></div>
        <div class="main main-raised">
            <div class="profile-content">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 ml-auto mr-auto">
                            <div class="profile">
                                <div class="avatar">
                                    <#if user??>
                                        <#if user.filename??>
                                            <img src="/img/${user.filename}" alt="Circle Image"
                                                 class="img-raised rounded-circle img-fluid"
                                                 style="width: 140px;height: 140px;">
                                        <#else>
                                            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRWKbLa_dJgtKiBItyiLId0m6ZKSbRwtCKCgf9dsgGED2uRcZXJ&usqp=CAU"
                                                 alt="Circle Image" class="img-raised rounded-circle img-fluid">
                                        </#if>
                                    </#if>
                                </div>
                                <div class="name">
                                    <h3 class="title"><#if user.cv.firstName??>user.cv.firstName<#else>First name</#if> <#if user.cv.lastName??>user.cv.lastName<#else>Last name</#if></h3>
                                    <h3 class="title"><#if user.cv.title??>user.cv.title<#else>Title</#if></h3>
                                    <p><#if user.cv.experience??>user.cv.experience<#else>?</#if>y. of experience</p>
                                    <p><i class="glyphicon glyphicon-phone"></i><#if user.cv.phone??>user.cv.phone<#else>+38000000000</#if></p>
                                    <p><i class="glyphicon glyphicon-envelope"></i> ${user.email}</p>
                                    <p><#if user.cv.nationality??>user.cv.nationality<#else>nationality</#if>, currently living in <#if user.cv.city??>user.cv.city<#else>city</#if><i class="glyphicon glyphicon-map-marker"></i></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="description text-center">
                        <p><#if user.cv.description??>user.cv.description<#else>description</#if></p>
                    </div>
                </div>
            </div>
        </div>
        <footer class="footer text-center ">
            <p>Made with Love
                by HireMe Team</p>
        </footer>
    </div>
</@c.page>
