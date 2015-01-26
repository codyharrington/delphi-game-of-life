unit GameOfLife;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, GameOfLifeUtils,
  Vcl.ComCtrls;

type
  TMainForm = class(TForm)
    MainGrid: TDrawGrid;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MainGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure Timer1Timer(Sender: TObject);
  private
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
var
  Cols: Integer;
begin
  TGameOfLifeUtils.ResizeGrid(MainForm, MainGrid);
  TGameOfLifeUtils.PopulateCellArray(MainGrid, Cells);

  MainGrid.Canvas.Brush.Color := clBlack;
  Timer1.Interval := 1000;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  TGameOfLifeUtils.ResizeGrid(MainForm, MainGrid);
  TGameOfLifeUtils.PopulateCellArray(MainGrid, Cells);
end;

procedure TMainForm.MainGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  SelectedRect: TGridRect;
begin
  SelectedRect := MainGrid.Selection;
  StatusBar1.SimpleText := Format('Selected rectangle: (%d, %d) (%d, %d)', [SelectedRect.TopLeft.X, SelectedRect.TopLeft.Y,
    SelectedRect.BottomRight.X, SelectedRect.BottomRight.Y]);
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  Row, Col: Integer;
  CellIsAlive: Boolean;
begin
  // Check the cell array then redraw the grid based on this
  for Row := 0 to MainGrid.RowCount - 1 do
    for Col := 0 to MainGrid.ColCount - 1 do
      CellIsAlive := TGameOfLifeUtils.StaysAlive(MainGrid, MainForm.Cells, MainForm.Cells[Row, Col]);
      MainForm.Cells[Row, Col].IsAlive := CellIsAlive;
      if CellIsAlive then
      begin
        // Paint cell here
      end;
end;

end.
