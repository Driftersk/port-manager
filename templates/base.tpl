<!DOCTYPE html>
<html lang="sk">
<head>
    <meta charset="utf-8">
    <title>{$pageTitle|default:"Web port forwarder"}</title>
    <meta name="description" content="A simple port forwarder for Microtik routers.">
    <meta name="author" content="Drifter">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- IE6-8 support of HTML5 elements & media queries --> <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
    <script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js" type="text/javascript"></script>
    <![endif]-->

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js" type="text/javascript"></script>
    <!-- offline backup version of jquery 2.1.3 -->
    <script>
        if (!window.jQuery) { document.write('<script src="{$root_prefix|default:""}scripts/jquery.min.js"><\/script>'); }
    </script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js" type="text/javascript"></script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

    <link rel="apple-touch-icon" sizes="57x57" href="{$root_prefix|default:""}imgs/favicon/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="{$root_prefix|default:""}imgs/favicon/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="{$root_prefix|default:""}imgs/favicon/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="{$root_prefix|default:""}imgs/favicon/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="{$root_prefix|default:""}imgs/favicon/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="{$root_prefix|default:""}imgs/favicon/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="{$root_prefix|default:""}imgs/favicon/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="{$root_prefix|default:""}imgs/favicon/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="{$root_prefix|default:""}imgs/favicon/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192"  href="{$root_prefix|default:""}imgs/favicon/android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32" href="{$root_prefix|default:""}imgs/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="{$root_prefix|default:""}imgs/favicon/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="{$root_prefix|default:""}imgs/favicon/favicon-16x16.png">
    <link rel="manifest" href="{$root_prefix|default:""}imgs/favicon/manifest.json">

    <link rel="stylesheet" href="{$root_prefix|default:""}css/style.css">

    {block "head"}
        <!-- End of the head. -->
    {/block}
</head>
<body lang="en">
    {if $show_menu != "false"}
        <nav id="main-menu">
                <ul>
                    <li>Port Forwarder Home</li>
                    <li>{if $logged}You are logged in.{else}You are not logged in.{/if}</li>
                    <li style="text-align: right;"><a style="margin-right: .5em;" href="/logout">Log out</a></li>
                </ul>
        </nav>
    {/if}

    <section style="width: 100%; height: 100%;">
        {block "body"}

        {/block}
    </section>

</body>
</html>