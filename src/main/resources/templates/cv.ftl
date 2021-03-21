<#import "parts/common.ftl" as c>
<@c.page "/static/profile.css">
    <div class="profile-page">
        <div class="main main-raised" style="margin-top: 4rem!important;">
            <div class="profile-content">
                <div>
                    <div class="row flex-lg-nowrap">
                        <div class="col">
                            <div class="row">
                                <div class="col mb-3">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="e-profile">
                                                <div class="row">
                                                    <div class="col-12 col-sm-auto mb-3">
                                                        <div class="mx-auto" style="width: 140px;">
                                                            <#if user??>
                                                                <#if user.filename??>
                                                                    <img src="/img/${user.filename}" alt="Circle Image"
                                                                         class="img-raised rounded-circle img-fluid"
                                                                         style="width: 140px;height: 140px;">
                                                                <#else>
                                                                    <div class="d-flex justify-content-center align-items-center rounded"
                                                                         style="height: 140px; background-color: rgb(233, 236, 239);">
                                                                        <span style="color: rgb(166, 168, 170); font: bold 8pt Arial;">140x140</span>
                                                                    </div>
                                                                </#if>
                                                            </#if>
                                                        </div>
                                                    </div>
                                                    <div class="col d-flex flex-column flex-sm-row justify-content-between mb-3">
                                                        <div class="text-center text-sm-left mb-2 mb-sm-0">
                                                            <h4 class="pt-sm-2 pb-1 mb-0 text-nowrap"><#if user.cv.firstName??>${user.cv.firstName}<#else>First name</#if> <#if user.cv.lastName??>${user.cv.lastName}<#else>Last name</#if></h4>
                                                            <p class="mb-0"><#if user.username??>${user.username}<#else>@username</#if></p>
                                                            <h4 class="pt-sm-2 pb-1 mb-0 text-nowrap"><#if user.cv.title??>${user.cv.title}<#else>Title</#if></h4>
                                                        </div>
                                                        <#--                                                        <div class="mt-2">-->
                                                        <#--                                                            <button class="btn btn-primary" type="button">-->
                                                        <#--                                                                <i class="fa fa-fw fa-camera"></i>-->
                                                        <#--                                                                <span>Change Photo</span>-->
                                                        <#--                                                            </button>-->
                                                        <#--                                                        </div>-->
                                                    </div>
                                                    <div class="text-center text-sm-right">
                                                        <span class="badge badge-secondary"><#if user.roles??>${user.roles[0]}<#else>user</#if></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <ul class="nav nav-tabs">
                                            <li class="nav-item"><a href="" class="active nav-link">Profile
                                                    information</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content pt-3" style="margin: 1rem!important;">
                                            <div class="tab-pane active">
                                                <form class="form" novalidate="" action="/users/cv/edit" method="post"
                                                      id="editForm" enctype="multipart/form-data">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="row">
                                                                <div class="col">
                                                                    <div class="form-group">
                                                                        <label>First Name</label>
                                                                        <input class="form-control" type="text"
                                                                               name="firstName"
                                                                               placeholder="<#if user.cv.firstName??>${user.cv.firstName}<#else>First name</#if>"
                                                                               value="<#if user.cv.firstName??>${user.cv.firstName}<#else>First name</#if>">
                                                                    </div>
                                                                </div>
                                                                <div class="col">
                                                                    <div class="form-group">
                                                                        <label>Last Name</label>
                                                                        <input class="form-control" type="text"
                                                                               name="lastName"
                                                                               placeholder="<#if user.cv.lastName??>${user.cv.lastName}<#else>Last name</#if>"
                                                                               value="<#if user.cv.lastName??>${user.cv.lastName}<#else>Last name</#if>">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Position </label>
                                                                <input class="form-control" type="text"
                                                                       name="position"
                                                                       placeholder="<#if user.cv.position??>${user.cv.position}<#else> </#if>"
                                                                       value="<#if user.cv.position??>${user.cv.position}<#else> </#if>">
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Years of experience </label>
                                                                <input class="form-control" type="text"
                                                                       name="experience"
                                                                       placeholder="<#if user.cv.experience??>${user.cv.experience}<#else> </#if>"
                                                                       value="<#if user.cv.experience??>${user.cv.experience}<#else> </#if>">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Title </label>
                                                                <input class="form-control" type="text"
                                                                       name="title"
                                                                       placeholder="<#if user.cv.title??>${user.cv.title}<#else> </#if>"
                                                                       value="<#if user.cv.title??>${user.cv.title}<#else> </#if>">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Nationality: </label>
                                                                <input class="form-control" type="text"
                                                                       name="nationality"
                                                                       placeholder=" <p><#if user.cv.nationality??>${user.cv.nationality}<#else> </#if>"
                                                                       value="<#if user.cv.nationality??>${user.cv.nationality}<#else> </#if>">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Currently living in city: </label>
                                                                <input class="form-control" type="text"
                                                                       name="city"
                                                                       placeholder=" <p><#if user.cv.city??>${user.cv.city}<#else> </#if>"
                                                                       value="<#if user.cv.city??>${user.cv.city}<#else> </#if>">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Email</label>
                                                                <input class="form-control" type="text"
                                                                       name="email"
                                                                       placeholder="${user.email}"
                                                                       value="${user.email}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Phone</label>
                                                                <input class="form-control" type="text"
                                                                       name="phone"
                                                                       placeholder="<#if user.cv.phone??>${user.cv.phone}<#else>+380*********</#if>"
                                                                       value="<#if user.cv.phone??>${user.cv.phone}<#else> </#if>">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col mb-3" style="margin: 0rem!important">
                                                            <div class="form-group">
                                                                <label>About</label>
                                                                <textarea class="form-control" rows="5"
                                                                          name="description"
                                                                          placeholder="<#if user.cv.description??>${user.cv.description}<#else>My bio</#if>"><#if user.cv.description??>${user.cv.description}<#else></#if></textarea>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                                    <div class="row form-group">
                                                        <div class="col d-flex justify-content-end">
                                                            <input type="submit" class="btn btn-info btn-primary"
                                                                   value="Save Changes"/>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                        <#--                                        <div class="row">-->
                                        <#--                                            <div class="col-12 col-sm-6 mb-3">-->
                                        <#--                                                <div class="mb-2"><b>Change Password</b></div>-->
                                        <#--                                                <div class="row">-->
                                        <#--                                                    <div class="col">-->
                                        <#--                                                        <div class="form-group">-->
                                        <#--                                                            <label>Current Password</label>-->
                                        <#--                                                            <input class="form-control"-->
                                        <#--                                                                   type="password"-->
                                        <#--                                                                   placeholder="••••••">-->
                                        <#--                                                        </div>-->
                                        <#--                                                    </div>-->
                                        <#--                                                </div>-->
                                        <#--                                                <div class="row">-->
                                        <#--                                                    <div class="col">-->
                                        <#--                                                        <div class="form-group">-->
                                        <#--                                                            <label>New Password</label>-->
                                        <#--                                                            <input class="form-control"-->
                                        <#--                                                                   type="password"-->
                                        <#--                                                                   placeholder="••••••">-->
                                        <#--                                                        </div>-->
                                        <#--                                                    </div>-->
                                        <#--                                                </div>-->
                                        <#--                                                <div class="row">-->
                                        <#--                                                    <div class="col">-->
                                        <#--                                                        <div class="form-group">-->
                                        <#--                                                            <label>Confirm <span-->
                                        <#--                                                                        class="d-none d-xl-inline">Password</span></label>-->
                                        <#--                                                            <input class="form-control"-->
                                        <#--                                                                   type="password"-->
                                        <#--                                                                   placeholder="••••••"></div>-->
                                        <#--                                                    </div>-->
                                        <#--                                                </div>-->
                                        <#--                                            </div>-->
                                        <#--                                        </div>-->
                                        <#--                                        <div class="row">-->
                                        <#--                                            <div class="col d-flex justify-content-end">-->
                                        <#--                                                <button class="btn btn-info btn-primary" type="submit">Save Changes-->
                                        <#--                                                </button>-->
                                        <#--                                            </div>-->
                                        <#--                                        </div>-->



                                        <#--                                        </form>-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
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

<script>
    function updateTextInput(value) {
        console.log("value is: ", value);
        document.getElementById('rangeValueText').innerHTML = value;
    }

    function readURL(input) {
        if (input.files && input.files[0]) {
            let reader = new FileReader();

            reader.onload = function (e) {
                $('#imgSrc').attr('src', e.target.result);
                $('#imgSrcNoPhoto').attr('src', e.target.result);
            };

            reader.readAsDataURL(input.files[0]); // convert to base64 string
        }
    }

    $("#imgInput").change(function () {
        readURL(this);
    });

</script>
