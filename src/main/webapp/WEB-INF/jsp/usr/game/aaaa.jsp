<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API TEST4"></c:set>
<%@ include file="../common/head.jspf"%>
<link rel="stylesheet" href="/resource/background.css" />

<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0 , maximum-scale=1.0, user-scalable=no" />
        <link rel="canonical" href="https://kovo.co.kr" />
        <!-- <title>KOVO 한국배구연맹</title>
        <link rel="icon" type="image/svg+xml" href="https://www.kovo.co.kr/images/img/favicon.ico" /> -->
        <!-- Google tag (gtag.js) -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=G-K8YCSXNEPF"></script>
        <script>
            var isDev = window.location.host !== 'kovo.co.kr';

            function robots() {
                if (isDev) {
                    let meta = document.createElement('meta');
                    meta.name = 'robots';
                    meta.content = 'noindex,nofollow';
                    // metaTag.setAttribute('name', 'robots');
                    // metaTag.setAttribute('content', 'noindex,nofollow');

                    var headElement = document.head || document.getElementsByTagName('head')[0];

                    // Append the meta element to the head
                    headElement.appendChild(meta);

                    // Optional: Log to console for verification
                    console.log('Dynamic meta tag added:', meta);
                }
            }
            robots();
        </script>
        <script>
            window.dataLayer = window.dataLayer || [];
            function gtag() {
                dataLayer.push(arguments);
            }
            gtag('js', new Date());

            gtag('config', 'G-K8YCSXNEPF');
        </script>
      <script type="module" crossorigin src="/assets/index.a36d0da1.js"></script>
      <link rel="stylesheet" href="/assets/index.43189abb.css">
    </head>
    <body>
        <div id="root"></div>
        
    </body>
</html>

<%@ include file="../common/foot.jspf"%>