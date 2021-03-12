<#assign
know = Session.SPRING_SECURITY_CONTEXT??
>
<#if know>
    <#assign
    user = Session.SPRING_SECURITY_CONTEXT.authentication.principal
    name = user.getUsername()
    isRecruiter = user.isRecruiter()
    currentUserId = user.getId()
    currentUsername = user.getUsername()
    >
<#else>
    <#assign
    name = "unknown"
    isRecruiter = false
    currentUserId = -1
    >
</#if>
