<#include "../macro-head.ftl">
<#include "../macro-pagination.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${userName} - block">
        <meta name="robots" content="none" />
        </@head>
        <link type="text/css" rel="stylesheet" href="/css/home.css" />
    </head>
    <body>
        <#include "../header.ftl">
        <div class="main">
            <div class="wrapper ft-center">
                <h2>${userBlockLabel}</h2>
            </div>
        </div>
    </div>
    <#include "../footer.ftl">
</body>
</html>