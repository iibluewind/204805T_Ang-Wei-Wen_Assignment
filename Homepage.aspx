<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Homepage.aspx.cs" Inherits="_204805T_Ang_Wei_Wen_Assignment.Homepage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lbl_welcome" runat="server" Text="Welcome: "></asp:Label>
            &nbsp;
            <asp:Label ID="lbl_user" runat="server" Text="username"></asp:Label>
            <br />
            <asp:Label ID="lbl_welcome0" runat="server" Text="Card number: "></asp:Label>
            <asp:Label ID="lbl_cardnumber" runat="server" Text="card"></asp:Label>
            <br />
            <asp:Button ID="btnlogout" runat="server" OnClick="btnlogout_Click" Text="Logout" />
            <asp:Button ID="btnError" runat="server" OnClick="btnerror_Click" Text="To go error page" />
            <asp:Label ID="Label1" runat="server" Text="WARNING: this button is only for demo purpose"></asp:Label>
        </div>
    </form>
</body>
</html>
