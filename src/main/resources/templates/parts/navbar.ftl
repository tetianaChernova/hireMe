<#include "security.ftl">
<#import "login.ftl" as l>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/">HireMe</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <#if isRecruiter>
                <li class="nav-item active">
                    <a class="nav-link" href="/users">Posts</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/candidate-list">Candidate list</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/users/recommendations">Recommendations</a>
                </li>
            </#if>
            <#if user?? && !isRecruiter>
                <li class="nav-item active">
                    <a class="nav-link" href="/users/cv">My CV</a>
                </li>
            </#if>
        </ul>
        <div class="navbar-text mr-3"><#if user??>${name}<#else>Please, login</#if></div>
        <@l.logout/>
    </div>
</nav>
