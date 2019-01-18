unit UFrmLogin;

interface

uses
    Winapi.Windows, System.SysUtils, System.Variants, System.Classes, Vcl.Controls,
    Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ActnList, Vcl.ActnMan, Vcl.Buttons,
    System.Actions, Vcl.PlatformDefaultStyleActnCtrls, Vcl.Imaging.pngimage,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
    cxEdit, Data.DB, cxTextEdit, cxDropDownEdit, MidasLib;

type
    TfrmLogin  =  class(TForm)
        ImageLogin: TImage;
        txt_senha: TEdit;
        Label1: TLabel;
        Senha: TLabel;
        txt_usuario: TEdit;
        ActionManager1: TActionManager;
        btn_entrar: TAction;
        btn_sair: TAction;
        SpeedButton1: TSpeedButton;
        SpeedButton2: TSpeedButton;
        procedure btn_entrarExecute(Sender: TObject);
        procedure btn_sairExecute(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
    private
    { Private declarations }
    public
    { Public declarations }
        function CrySenha(Snh: string): string;
    end;

var
    frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses
    UDataModule;

function TfrmLogin.CrySenha(Snh: string): string;
var
    I: Integer;
begin
    for I  :=  1 to Length(Snh) do
        Result  :=  Result  +  Chr((Ord(Snh[I])  +  57));
end;

procedure TfrmLogin.btn_entrarExecute(Sender: TObject);
begin
    DM.cdslogin.Close;
    DM.cdslogin.ParamByName('USUARIO').Value  :=  txt_usuario.Text;
    DM.cdslogin.ParamByName('SENHA').Value  :=  CrySenha(txt_senha.Text);
    DM.cdslogin.Open;
    if DM.cdslogin.IsEmpty then
    begin
        Application.MessageBox('Usuário ou Senha Inválidos!', 'ERRO!', MB_APPLMODAL  +  MB_ICONEXCLAMATION  +  MB_OK  +  MB_DEFBUTTON1);
        txt_usuario.Text  :=  '';
        txt_senha.Text  :=  '';
        txt_usuario.SetFocus;
    end
    else
    begin
        frmLogin.close;

    end;
end;

procedure TfrmLogin.btn_sairExecute(Sender: TObject);
begin
    Application.Terminate;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action  :=  caFree;

end;

end.

