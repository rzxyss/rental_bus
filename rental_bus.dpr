program rental_bus;

uses
  Forms,
  login in 'login.pas' {fLogin},
  admin in 'admin.pas' {fAdmin},
  customer in 'customer.pas' {fCustomer};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfLogin, fLogin);
  Application.CreateForm(TfAdmin, fAdmin);
  Application.CreateForm(TfCustomer, fCustomer);
  Application.Run;
end.
