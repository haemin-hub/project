<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String kakaoClientId = "c7ceeb58d858498a39068ce0c31eade5";
    String kakaoRedirectUri = "http://localhost:8080/oauth/kakao/callback";
    String kakaoLoginUrl = "https://kauth.kakao.com/oauth/authorize"
            + "?client_id=" + kakaoClientId
            + "&redirect_uri=" + kakaoRedirectUri
            + "&response_type=code"
            + "&prompt=login";

    String googleClientId = "188733059918-dr0fa08okh76n7omc55h8get2rbsehb2.apps.googleusercontent.com";
    String googleRedirectUri = "http://localhost:8080/oauth/google/callback";
    String googleLoginUrl = "https://accounts.google.com/o/oauth2/v2/auth?"
            + "client_id=" + googleClientId
            + "&redirect_uri=" + googleRedirectUri
            + "&response_type=code"
            + "&scope=openid%20email%20profile";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 선택</title>
    <style>
          body {
                    font-family: 'Nanum Gothic', 'Arial', sans-serif;
                    background-color: #f9f9f9;
                    margin: 0; padding: 0;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                }
                .login-container {
                    background: white;
                    padding: 40px 50px;
                    border-radius: 12px;
                    box-shadow: 0 0 15px rgba(0,0,0,0.1);
                    width: 360px;
                    text-align: center;
                }
                .login-container h1 {
                    font-size: 28px;
                    margin-bottom: 10px;
                    color: #2c3e50;
                }
                .login-container p {
                    color: #555;
                    margin-bottom: 30px;
                    font-size: 15px;
                }
                .login-btn {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    width: 100%;
                    padding: 14px 0;
                    margin-bottom: 15px;
                    font-size: 16px;
                    font-weight: bold;
                    border-radius: 30px;
                    cursor: pointer;
                    text-decoration: none;
                    transition: all 0.3s;
                }
                /* Kakao */
                .kakao-btn {
                    background-color: #FEE500;
                    color: #000000;
                    border: none;
                }
                .kakao-btn:hover {
                    background-color: #ffde00;
                }
                .kakao-icon {
                    width: 24px;
                    height: 24px;
                    margin-right: 12px;
                }
                /* Google */
                .google-btn {
                    background-color: white;
                    color: #444;
                    border: 1px solid #ddd;
                }
                .google-btn:hover {
                    background-color: #f7f7f7;
                }
                .google-icon {
                    width: 22px;
                    height: 22px;
                    margin-right: 12px;
                }
    </style>
</head>
<body>
 <div class="login-container">
     <h1>HealnGo</h1>
     <p>로그인 또는 회원 가입<br>무료로 가입하고 혜택을 누려보세요!</p>

     <!-- 카카오 로그인 -->
     <a href="<%= kakaoLoginUrl %>" class="login-btn kakao-btn">
         <img src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png" alt="Kakao" class="kakao-icon" />
         카카오 계정으로 로그인하기
     </a>

     <!-- 구글 로그인 -->
     <a href="<%= googleLoginUrl %>" class="login-btn google-btn">
         <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google" class="google-icon" />
         구글 계정으로 로그인하기
     </a>
 </div>
</body>
</html>
