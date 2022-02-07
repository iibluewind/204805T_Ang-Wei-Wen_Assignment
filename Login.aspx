<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="_204805T_Ang_Wei_Wen_Assignment.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://www.google.com/recaptcha/api.js?render="></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lblemail" runat="server" Text="Email: "></asp:Label>
            <asp:TextBox ID="tbemail" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="lblpassword" runat="server" Text="Password: "></asp:Label>
            <asp:TextBox ID="tbpassword" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="lbl_wrong" runat="server"></asp:Label>
            <br />
            <asp:Button ID="btnlogin" runat="server" OnClick="btnlogin_Click" Text="Login" />
        </div>
    </form>
    <br />
    <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/>
    <script>
         grecaptcha.ready(function () {
             grecaptcha.execute('', { action: 'login' }).then(function (token) {
             document.getElementById("g-recaptcha-response").value = token;
             });
         });
    </script>
</body>
</html>
