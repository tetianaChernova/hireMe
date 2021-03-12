<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<@c.page "/static/forms.css">
    <#if message??>
        <div class="alert alert-${messageType}" role="alert">
            ${message}
        </div>
    </#if>
    <@l.login "/login" false/>
</@c.page>
