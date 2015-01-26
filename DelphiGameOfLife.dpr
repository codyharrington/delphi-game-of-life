program DelphiGameOfLife;

uses
  Vcl.Forms,
  GameOfLife in 'GameOfLife.pas' {MainForm},
  GameOfLifeUtils in 'GameOfLifeUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
