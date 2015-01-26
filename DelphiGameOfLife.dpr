program DelphiGameOfLife;

uses
  Vcl.Forms,
  GameOfLife in 'GameOfLife.pas' {MainForm},
  DrawingUtils in 'DrawingUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
