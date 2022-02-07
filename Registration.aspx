<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="_204805T_Ang_Wei_Wen_Assignment.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function validate() {
            var str = document.getElementById('<%=tbpassword.ClientID %>').value;
            if (str.length < 12) {
                document.getElementById("lbl_check").innerHTML = "password must be atleast 12 char"
                return("too_short")
            }
            if (str.search(/[0-9]/) == -1) {
                document.getElementById("lbl_check").innerHTML = "password must have atleast 1 number"
                
            }
            if (str.search(/[A-Z+]/) == -1) {
                document.getElementById("lbl_check").innerHTML = "password must have atleast 1 Capital letter"
                
            }
            if (str.search(/[a-z+]/) == -1) {
                document.getElementById("lbl_check").innerHTML = "password must have atleast 1 small letter"

            }
            if (str.search(/[\W+]/) == -1) {
                document.getElementById("lbl_check").innerHTML = "password must have atleast 1 special char"
                
            }
            else { document.getElementById("lbl_check").innerHTML = "suiiii"}
            
        }
    </script>
    <script src="https://www.google.com/recaptcha/api.js?render=6Ld-S2IeAAAAADelbburwkMS-zlm47sJeoWsdEB6"></script>
    <style type="text/css">
        .auto-style1 {
            width: 150px;
            text-align: right;
            float: left;

        }
        .auto-style2 {
            width: 570px;
            float: left;
            text-align: left;
            height: 291px;
        }
        .auto-style3 {
            height: 351px;
        }
    </style>
</head>
<body style="height: 350px">
    <form id="form1" runat="server" class="auto-style3">
        <div class="auto-style1">
            <asp:Label ID="lbl_firstname" runat="server" Text="First Name: "></asp:Label>
            <br />
            <br />
            <asp:Label ID="lbl_lastname" runat="server" Text="Last Name: "></asp:Label>
            <br />
            <br />
            <asp:Label ID="lbl_card" runat="server" Text="Card Number: "></asp:Label>
            <br />
            <br />
            <asp:Label ID="lbl_Email" runat="server" Text="Email: "></asp:Label>
            <br />
            <br />
            <asp:Label ID="lbl_password" runat="server" Text="Password: "></asp:Label>
            <br />
            <br />
            <asp:Label ID="lbl_DOB" runat="server" Text="Date of birth: "></asp:Label>
            <br />
            <br />
            <asp:Label ID="lbl_photo" runat="server" Text="Photo: "></asp:Label>
            <br />
            <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbpassword" ErrorMessage="Password Complexity - Weak" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{12,}"></asp:RegularExpressionValidator>
        </div>
        <div class="auto-style2">
            <asp:TextBox ID="tb_firstname" runat="server" Height="16px"></asp:TextBox>
            <br />
            <br />
            <asp:TextBox ID="tb_lastname" runat="server" Height="16px"></asp:TextBox>
            <br />
            <br />
            <asp:TextBox ID="tb_cardnumber" runat="server" Height="16px" MaxLength="16"></asp:TextBox>
            <br />
            <br />
            <asp:TextBox ID="tbemail" runat="server" Height="16px"></asp:TextBox>
            <br />
            <br />
            <asp:TextBox ID="tbpassword" runat="server" Height="16px" onkeyup="javascript:validate()"></asp:TextBox>
            <asp:Label ID="lbl_check" runat="server" Text="check"></asp:Label>
            <br />
            <br />
            <asp:TextBox ID="tbDOB" runat="server" Height="16px"></asp:TextBox>
            <br />
            <br />
            <asp:FileUpload ID="photoupload" runat="server" />
        </div>
    </form>
    <br />
    <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/>
    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('6Ld-S2IeAAAAADelbburwkMS-zlm47sJeoWsdEB6', { action: 'registration' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
</body>
</html>
