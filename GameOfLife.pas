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
    RandomiseButton: TButton;
    ClearButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MainGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure PeriodTimerTimer(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure PauseButtonClick(Sender: TObject);
    procedure RandomiseButtonClick(Sender: TObject);
    procedure MainGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure ClearButtonClick(Sender: TObject);
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

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
  TGameOfLifeUtils.GenocideCells(MainGrid, Cells);
  MainGrid.Canvas.Refresh;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TGameOfLifeUtils.ResizeGrid(MainForm, MainGrid);
  TGameOfLifeUtils.PopulateCellArray(MainGrid, Cells);
  TGameOfLifeUtils.RandomiseCells(MainGrid, Cells);
  PeriodTimer.Interval := TimeDurationSpinEdit.Value;
end;

procedure TMainForm.FormResize(Sender: TObject);
var
  TimerState: Boolean;
begin
  TimerState := PeriodTimer.Enabled;
  PeriodTimer.Enabled := False;
  TGameOfLifeUtils.ResizeGrid(MainForm, MainGrid);
  TGameOfLifeUtils.PopulateCellArray(MainGrid, Cells);
  PeriodTimer.Enabled := TimerState;
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

procedure TMainForm.MainGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var
  BrushColor: TColor;
begin
  case Cells[ARow, ACol].IsAlive of
    True:
      begin
        Cells[ARow, ACol].IsAlive := False;
        BrushColor := clWhite;
      end;
    False:
      begin
        Cells[ARow, ACol].IsAlive := True;
        BrushColor := clBlack;
      end;
  end;
  MainGrid.Canvas.Brush.Color := BrushColor;
  MainGrid.Canvas.FillRect(MainGrid.CellRect(ACol, ARow));
  MainGrid.Repaint;
end;

procedure TMainForm.PauseButtonClick(Sender: TObject);
begin
  PeriodTimer.Enabled := False;
end;

procedure TMainForm.RandomiseButtonClick(Sender: TObject);
begin
  TGameOfLifeUtils.RandomiseCells(MainGrid, Cells);
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
  CellArrayCopy: TAutomataCellArray;
begin
  PeriodTimer.Interval := TimeDurationSpinEdit.Value;
  AliveCount := 0;
  DeadCount := 0;
  TotalCount := MainGrid.RowCount * MainGrid.ColCount;
  CellArrayCopy := Copy(MainForm.Cells);

  for Row := 0 to MainGrid.RowCount - 1 do
  begin
    for Col := 0 to MainGrid.ColCount - 1 do
    begin
      CellIsAlive := TGameOfLifeUtils.StaysAlive(MainGrid, CellArrayCopy, Row, Col);
      MainForm.Cells[Row, Col].IsAlive := CellIsAlive;
      if CellIsAlive then
        AliveCount := AliveCount + 1;
    end;
  end;
  DeadCount := TotalCount - AliveCount;
  StatusBar1.SimpleText := Format('Alive: %d Dead: %d Columns: %d Rows: %d (%d cells)',
    [AliveCount, DeadCount, MainGrid.ColCount, MainGrid.RowCount, TotalCount]);
  MainGrid.Repaint;
end;

end.
