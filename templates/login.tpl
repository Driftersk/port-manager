{extends "base.tpl"}

{block "head"}
    {assign "show_menu" "false"}
    <link rel="stylesheet" href="{$root_prefix|default:""}css/login.css">
{/block}

{block "body"}
    <div id="wrapper">
        <div class="v-align">
            <header>
                <h1>Port forwarder</h1>
            </header>

            {if $error}
                <div id="error">
                    {$error}
                </div>
            {/if}

            <form method="post" name="login">
                <fieldset>
                    <input type="password" name="password" id="password" value="" placeholder="Password"
                           autocomplete="on" autocapitalize="off" autocorrect="off" required="">
                    <label for="password" class="infield">Password</label>
                    <input type="submit" id="submit" class="login primary icon-confirm svg" title="Log in" value="">
                </fieldset>
            </form>
        </div>
    </div>
    <div class="cleaner"></div>
{/block}