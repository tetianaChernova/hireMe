<#import "parts/common.ftl" as c>
<@c.page "/static/posts.css">
    <div class="container">
        <div class="main-body">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 gutters-sm">
                 <#list candidates as candidate>
                <div class="col mb-3">
                    <div class="card">
                        <img src="https://www.htmlcsscolor.com/preview/gallery/CCCCFF.png" alt="Cover" class="card-img-top">
                        <div class="card-body text-center">
                            <#if candidate.filename??>
                                <img src="/img/${candidate.filename}" alt="Circle Image"
                                     class="img-fluid img-thumbnail rounded-circle border-0 mb-3"
                                     style="width: 100px;height: 100px; margin-top:-65px;" alt="User">
                            <#else>
                                <img src="https://bootdey.com/img/Content/avatar/avatar7.png"
                                     style="width:100px;margin-top:-65px" alt="User"
                                     class="img-fluid img-thumbnail rounded-circle border-0 mb-3">

                            </#if>
                            <h5 class="card-title"><#if candidate.cv.firstName??>${candidate.cv.firstName}<#else>First name</#if> <#if candidate.cv.lastName??>${candidate.cv.lastName}<#else>Last name</#if></h5>
                            <p class="text-secondary mb-1"><#if candidate.cv.position??>${candidate.cv.position}<#else>Position</#if></p>
                            <p class="text-muted font-size-sm"><#if candidate.cv.city??>${candidate.cv.city}<#else>city</#if></p>
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-primary btn-info btn-sm  has-icon btn-block" type="button">Add to candidates list</button>
                            <button class="btn btn-primary btn-info btn-sm has-icon ml-2"><a href="/users/cv/${candidate.id}" class="text-primary"
                                                                                             data-toggle="tooltip" title=""
                                                                                             data-original-title="view"><i class="far fa-eye"></i></a></button>
                        </div>
                    </div>
                </div>
                </#list>
            </div>
        </div>
    </div>
</@c.page>
