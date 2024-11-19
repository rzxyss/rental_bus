unit customer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls;

type
  TfCustomer = class(TForm)
    background: TImage;
    Label1: TLabel;
    btnLogout: TButton;
    procedure btnLogoutClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCustomer: TfCustomer;

implementation
uses login;
{$R *.dfm}

procedure TfCustomer.btnLogoutClick(Sender: TObject);
begin
  if MessageDlg('Apakah Anda yakin ingin logout?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    fCustomer.Hide;

    fLogin.Show;

    fLogin.edUname.Text := '';
    fLogin.edPass.Text := '';

    fLogin.edUname.SetFocus;

    MessageDlg('Anda berhasil logout.', mtInformation, [mbOK], 0);
  end;
end;

end.
