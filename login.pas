unit login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Provider, DB, DBClient,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection, Buttons;

type
  TfLogin = class(TForm)
    background: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edUname: TEdit;
    edPass: TEdit;
    Label4: TLabel;
    zconn: TZConnection;
    zq_login: TZQuery;
    ds_login: TDataSource;
    btnLogin: TBitBtn;
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fLogin: TfLogin;
  i, z: Integer;
  a, b, c: string;

implementation
uses customer, admin;
{$R *.dfm}

procedure TfLogin.btnLoginClick(Sender: TObject);
begin
  for i := 1 to zq_login.RecordCount do
  begin
    a := zq_login['role'];
    b := zq_login['username'];
    c := zq_login['password'];

    if ((edUname.Text = b) and (edPass.Text = c) and (a = 'admin')) then
    begin
      z := 1;
    end
    else if ((edUname.Text = b) and (edPass.Text = c) and (a = 'customer')) then
    begin
      z := 2;
    end
    else
    begin
      zq_login.Next;
    end;

    if z = 1 then
    begin
      MessageDlg('Selamat datang admin', mtInformation, [mbOK], 0);
      fLogin.Hide;
      fAdmin.Show;
      Break;
    end
    else if z = 2 then
    begin
      MessageDlg('Selamat datang customer', mtInformation, [mbOK], 0);
      fLogin.Hide;
      fCustomer.Show;
      Break;
    end;
  end;
end;

end.
