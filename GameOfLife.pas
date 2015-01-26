unit GameOfLife;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, GameOfLifeUtils,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TMainForm = class(TForm)
    MainGrid: TDrawGrid;
    StatusBar1: TStatusBar;
    PeriodTimer: TTimer;
    ButtonPanel: TPanel;
    StartButton: TButton;
    PauseButton: TButton;
    TimeDurationSpinEdit: TSpinEdit;
    PeriodLabel: TLabel;
    ResetButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MainGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure PeriodTimerTimer(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure PauseButtonClick(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
  private
    CurrentTimeValue: Integer;
    { Private declarations }
  public
    Cells: TAutomataCellArray;
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TGameOfLifeUtils.ResizeGrid(MainForm, MainGrid);
  TGameOfLifeUtils.PopulateCellArray(MainGrid, Cells);
  PeriodTimer.Interval := TimeDurationSpinEdit.Value;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  TGameOfLifeUtils.ResizeGrid(MainForm, MainGrid);
  TGameOfLifeUtils.PopulateCellArray(MainGrid, Cells);
end;

procedure TMainForm.MainGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  BrushColor: TColor;
begin
  if Cells[ARow, ACol].IsAlive then
    BrushColor := clBlack
  else
    BrushColor := clWhite;

  MainGrid.Canvas.Brush.Color := BrushColor;
  MainGrid.Canvas.FillRect(Rect);
end;

procedure TMainForm.PauseButtonClick(Sender: TObject);
begin
  PeriodTimer.Enabled := False;
end;

procedure TMainForm.ResetButtonClick(Sender: TObject);
begin
  TGameOfLifeUtils.PopulateCellArray(MainGrid, Cells);
  MainGrid.Repaint;
end;

procedure TMainForm.StartButtonClick(Sender: TObject);
begin
  PeriodTimer.Enabled := True;
end;

procedure TMainForm.PeriodTimerTimer(Sender: TObject);
var
  Row, Col, AliveCount, DeadCount, TotalCount: Integer;
  CellIsAlive: Boolean;
begin
  PeriodTimer.Interval := TimeDurationSpinEdit.Value;
  AliveCount := 0;
  DeadCount := 0;
  TotalCount := MainGrid.RowCount * MainGrid.ColCount;

  for Row := 0 to MainGrid.RowCount - 1 do
  begin
    for Col := 0 to MainGrid.ColCount - 1 do
    begin
      CellIsAlive := TGameOfLifeUtils.StaysAlive(MainGrid, MainForm.Cells, MainForm.Cells[Row, Col]);
      MainForm.Cells[Row, Col].IsAlive := CellIsAlive;
      if CellIsAlive then
        AliveCount := AliveCount + 1;
    end;
  end;
  DeadCount := TotalCount - AliveCount;
  StatusBar1.SimpleText := Format('Alive: %d Dead: %d Columns: %d Rows: %d (%d cells)', [AliveCount, DeadCount, MainGrid.ColCount, MainGrid.RowCount, TotalCount]);
  MainGrid.Repaint;
end;

end.
