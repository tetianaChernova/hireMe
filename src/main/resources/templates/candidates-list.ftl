<#import "parts/common.ftl" as c>
<@c.page "/static/candidates.css">
    <div class="container mt-3 mb-4">
        <div>
            <div class="row">
                <div class="col-md-12">
                    <div class="candidate-dashboard-info-box table-responsive mb-0 bg-white p-4 shadow-sm">
                        <table class="table manage-candidates-top mb-0">
                            <thead>
                            <tr>
                                <th>Candidate Name</th>
                                <th class="text-center">Status</th>
                                <th class="action text-right">Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#list candidates as candidate>
                                <tr class="candidates-list" id="${candidate.id}">
                                    <td class="title">
                                        <div class="row">
                                            <div class="thumb">
                                                <#if candidate??>
                                                    <#if candidate.filename??>
                                                        <img src="/img/${candidate.filename}" alt="Circle Image"
                                                             class="img-fluid"
                                                             style="width: 70px;height: 70px;">
                                                    <#else>
                                                        <img class="img-fluid"
                                                             src="https://bootdey.com/img/Content/avatar/avatar7.png"
                                                             alt=""
                                                             style="width: 70px;height: 70px;">
                                                    </#if>
                                                </#if>

                                            </div>
                                            <div class="candidate-list-details" style="margin-left: 2rem">
                                                <div class="candidate-list-info">
                                                    <div class="candidate-list-title">
                                                        <h5 class="mb-0"><a
                                                                    href="/users/cv/${candidate.id}"><#if candidate.cv.firstName??>${candidate.cv.firstName}<#else>First name</#if> <#if candidate.cv.lastName??>${candidate.cv.lastName}<#else>Last name</#if></a>
                                                        </h5>
                                                    </div>
                                                    <#--                                                <div class="candidate-list-title">-->
                                                    <#--                                                    <h5 class="mb-0"><a href="#"><#if candidate.cv.title??>${candidate.cv.title}<#else>Title</#if></a></h5>-->
                                                    <#--                                                </div>-->
                                                    <div class="candidate-list-option">
                                                        <ul class="list-unstyled">
                                                            <li>
                                                                <i class="fas fa-filter pr-1"></i><#if candidate.cv.position??>${candidate.cv.position}<#else>Title</#if>
                                                            </li>
                                                            <li>
                                                                <i class="fas fa-filter pr-1"></i><#if candidate.cv.experience??>${candidate.cv.experience} <#else> ? </#if>
                                                                years of experience
                                                            </li>
                                                            <li>
                                                                <i class="fas fa-map-marker-alt pr-1"></i><#if candidate.cv.city??>${candidate.cv.city}<#else> </#if>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="candidate-list-favourite-time text-center">
                                        <a class="candidate-list-favourite order-2 text-danger" href="#"><i
                                                    class="fas fa-heart"></i></a>
                                        <span class="candidate-list-time order-1">Shortlisted</span>
                                    </td>
                                    <td>
                                        <ul class="list-unstyled mb-0 d-flex justify-content-end">
                                            <li><a href="/users/cv/${candidate.id}" class="text-primary"
                                                   data-toggle="tooltip" title=""
                                                   data-original-title="view"><i class="far fa-eye"></i></a></li>
                                            <li><a onclick="deleteCandidateFromList(${candidate.id})"
                                                   class="text-danger" data-toggle="tooltip" title=""
                                                   style="margin-left: 1rem"
                                                   data-original-title="Delete"><i class="far fa-trash-alt"></i></a>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            <#else>
                            </#list>
                            </tbody>
                        </table>
                        <#--                        <div class="text-center mt-3 mt-sm-3">-->
                        <#--                            <ul class="pagination justify-content-center mb-0">-->
                        <#--                                <li class="page-item disabled"> <span class="page-link">Prev</span> </li>-->
                        <#--                                <li class="page-item active" aria-current="page"><span class="page-link">1 </span> <span class="sr-only">(current)</span></li>-->
                        <#--                                <li class="page-item"><a class="page-link" href="#">2</a></li>-->
                        <#--                                <li class="page-item"><a class="page-link" href="#">3</a></li>-->
                        <#--                                <li class="page-item"><a class="page-link" href="#">...</a></li>-->
                        <#--                                <li class="page-item"><a class="page-link" href="#">25</a></li>-->
                        <#--                                <li class="page-item"> <a class="page-link" href="#">Next</a> </li>-->
                        <#--                            </ul>-->
                        <#--                        </div>-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</@c.page>

<script>
    $(function () {
        deleteCandidateFromList = function (candidateId) {
            // e.preventDefault();
            $.ajax({
                type: "DELETE",
                url: "/users/cv/" + candidateId,
                data: {
                    '_csrf': "${_csrf.token}"
                },
                success: function (result) {
                    console.log('#' + candidateId)
                    $('#' + candidateId).remove();
                },
                error: function (result) {
                    alert("Can't remove user from liked list");
                }
            });
        };
    });
</script>
