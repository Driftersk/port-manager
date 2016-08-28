{extends "base.tpl"}

{block "head"}
    {assign "show_menu" "true"}
    <!--suppress HtmlUnknownTarget -->
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="{$root_prefix|default:""}css/maintenance.css">
{literal}
    <script>
        /* Hide all menus when clicked elsewhere */
        $(document).mouseup(function (e) {
            var container = $(".moreoptionsmenu");

            if (!container.is(e.target) // if the target of the click isn't the container...
                    && container.has(e.target).length === 0) // ... nor a descendant of the container
            {
                container.hide();
                $(".moreoptionsimage").removeClass("shown");
            }
        });
        /* Clicked more options menu*/
        $(document).ready(function () {
            $(".moreoptionsimage").on("click", function () {
                $(this).addClass("shown");
                var menu = $(this).siblings(".moreoptionsmenu");
                hideMenus(menu);
                menu.toggle();
                /*$(this).parents(".entry").css("border","2px solid red");*/
            });
        });

        /**
         * Hides all menus expect specified
         * @param elem
         */
        function hideMenus(elem) {
            if (elem) {
                $(".moreoptionsmenu").not(elem).hide(); // Hide other opened menus
            } else {
                $(".moreoptionsmenu").hide();
                $(".moreoptionsimage").removeClass("shown");
            }
        }

        /* details button clicked */
        $(document).ready(function () {
            $(".details-dialog").hide();
            $(".details-button").click(function () {
                var details = $(this).siblings(".details-dialog");
                var dialogClone = details.clone();
                dialogClone.dialog();
            });
        });

        /* Add new port rule */
        $(document).ready(function () {
            $("#add-port").click(function () {
                var form = $("#newrule");
                var portType = form.find(".porttype select").val();
                var publicIp = form.find(".publicip input").val();
                var publicPort = form.find(".publicport input").val();
                var privateIp = form.find(".privateip input").val();
                var privatePort = form.find(".privateport input").val();
                var comment = form.find(".comment input").val();

                $.post("ajax/addport.php", {
                    portType: portType,
                    publicIp: publicIp,
                    publicPort: publicPort,
                    privateIp: privateIp,
                    privatePort: privatePort,
                    comment: comment
                }).done(function (data) {
                    var response = JSON.parse(data);
                    if (response.success) {
                        location.reload();
                    } else {
                        console.error("Error creating new NAT rule.");
                    }
                })
            });
        });

        /* Changing entries */
        $(document).ready(function () {
            $(".entry .porttype select").on("change", function () {
                var portComment = $(this).parents(".entry").data("comment");
                var type = $(this).val();
                changePortType(portComment, type)
            });

            $(".entry .publicip input").on("keypress", function (e) {
                if (e.which == $.ui.keyCode.ENTER) {
                    var portComment = $(this).parents(".entry").data("comment");
                    var ip = $(this).val();
                    changePublicIp(portComment, ip);
                }
            });

            $(".entry .publicport input").on("keypress", function (e) {
                if (e.which == $.ui.keyCode.ENTER) {
                    var portComment = $(this).parents(".entry").data("comment");
                    var port = $(this).val();
                    changePublicPort(portComment, port);
                }
            });

            $(".entry .privateip input").on("keypress", function (e) {
                if (e.which == $.ui.keyCode.ENTER) {
                    var portComment = $(this).parents(".entry").data("comment");
                    var ip = $(this).val();
                    changePrivateIp(portComment, ip);
                }
            });

            $(".entry .privateport input").on("keypress", function (e) {
                if (e.which == $.ui.keyCode.ENTER) {
                    var portComment = $(this).parents(".entry").data("comment");
                    var port = $(this).val();
                    changePrivatePort(portComment, port);
                }
            });

            $(".entry .comment input").on("keypress", function (e) {
                if (e.which == $.ui.keyCode.ENTER) {
                    var portComment = $(this).parents(".entry").data("comment");
                    var comment = $(this).val();
                    changeComment(portComment, comment);
                }
            });
        });

        function enablePort(portComment) {
            $.post("ajax/enableport.php", {comment: portComment}).done(function (data) {
                var response = JSON.parse(data);
                hideMenus();
                if (response.success) {
                    $("#port-" + portComment.replace(/ /g, '_')).addClass('enabled').removeClass('disabled');
                }
            });
        }

        function disablePort(portComment) {
            $.post("ajax/disableport.php", {comment: portComment}).done(function (data) {
                var response = JSON.parse(data);
                hideMenus();
                if (response.success) {
                    $("#port-" + portComment.replace(/ /g, '_')).addClass('disabled').removeClass('enabled');
                }
            });
        }

        function removePort(portComment) {
            $.post("ajax/removeport.php", {comment: portComment}).done(function (data) {
                var response = JSON.parse(data);
                hideMenus();
                if (response.success) {
                    $("#port-" + portComment.replace(/ /g, '_')).remove();
                }
            });
        }

        function changePortType(portComment, type) {
            var entry = $("#port-" + portComment.replace(/ /g, '_'));
            entry.css({border: "2px solid blue"});
            $.post("ajax/changeporttype.php", {comment: portComment, portType: type}).done(function (data) {
                var response = JSON.parse(data);
                if (response.success) {
                    entry.css({border: "2px solid green"});
                    setTimeout(function () {
                        entry.css({border: "2px solid transparent"});
                    }, 800);
                } else {
                    entry.css({border: "2px solid red"});
                }
            });
        }

        function changePublicIp(portComment, ip) {
            var entry = $("#port-" + portComment.replace(/ /g, '_'));
            entry.css({border: "2px solid blue"});
            $.post("ajax/changepublicip.php", {comment: portComment, ip: ip}).done(function (data) {
                var response = JSON.parse(data);
                if (response.success) {
                    entry.css({border: "2px solid green"});
                    setTimeout(function () {
                        entry.css({border: "2px solid transparent"});
                    }, 800);
                } else {
                    entry.css({border: "2px solid red"});
                }
            });
        }

        function changePublicPort(portComment, port) {
            var entry = $("#port-" + portComment.replace(/ /g, '_'));
            entry.css({border: "2px solid blue"});
            $.post("ajax/changepublicport.php", {comment: portComment, port: port}).done(function (data) {
                var response = JSON.parse(data);
                if (response.success) {
                    entry.css({border: "2px solid green"});
                    setTimeout(function () {
                        entry.css({border: "2px solid transparent"});
                    }, 800);
                } else {
                    entry.css({border: "2px solid red"});
                }
            });
        }

        function changePrivateIp(portComment, ip) {
            var entry = $("#port-" + portComment.replace(/ /g, '_'));
            entry.css({border: "2px solid blue"});
            $.post("ajax/changeprivateip.php", {comment: portComment, ip: ip}).done(function (data) {
                var response = JSON.parse(data);
                if (response.success) {
                    entry.css({border: "2px solid green"});
                    setTimeout(function () {
                        entry.css({border: "2px solid transparent"});
                    }, 800);
                } else {
                    entry.css({border: "2px solid red"});
                }
            });
        }

        function changePrivatePort(portComment, port) {
            var entry = $("#port-" + portComment.replace(/ /g, '_'));
            entry.css({border: "2px solid blue"});
            $.post("ajax/changeprivateport.php", {comment: portComment, port: port}).done(function (data) {
                var response = JSON.parse(data);
                if (response.success) {
                    entry.css({border: "2px solid green"});
                    setTimeout(function () {
                        entry.css({border: "2px solid transparent"});
                    }, 800);
                } else {
                    entry.css({border: "2px solid red"});
                }
            });
        }

        function changeComment(portComment, comment) {
            var entry = $("#port-" + portComment.replace(/ /g, '_'));
            entry.css({border: "2px solid blue"});
            $.post("ajax/changecomment.php", {comment: portComment, newComment: comment}).done(function (data) {
                var response = JSON.parse(data);
                if (response.success) {
                    entry.css({border: "2px solid green"});
                    var newCommentUnderScored = "port-" + comment.replace(/ /g, '_');
                    entry.attr("id", newCommentUnderScored);
                    entry.data("comment", comment);
                    setTimeout(function () {
                        entry.css({border: "2px solid transparent"});
                    }, 800);
                } else {
                    entry.css({border: "2px solid red"});
                }
            });
        }
    </script>
{/literal}
{/block}

{block "body"}
    <h1>Ports below:</h1>
    <div class="portslisting">
        <div class="entry">
            <div class="more">
            </div>

            <div class="porttype">
                <span>Type</span>
            </div>

            <div class="publicip">
                <span>Public IP</span>
            </div>
            <div class="doubledot">
                <span>:</span>
            </div>
            <div class="publicport">
                <span>Port</span>
            </div>

            <div class="middle">
                <span><----></span>
            </div>

            <div class="privateip">
                <span>Private IP</span>
            </div>
            <div class="doubledot">
                <span>:</span>
            </div>
            <div class="privateport">
                <span>Port</span>
            </div>

            <div class="comment">
                <span>Comment</span>
            </div>
        </div>
        <div class="cf"></div>

        {* start of listing *}
        {assign "i" 0}
        {foreach from=$ports item=port}
            {$i=$i+1}
            <div data-comment="{$port['comment']}"
                 id="port-{$port['comment']|replace:' ':'_'}"
                 class="entry {if $i is even}even{else}odd{/if} {if $port['disabled'] eq "true"}disabled{else}enabled{/if}">
                <div class="more">
                    <div class="moreoptionsimage"></div>
                    <!--<img src="imgs/more.png" class="moreoptionsimage">-->
                    <div class="moreoptionsmenu" style="display: none; position: absolute">
                        <ul>
                            <li>
                                <button onclick="enablePort('{$port['comment']}')">Enable</button>
                            </li>
                            <li>
                                <button onclick="disablePort('{$port['comment']}')">Disable</button>
                            </li>
                            <li>
                                <button onclick="removePort('{$port['comment']}')">Remove</button>
                            </li>
                            <li>
                                <button class="details-button">Details</button>
                                <div class="details-dialog" title="Details">
                                    <p>{$port['details']|@var_dump}</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="porttype">
                    <select title="Port type">

                        {if $port['protocol'] eq "tcp"}
                            <option value="tcp" selected>TCP</option>
                            <option value="udp">UDP</option>
                        {elseif $port['protocol'] eq "udp"}
                            <option value="tcp">TCP</option>
                            <option value="udp" selected>UDP</option>
                        {else}
                            <option value="{$port['protocol']}" selected>{$port['protocol']}</option>
                        {/if}
                    </select>
                </div>

                <div class="publicip">
                    <input type="text" value="{$port['dst-address']}" name="publicip" size="12" maxlength="15"
                           {literal}pattern="[0-9]{1,3}.[0-9]{1,3}[0-9]{1,3}.[0-9]{1,3}"{/literal} title="Public ip">
                </div>
                <div class="doubledot">
                    <span>:</span>
                </div>
                <div class="publicport">
                    <input type="text" value="{$port['dst-port']}" name="publicport" size="5" style="width: 90%"
                           title="Public port">
                </div>

                <div class="middle">
                    <span><----></span>
                </div>

                <div class="privateip">
                    <input type="text" value="{$port['to-addresses']}" name="privateip" size="12" maxlength="15"
                           {literal}pattern="[0-9]{1,3}.[0-9]{1,3}[0-9]{1,3}.[0-9]{1,3}"{/literal} title="Private ip">
                </div>
                <div class="doubledot">
                    <span>:</span>
                </div>
                <div class="privateport">
                    <input type="text" value="{$port['to-ports']}" name="privateport" size="5" style="width: 90%"
                           title="Private port">
                </div>

                <div class="comment">
                    <input type="text" value="{$port['comment']}" style="width: 90%" name="comment" title="Comment">
                </div>
            </div>
        {/foreach}
    </div>
    <h1>Add new rule</h1>
    <div class="addnew">
        <div id="newrule">
            <div class="porttype">
                <select title="Port type">
                    <option value="tcp" selected>TCP</option>
                    <option value="udp">UDP</option>
                </select>
            </div>

            <div class="publicip">
                {literal}
                    <input type="text" value="192.168.100.2" name="publicip" size="12" maxlength="15"
                           pattern="[0-9]{1,3}.[0-9]{1,3}[0-9]{1,3}.[0-9]{1,3}" title="Public ip">
                {/literal}
                <!--<span>950.105.135.179</span>-->
            </div>
            <div class="doubledot">
                <span>:</span>
            </div>
            <div class="publicport">
                <input type="number" value="8000" name="publicport" min="1" max="65535" size="5" style="width: 90%"
                       maxlength="5" title="Public port">
                <!--<span>8000</span>-->
            </div>

            <div class="middle">
                <span><----></span>
            </div>

            <div class="privateip">
                {literal}
                    <input type="text" value="192.168.0.103" name="privateip" size="12" maxlength="15"
                           pattern="[0-9]{1,3}.[0-9]{1,3}[0-9]{1,3}.[0-9]{1,3}" title="Private ip">
                {/literal}
            </div>
            <div class="doubledot">
                <span>:</span>
            </div>
            <div class="privateport">
                <input type="number" value="8000" name="privateport" min="1" max="65535" size="5" style="width: 90%"
                       maxlength="5" title="Private port">
            </div>

            <div class="comment">
                <input type="text" value="Comment here." style="width: 90%" name="comment" title="Comment">
            </div>
        </div>
        <div class="add">
            <button id="add-port">Add!</button>
        </div>
    </div>
{/block}