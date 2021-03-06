/*
 * Copyright (c) 2012-2015, b3log.org
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * @fileoverview register.
 *
 * @author <a href="http://vanessa.b3log.org">Liyuan Li</a>
 * @author <a href="http://88250.b3log.org">Liang Ding</a>
 * @version 1.0.0.7, Apr 4, 2015
 */

/**
 * @description Register
 * @static
 */
var Register = {
    /**
     * @description 注册
     */
    register: function () {
        if (Validate.goValidate([{
            "id": "userName",
            "msg": Label.userNameErrorLabel,
            "type": 20
        }, {
            "id": "userEmail",
            "msg": Label.invalidEmailLabel,
            "type": "email"
        }, {
            "id": "userPassword",
            "msg": Label.invalidPasswordLabel,
            "type": "password"
        }, {
            "id": "confirmPassword",
            "msg": Label.confirmPwdErrorLabel,
            "type": "confirmPassword|userPassword"
        }, {
            "id": "securityCode",
            "msg": Label.captchaErrorLabel,
            "type": 4
        }])) {
            var requestJSONObject = {
                userName: $("#userName").val().replace(/(^\s*)|(\s*$)/g,""),
                userEmail: $("#userEmail").val().replace(/(^\s*)|(\s*$)/g,""),
                userPassword: calcMD5($("#userPassword").val()),
                captcha: $("#securityCode").val()
            };
            
            $.ajax({
                url: "/register",
                type: "POST",
                cache: false,
                data: JSON.stringify(requestJSONObject),
                success: function(result, textStatus){
                    if (result.sc) {
                        window.location = "http://symphony.b3log.org/article/1360294444788";
                    } else {
                        $("#registerTip").text(result.msg).addClass("tip-error").css("border-left", "1px solid #E2A0A0");
                        $("#captcha").attr("src", "/captcha?code=" + Math.random());
                        $("#securityCode").val("");
                    }
                }
            });
        }
    },
    
    init: function () {
        // 注册回车事件
        $("#securityCode").keyup(function (event) {
            if (event.keyCode === 13) {
                Register.register();
            } 
        });
        
        // 表单错误状态
        $("input[type=text], input[type=password], textarea").blur(function () {
            $(this).removeClass("input-error");
        });
        
        $("#userName").focus();
    }
};