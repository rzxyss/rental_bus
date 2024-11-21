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
    pStatus: TEdit;
    edTSewa: TEdit;
    edTKembali: TEdit;
    dbePStatus: TDBEdit;
    penyewaanSubmit: TButton;
    penyewaanReset: TButton;
    penyewaanHapus: TButton;
    zq_penyewaanid: TIntegerField;
    zq_penyewaanid_akun: TIntegerField;
    zq_penyewaanid_bus: TIntegerField;
    zq_penyewaantanggal_sewa: TDateField;
    zq_penyewaantanggal_kembali: TDateField;
    zq_penyewaanstatus: TStringField;
    zq_penyewaancreated_at: TDateTimeField;
    zq_penyewaanupdated_at: TDateTimeField;
    zq_akunid: TIntegerField;
    zq_akunnama: TStringField;
    zq_akuntelp: TStringField;
    zq_akunalamat: TStringField;
    zq_akunusername: TStringField;
    zq_akunpassword: TStringField;
    zq_akunrole: TStringField;
    zq_akuncreated_at: TDateTimeField;
    zq_akunupdated_at: TDateTimeField;
    zq_penyewaanakun: TStringField;
    zq_penyewaanbus: TStringField;
    cb_akun: TDBLookupComboBox;
    cb_bus: TDBLookupComboBox;
    btnLogout: TButton;
    procedure FormShow(Sender: TObject);
    procedure akunSubmitClick(Sender: TObject);
    procedure akunResetClick(Sender: TObject);
    procedure busSubmitClick(Sender: TObject);
    procedure busResetClick(Sender: TObject);
    procedure akunHapusClick(Sender: TObject);
    procedure busHapusClick(Sender: TObject);
    procedure penyewaanSubmitClick(Sender: TObject);
    procedure penyewaanResetClick(Sender: TObject);
    procedure penyewaanHapusClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
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

procedure TfAdmin.penyewaanSubmitClick(Sender: TObject);
var
  akunID, busID : Integer;
begin
  if not zq_akun.Active and not zq_bus.Active then
  begin
    zq_akun.SQL.Clear;
    zq_bus.SQL.Clear;
    zq_akun.SQL.Add('SELECT * FROM akun');
    zq_bus.SQL.Add('SELECT * FROM bus');
    zq_akun.Open;
    zq_bus.Open;
  end;

  if VarIsNull(cb_akun.KeyValue) then
  begin
    ShowMessage('Silakan pilih akun terlebih dahulu.');
    Exit;
  end;

  if VarIsNull(cb_bus.KeyValue) then
  begin
    ShowMessage('Silakan pilih bus terlebih dahulu.');
    Exit;
  end;

  begin
    akunID := cb_akun.KeyValue;
    busID := cb_bus.KeyValue;

    ShowMessage('Akun Yang Dipilih: ' + IntToStr(akunID));
    ShowMessage('Bus Yang Dipilih: ' + IntToStr(busID));
  end;

  if zq_akun.Locate('id', cb_akun.KeyValue, []) then
  begin
    if zq_bus.Locate('id', cb_bus.KeyValue, []) then
    begin
      zq_penyewaan.SQL.Clear;
      zq_penyewaan.SQL.Add(
        'INSERT INTO penyewaan (id_akun, id_bus, tanggal_sewa, tanggal_kembali, status) ' +
        'VALUES (:id_akun, :id_bus, :sewa, :kembali, :status)'
      );
      zq_penyewaan.Params.ParamByName('id_akun').AsInteger := akunID;
      zq_penyewaan.Params.ParamByName('id_bus').AsInteger := busID;
      zq_penyewaan.Params.ParamByName('sewa').AsString := edTSewa.Text;
      zq_penyewaan.Params.ParamByName('kembali').AsString := edTKembali.Text;
      zq_penyewaan.Params.ParamByName('status').AsString := pStatus.Text;

      try
        zq_penyewaan.ExecSQL;
        ShowMessage('Penyewaan berhasil ditambahkan');
      except
        on E: Exception do
          ShowMessage('Error : ' + E.Message);
      end;

      zq_penyewaan.Close;
      zq_penyewaan.SQL.Clear;
      zq_penyewaan.SQL.Add('SELECT * FROM penyewaan');
      zq_penyewaan.Open;

      edTSewa.Clear;
      edTKembali.Clear;
      pStatus.Clear;
    end
    else
    begin
      ShowMessage('Bus tidak ditemukan dengan ID: ' + VarToStr(cb_bus.KeyValue));
    end;
  end
  else
  begin
    ShowMessage('Akun tidak ditemukan dengan ID: ' + VarToStr(cb_akun.KeyValue));
  end;
end;

procedure TfAdmin.penyewaanResetClick(Sender: TObject);
begin
  edTSewa.Clear;
  edTKembali.Clear;
  pStatus.Clear;
end;

procedure TfAdmin.penyewaanHapusClick(Sender: TObject);
var
  id : Integer;
begin
  if zq_penyewaan.FieldByName('id').IsNull then
  begin
    ShowMessage('Pilih penyewaan yang akan di hapus');
    Exit;
  end;

  id := zq_penyewaan.FieldByName('id').AsInteger;

  zq_penyewaan.SQL.Clear;
  zq_penyewaan.SQL.Add('DELETE FROM penyewaan WHERE id = :id');
  zq_penyewaan.Params.ParamByName('id').AsInteger := id;

  try
    zq_penyewaan.ExecSQL;
    ShowMessage('Penyewaan berhasil dihapus');
  except
    on E: Exception do
      ShowMessage('Error : ' + E.Message);
  end;

  zq_penyewaan.Close;
  zq_penyewaan.SQL.Clear;
  zq_penyewaan.SQL.Add('SELECT * FROM penyewaan');
  zq_penyewaan.Open;
end;

procedure TfAdmin.btnLogoutClick(Sender: TObject);
begin
  if MessageDlg('Apakah Anda yakin ingin logout?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    fAdmin.Hide;

    fLogin.Show;

    fLogin.edUname.Text := '';
    fLogin.edPass.Text := '';

    fLogin.edUname.SetFocus;

    MessageDlg('Anda berhasil logout.', mtInformation, [mbOK], 0);
  end;
end;

end.
