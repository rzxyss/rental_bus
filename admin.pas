unit admin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Grids, DBGrids, SMDBGrid, SMDBCtrl, StdCtrls, Mask, DBCtrls,
  SMDBComb;

type
  TfAdmin = class(TForm)
    Image1: TImage;
    zq_akun: TZQuery;
    ds_akun: TDataSource;
    dg_akun: TSMDBGrid;
    nav_akun: TSMDBNavigator;
    dg_bus: TSMDBGrid;
    nav_bus: TSMDBNavigator;
    ds_bus: TDataSource;
    zq_bus: TZQuery;
    dg_penyewaan: TSMDBGrid;
    nav_penyewaan: TSMDBNavigator;
    ds_penyewaa: TDataSource;
    zq_penyewaan: TZQuery;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    edName: TEdit;
    edTelp: TEdit;
    edAlamat: TEdit;
    edUsername: TEdit;
    edPassword: TEdit;
    edRole: TEdit;
    dbeNama: TDBEdit;
    dbeTelp: TDBEdit;
    dbeAlamat: TDBEdit;
    dbeUsername: TDBEdit;
    dbePassword: TDBEdit;
    dbeRole: TDBEdit;
    akunSubmit: TButton;
    akunReset: TButton;
    akunHapus: TButton;
    edNamabus: TEdit;
    edKapasitas: TEdit;
    edHarga: TEdit;
    edStatus: TEdit;
    dbeNamabus: TDBEdit;
    dbeKapasitas: TDBEdit;
    dbeHarga: TDBEdit;
    dbeStatus: TDBEdit;
    busSubmit: TButton;
    busReset: TButton;
    busHapus: TButton;
    cbAkun: TSMDBComboBox;
    cbBus: TSMDBComboBox;
    pStatus: TEdit;
    edTSewa: TEdit;
    edTKembali: TEdit;
    dbePStatus: TDBEdit;
    penyewaanSubmit: TButton;
    penyewaanReset: TButton;
    penyewaanHapus: TButton;
    procedure FormShow(Sender: TObject);
    procedure akunSubmitClick(Sender: TObject);
    procedure akunResetClick(Sender: TObject);
    procedure busSubmitClick(Sender: TObject);
    procedure busResetClick(Sender: TObject);
    procedure akunHapusClick(Sender: TObject);
    procedure busHapusClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAdmin: TfAdmin;

implementation
uses login;
{$R *.dfm}

procedure TfAdmin.FormShow(Sender: TObject);
begin
  zq_akun.Active := True;
  zq_bus.Active := True;
  zq_penyewaan.Active := True;
end;

procedure TfAdmin.akunSubmitClick(Sender: TObject);
begin
  if not fLogin.zconn.Connected then
    fLogin.zconn.Connected := True;

    zq_akun.SQL.Clear;
    zq_akun.SQL.Add(
      'INSERT INTO akun (nama, telp, alamat, username, password, role) ' +
      'VALUES (:nama, :telp, :alamat, :uname, :pass, :role)'
    );
    zq_akun.Params.ParamByName('nama').AsString := edName.Text;
    zq_akun.Params.ParamByName('telp').AsString := edTelp.Text;
    zq_akun.Params.ParamByName('alamat').AsString := edAlamat.Text;
    zq_akun.Params.ParamByName('uname').AsString := edUsername.Text;
    zq_akun.Params.ParamByName('pass').AsString := edPassword.Text;
    zq_akun.Params.ParamByName('role').AsString := edRole.Text;

    try
      zq_akun.ExecSQL;
      ShowMessage('Akun berhasil ditambahkan!');
    except
      on E: Exception do
        ShowMessage('Error: ' + E.Message);
    end;

    zq_akun.Close;
    zq_akun.SQL.Clear;
    zq_akun.SQL.Add('SELECT * FROM akun');
    zq_akun.Open;

    edName.Clear;
    edTelp.Clear;
    edAlamat.Clear;
    edUsername.Clear;
    edPassword.Clear;
    edRole.Clear;
end;

procedure TfAdmin.akunResetClick(Sender: TObject);
begin
  edName.Clear;
  edTelp.Clear;
  edAlamat.Clear;
  edUsername.Clear;
  edPassword.Clear;
  edRole.Clear;
end;

procedure TfAdmin.busSubmitClick(Sender: TObject);
begin
  if not fLogin.zconn.Connected then
    fLogin.zconn.Connected := True;

    zq_bus.SQL.Clear;
    zq_bus.SQL.Add(
      'INSERT INTO bus (nama_bus, kapasitas, harga_sewa_per_hari, status) ' +
      'VALUES (:nama, :kapasitas, :harga, :status)'
    );
    zq_bus.Params.ParamByName('nama').AsString := edNamabus.Text;
    zq_bus.Params.ParamByName('kapasitas').AsString := edKapasitas.Text;
    zq_bus.Params.ParamByName('harga').AsString := edHarga.Text;
    zq_bus.Params.ParamByName('status').AsString := edStatus.Text;

    try
      zq_bus.ExecSQL;
      ShowMessage('Bus berhasil ditambahkan');
    except
      on E: Exception do
        ShowMessage('Error : ' + E.Message);
    end;

    zq_bus.Close;
    zq_bus.SQL.Clear;
    zq_bus.SQL.Add('SELECT * FROM bus');
    zq_bus.Open;

    edNamabus.Clear;
    edKapasitas.Clear;
    edHarga.Clear;
    edStatus.Clear;
end;

procedure TfAdmin.busResetClick(Sender: TObject);
begin
  edNamabus.Clear;
  edKapasitas.Clear;
  edHarga.Clear;
  edStatus.Clear;
end;

procedure TfAdmin.akunHapusClick(Sender: TObject);
var
  id: Integer;
begin
  if zq_akun.FieldByName('id').IsNull then
  begin
    ShowMessage('Pilih akun yang akan di hapus');
    Exit;
  end;

  id := zq_akun.FieldByName('id').AsInteger;

  zq_akun.SQL.Clear;
  zq_akun.SQL.Add('DELETE FROM akun WHERE id = :id');
  zq_akun.Params.ParamByName('id').AsInteger := id;

  try
    zq_akun.ExecSQL;
    ShowMessage('Akun berhasil dihapus');
  except
    on E: Exception do
      ShowMessage('Error : ' + E.Message);
  end;

  zq_akun.Close;
  zq_akun.SQL.Clear;
  zq_akun.SQL.Add('SELECT * FROM akun');
  zq_akun.Open;
end;

procedure TfAdmin.busHapusClick(Sender: TObject);
var
  id: Integer;
begin
  if zq_bus.FieldByName('id').IsNull then
  begin
    ShowMessage('Pilih bus yang akan di hapus');
    Exit;
  end;

  id := zq_bus.FieldByName('id').AsInteger;

  zq_bus.SQL.Clear;
  zq_bus.SQL.Add('DELETE FROM bus WHERE id = :id');
  zq_bus.Params.ParamByName('id').AsInteger := id;

  try
    zq_bus.ExecSQL;
    ShowMessage('Bus berhasil dihapus');
  except
    on E: Exception do
      ShowMessage('Error : ' + E.Message);
  end;

  zq_bus.Close;
  zq_bus.SQL.Clear;
  zq_bus.SQL.Add('SELECT * FROM bus');
  zq_bus.Open;
end;

end.
