<#import "parts/common.ftl" as c>
<@c.page "/static/posts.css">
    <div class="container">
        <div class="main-body">
                <#if isRecommendationsPage>
                    <div class="form-group mt-3">
                        <form method="get" action="recommendations">
                            <div class="row">
                                <input type="text" name="filter" class="form-control" value="${filter!}"
                                       placeholder="Search recommendations by main technology"/>
                                <button type="submit" style="visibility: hidden;"
                                        class="btn btn-info btn-primary">Search
                                </button>
                            </div>
                        </form>
                    </div>
                </#if>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 gutters-sm">
                <#list candidates as candidate>
                    <div class="col mb-3">
                        <div class="card">
                            <img src="https://www.htmlcsscolor.com/preview/gallery/CCCCFF.png" alt="Cover"
                                 class="card-img-top">
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
                                <p class="text-secondary mb-1">Main technology: <#if candidate.cv.mainTechnology??>${candidate.cv.mainTechnology}<#else> </#if></p>
                                <p class="text-muted font-size-sm"><#if candidate.cv.city??>${candidate.cv.city}<#else>city</#if></p>
                            </div>
                            <div class="card-footer">
                                <button class="btn btn-primary btn-info btn-sm  has-icon btn-block"
                                        type="button"
                                        onClick="addToLikedList(${candidate.id})"
                                        <#if likedCandidates?seq_contains(candidate.username)>
                                            style="background-color: darkseagreen"
                                            disabled
                                        </#if>
                                        id="addToLikedList${candidate.id}">
                                    <#if likedCandidates?seq_contains(candidate.username)>Added to Liked list
                                    <#else>Add to candidates list
                                    </#if>
                                </button>
                                <button class="btn btn-primary btn-info btn-sm has-icon ml-2"><a
                                            href="/users/cv/${candidate.id}" class="text-primary"
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

<script>
    $(function () {
        addToLikedList = function (candidateId) {
            $.ajax({
                type: "POST",
                url: "/users/cv/" + candidateId + "/like",
                data: {
                    '_csrf': "${_csrf.token}"
                },
                success: function (result) {
                    console.log('#addToLikedList' + candidateId)
                    $('#addToLikedList' + candidateId).text('Added to Liked list').css("background-color", "darkseagreen").attr('disabled', true);
                },
                error: function (result) {
                    alert("Can't add user to liked list");
                }
            });
        };
    });
</script>
