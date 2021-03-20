<#import "parts/common.ftl" as c>
<@c.page "/static/profile.css">
    <div class="card-columns mt-1">
        <#list users as usr>
            <div class="card my-3">
                <#if usr.filename??>
                    <img src="/img/${usr.filename}" class="card-img-top">
                </#if>
                <div class="m-2 card-text">
                    <p style=" max-height: 130px; overflow-y: scroll; margin-bottom: -1rem"><#if usr.cv.title??>usr.cv.title<#else> Title</#if></p><br/>
                </div>
                <div class="card-footer text-muted container">
                    <div class="row">
<#--                        <a class="col align-self-center"-->
<#--                           href="/user-messages/${message.author.username}">${message.authorName}</a>-->
<#--                        <a class="col align-self-center" href="/messages/${message.id}/like">-->
<#--                            <#if message.meLiked>-->
<#--                                <i class="fas fa-heart"></i>-->
<#--                            <#else>-->
<#--                                <i class="far fa-heart"></i>-->
<#--                            </#if>-->
<#--                            ${message.likes}-->
<#--                        </a>-->
<#--                        <#if message.author.id == currentUserId>-->
<#--                            <a class="col btn btn-info btn-primary"-->
<#--                               href="/user-messages/${message.author.username}/${message.id}/edit">Edit</a>-->
<#--                        </#if>-->
                    </div>
                </div>
            </div>
        <#else>
        </#list>
    </div>
</@c.page>
