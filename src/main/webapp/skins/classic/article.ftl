<#include "macro-head.ftl">
<#include "macro-pagination.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${article.articleTitle} - ${symphonyLabel}">
        <meta name="keywords" content="${article.articleTags}"/>
        <meta name="description" content="${article.articleTitle}"/>
        </@head>
        <link type="text/css" rel="stylesheet" href="/js/lib/google-code-prettify/prettify.css?${staticResourceVersion}">
        <link type="text/css" rel="stylesheet" href="/css/index${miniPostfix}.css?${staticResourceVersion}" />
    </head>
    <body>
        <#include "header.ftl">
        <div class="main">
            <div class="wrapper fn-clear">
                <div class="content">
                    <div>
                        <div class="ft-small fn-clear article-info">
                            <div class="fn-left">
                                <span class="icon icon-tags"></span>
                                <#list article.articleTags?split(",") as articleTag>
                                <a rel="tag" href="/tags/${articleTag?url('UTF-8')}">
                                    ${articleTag}</a><#if articleTag_has_next>, </#if>
                                </#list>
                            </div>
                            <div class="fn-right">
                                <span class="icon icon-date"></span>
                                ${article.articleCreateTime?string('yyyy-MM-dd HH:mm')} &nbsp;
                                <a title="${cmtLabel}" rel="nofollow" href="#comments">
                                    <span class="icon icon-cmts"></span>
                                    ${article.articleCommentCount}
                                </a> &nbsp;
                                <a title="${viewLabel}" rel="nofollow" href="#"> 
                                    <span class="icon icon-view"></span>
                                    ${article.articleViewCount}
                                </a>
                                <#if article.isMyArticle>
                                &nbsp;
                                <a href="${servePath}/update-article?id=${article.oId}" title="${editLabel}">
                                    <span class="icon icon-edit"></span>
                                </a>
                                </#if>
                                <#if isAdminLoggedIn>
                                &nbsp;
                                <a href="${servePath}/admin/article/${article.oId}" title="${adminLabel}">
                                    <span class="icon icon-setting"></span>
                                </a>
                                </#if>
                            </div>
                        </div>
                        <div class="fn-clear">
                            <h2 class="article-title fn-inline">
                                <a href="${article.articlePermalink}" rel="bookmark">
                                    ${article.articleTitleEmoj}
                                </a>
                            </h2> 
                            <#if isLoggedIn> 
                            &nbsp;
                            <#if isFollowing>
                            <button class="red small" onclick="Util.unfollow(this, '${article.oId}', 'article')"> 
                                ${unfollowLabel}
                            </button>
                            <#else>
                            <button class="green small" onclick="Util.follow(this, '${article.oId}', 'article')"> 
                                ${followLabel}
                            </button>
                            </#if>
                            </#if>
                        </div>
                        <div class="content-reset">
                            ${article.articleContent}
                        </div>
                        <div class="fn-clear">
                            <div class="share fn-right">
                                <span class="icon icon-tencent" data-type="tencent"></span>
                                <span class="icon icon-weibo" data-type="weibo"></span>
                                <span class="icon icon-twitter" data-type="twitter"></span>
                                <span class="icon icon-google" data-type="google"></span>
                            </div>    
                        </div>
                    </div>
                    <div class="fn-clear">
                        <div class="list" id="comments">
                            <h2>${article.articleCommentCount} ${cmtLabel}</h2>
                            <ul>
                                <#list article.articleComments as comment>
                                <li id="${comment.oId}">
                                    <div class="fn-clear">
                                        <div class="fn-left">
                                            <img class="avatar" 
                                                 title="${comment.commentAuthorName}" src="${comment.commentAuthorThumbnailURL}" />
                                        </div>
                                        <div class="fn-left comment-content">
                                            <div class="fn-clear comment-info">
                                                <span class="fn-left">
                                                    <a rel="nofollow" href="/member/${comment.commentAuthorName}"
                                                       title="${comment.commentAuthorName}">${comment.commentAuthorName}</a>
                                                    &nbsp;<span class="icon icon-date ft-small"></span>
                                                    <span class="ft-small">${comment.commentCreateTime?string('yyyy-MM-dd HH:mm')}</span> 
                                                </span>
                                                <span class="fn-right">
                                                    <#if isLoggedIn> 
                                                    <span class="icon icon-cmt" onclick="Comment.replay('@${comment.commentAuthorName} ')"></span>
                                                    </#if>
                                                    <i>#${(paginationCurrentPageNum - 1) * articleCommentsPageSize + comment_index + 1}</i>
                                                </span>    
                                            </div>
                                            <div class="content-reset comment">
                                                ${comment.commentContent}
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                </#list>  
                            </ul>
                        </div>
                        <@pagination url=article.articlePermalink/>
                    </div>
                    <#if isLoggedIn>
                    <div class="form fn-clear">
                        <textarea id="commentContent" rows="3"></textarea>
                        <span style="bottom: 4px; right: 75px;"></span>
                        <a href="javascript:void(0)" onclick="$('.grammar').slideToggle()">${baseGrammarLabel}</a>
                        <a target="_blank" href="http://daringfireball.net/projects/markdown/syntax">${allGrammarLabel}</a>
                        <div class="fn-right">
                            <button class="green fn-none" onclick="Comment.preview()">预览</button> &nbsp; &nbsp; 
                            <button class="red" onclick="Comment.add('${article.oId}')">${submitLabel}</button>
                        </div>
                    </div>
                    <div class="grammar fn-none">
                        ${markdwonGrammarLabel}
                    </div>
                    <#else>
                    <div class="comment-login">
                        <a rel="nofollow" href="javascript:window.scrollTo(0,0);Util.showLogin();">${pleaseLoginLabel}</a>
                    </div>
                    </#if>
                </div>
                <div class="side">
                    <div class="module">
                        <div class="module-header ad">
                            <div class="fn-clear">
                                <div class="fn-left">
                                    <img class="avatar" src="${article.articleAuthorThumbnailURL}" />
                                </div>
                                <div class="fn-left">
                                    <a rel="author" href="/member/${article.articleAuthorName}" 
                                       title="${article.articleAuthorName}">${article.articleAuthorName}</a>
                                    <#if article.articleAuthorURL!="">
                                    <br/>
                                    <a target="_blank" rel="nofollow" href="${article.articleAuthorURL}">${article.articleAuthorURL}</a>
                                    </#if>
                                </div>
                            </div>
                            <div>
                                ${article.articleAuthorIntro}
                            </div>
                        </div> 
                    </div>

                    <div class="module">
                        <div class="module-header">
                            <h2>
                                ${relativeArticleLabel}
                            </h2>
                        </div>
                        <div class="module-panel">
                            <ul class="module-list">
                                <#list sideRelevantArticles as relevantArticle>
                                <li<#if !relevantArticle_has_next> class="last"</#if>>
                                    <a rel="nofollow" href="${relevantArticle.articlePermalink}">${relevantArticle.articleTitle}</a>
                                    <a class="ft-small" rel="nofollow" 
                                       href="/member/${relevantArticle.articleAuthorName}">${relevantArticle.articleAuthorName}</a>
                                </li>
                                </#list>
                            </ul>
                        </div>
                    </div>

                    <div class="module">
                        <div class="module-header">
                            <h2>
                                ${randomArticleLabel}
                            </h2>
                        </div>
                        <div class="module-panel">
                            <ul class="module-list">
                                <#list sideRandomArticles as randomArticle>
                                <li<#if !randomArticle_has_next> class="last"</#if>>
                                    <a rel="nofollow" href="${randomArticle.articlePermalink}">${randomArticle.articleTitle}</a>
                                    <a class="ft-small" rel="nofollow"
                                       href="/member/${randomArticle.articleAuthorName}">${randomArticle.articleAuthorName}</a>
                                </li>
                                </#list>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <#include "footer.ftl">
        <div id="preview" class="content-reset"></div>
        <script>
            Label.commentErrorLabel = "${commentErrorLabel}";
            Label.symphonyLabel = "${symphonyLabel}";
            Label.articleOId = "${article.oId}";
            Label.articleTitle = "${article.articleTitle}";
            Label.articlePermalink = "${article.articlePermalink}";
        </script>
        <script src="${staticServePath}/js/lib/jquery/jquery.bowknot.min.js?${staticResourceVersion}"></script>
        <script type="text/javascript" src="${staticServePath}/js/lib/google-code-prettify/prettify.js?${staticResourceVersion}"></script>
        <script type="text/javascript" src="${staticServePath}/js/article${miniPostfix}.js?${staticResourceVersion}"></script>
    </body>
</html>
